#!/bin/bash
# this runs through all the scenarios of https://github.com/ddutt/cloud-native-data-center-networking
# it deploys each one, then runs ping to see if it works.
#  then it checks the return code.
#  if it succeeded, then ping will have zero
#  it takes the prefix for log files as an argument
#  run it in the cloud-native-datacenter-networking directory
#   "./check_everything.sh everything"
# egrep "VAGRANT|SCENARIO|RESULT|real|START|END" everything.*
run_scenario () {
    topology="$1"
    proto="$2"
    scenario="$3"
    echo "SCENARIO $topology $proto $scenario"
    pwd
    time sudo ansible-playbook -b -e "scenario=$scenario" deploy.yml
    echo "DEPLOY RESULTS $?"
    sleep 15 #on fast machines, not everything is all the way up without sleep
    sudo ansible-playbook ping.yml
    RESULT=$?
    echo "PING RESULTS $RESULT"
#    if (( $RESULT > 0 )) ; then
#	exit
#    fi
    sudo ansible-playbook -b reset.yml
    echo "RESET RESULTS $?"
    sleep 15 #without sleep, the next run might start to fast and deploy doesn't work
}

run_protos () {
    proto="$1"
    shift 
    scenarios=("$@")
    echo "${scenarios[@]}"

    echo $proto
    cd $proto
    for scenario in "${scenarios[@]}"
    do
	run_scenario $topology $proto $scenario
    done
    cd ..
}

vagrant_down () {
    sudo vagrant destroy -f
    echo "VAGRANT DESTROY RESULTS $?"

}

vagrant_up () {
    sudo vagrant status
    time sudo vagrant up
    echo "VAGRANT UP"
}

run_topology () {
    topology="$1"
    echo $topology
    echo -n "START "
    date
    cd $topology
    vagrant_up
    #evpn needs to run first
    scenarios=(centralized distributed ospf-ibgp)
    run_protos 'evpn' ${scenarios[@]}

    for proto in bgp ospf 
    do
	scenarios=(numbered unnumbered docker)
	run_protos $proto ${scenarios[@]}
    done
    vagrant_down
    cd ../..
    echo -n "END "
    date

}
log="$1"
echo $log
for topology in dual-attach  single-attach
do
    run_topology topologies/$topology > $log.$topology.log 2>&1 &
done
		

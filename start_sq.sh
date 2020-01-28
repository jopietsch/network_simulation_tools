rm /tmp/suzieq.log
while true
do
    sudo python3 genhosts.py ~/cloud-native-data-center-networking/topologies/dual-attach/.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory dual dual
    sudo python3 genhosts.py ~/cloud-native-data-center-networking/topologies/single-attach/.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory single single
    cat dual > hosts
    echo >> hosts
    cat single >> hosts

    python3 sq-poller.py -f -H hosts &
    sleep 180
    pkill -f sq-poller.py

done

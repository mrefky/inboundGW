# inboundGW



*	“Inbound GW” will receive application messages from the client and send these messages to Kafka inbound topic.


# To install do the following steps

* run git clone https://github.com/mrefky/inboundGW.git
* cd ./inboundGW
* chmod a+x *.sh
* microk8s.kubectl delete sts,deploy,pvc,svc,cm --all
* run ./build.sh



# Statefullsets

![Arch](./Stat1.jpg?raw=true "Arch")

# Pods

![Arch](./po.jpg?raw=true "Arch")

# Services

![Arch](./svc.jpg?raw=true "Arch")

# Config Maps

![Arch](./cm.jpg?raw=true "Arch")




# Connection Parameters


* IP=192.168.169.62
* Port=5001
* TargetCompID=CASE
* SenderCompID=01001


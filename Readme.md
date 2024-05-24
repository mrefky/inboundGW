# inboundGW



*	“Inbound GW” will receive application messages from the client and send these messages to Kafka inbound topic.


# To install do the following steps

* run git clone https://github.com/mrefky/inboundGW.git
* cd ./inboundGW
* chmod a+x *.sh
* microk8s.kubectl delete sts,deploy,pvc,svc,cm --all
* run ./build.sh



# Statefullsets

![STS](./sts.jpg?raw=true "Sts")

# Pods

![Pods](./po.jpg?raw=true "po")

# Services

![Svc](./svc.jpg?raw=true "Svc")

# Config Maps

![CM](./cm.jpg?raw=true "cm")




# Connection Parameters


* IP=192.168.169.62
* Port=5001
* TargetCompID=CASE
* SenderCompID=01001


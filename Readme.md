# inboundGW



*	“Inbound GW” will receive application messages from the client and send these messages to Kafka inbound topic.


# To install do the following steps

* If microk8s is not installed then use re_install.sh to iinstall it with all required addons.
* use microk8s.inspect to see if there is anything needs corrections and follow the results.
* install docker if it is not installed (./install_docker.sh).
* install helm if not installed (./get_helm.sh && repo.sh).
* install k9s if it is not installed (./install_k9s.sh).
* install kafka offset explorer if not installed.
* git clone https://github.com/mrefky/inboundGW.git
* cd ./inboundGW
* chmod a+x *.sh
* microk8s.kubectl delete sts,deploy,pvc,svc,cm --all
* ./build.sh



# Statefullsets

![STS](./sts.jpg?raw=true "Sts")

# Pods

![Pods](./po.jpg?raw=true "po")

# Services

![Svc](./svc.jpg?raw=true "Svc")

# Config Maps

![CM](./cm.jpg?raw=true "cm")

# Offset-Explorer

![offset](offset_explorer.jpg)

# Testing

![STS](./orders.jpg?raw=true "Sts")


# Connection Parameters


* IP=192.168.169.62
* Port=5001
* TargetCompID=CASE
* SenderCompID=01001


microk8s.kubectl delete configmap inboundgw-config
microk8s.kubectl create configmap inboundgw-config --from-file=/home/mrefky/Thunder/InboudGW/executor.cfg

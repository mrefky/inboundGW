#!/bin/bash
microk8s kubectl delete sts,pvc,cm,svc,po --all
microk8s.kubectl wait pod --all --for=condition=Ready  --all-namespaces
./delete_kafka.sh
microk8s.kubectl wait pod --all --for=condition=Ready  --all-namespaces
./install_kafka.sh
microk8s.kubectl wait pod --all --for=condition=Ready  --all-namespaces
./reset0.sh
microk8s kubectl delete -f ./InboundGW.yaml
microk8s.kubectl wait pod --all --for=condition=Ready
go mod tidy
go build .
./create_inboundgw.sh
sudo docker build -t localhost:32000/inboundgw  .
sudo docker push localhost:32000/inboundgw
sleep 1
microk8s kubectl create -f ./InboundGW.yaml
microk8s.kubectl wait pod --all --for=condition=Ready  --all-namespaces
./expose.sh
#sleep 1
#microk8s.kubectl logs -f inboundgw-0

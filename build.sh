#!/bin/bash
microk8s kubectl delete sts,pvc,cm,svc,po --all
microk8s.kubectl wait pod --all --for=condition=Ready  --all-namespaces
microk8s kubectl delete -f ./InboundGW.yaml
microk8s.kubectl wait pod --all --for=condition=Ready  --all-namespaces
./delete_kafka.sh
microk8s.kubectl wait pod --all --for=condition=Ready  --all-namespaces
./install_kafka.sh
microk8s.kubectl wait pod --all --for=condition=Ready  --all-namespaces
./reset0.sh
go build .
./create_inboundgw.sh
docker build -t localhost:32000/inboundgw  .
docker push localhost:32000/inboundgw
sleep 1
microk8s kubectl create -f ./InboundGW.yaml
microk8s.kubectl wait pod --all --for=condition=Ready  --all-namespaces
./expose.sh

#!/bin/bash
microk8s kubectl delete -f ./InboundGW.yaml
./delete_kafka.sh
./install_kafka.sh
./reset0.sh
go build .
./create_inboundgw.sh
docker build -t localhost:32000/inboundgw  .
docker push localhost:32000/inboundgw
sleep 1
microk8s kubectl create -f ./InboundGW.yaml
microk8s kubectl wait pods inboundgw-0  --for condition=Ready --timeout=90s
./expose.sh

microk8s kubectl delete -f /home/mrefky/Thunder/InboudGW/InboundGW.yaml
./delete_kafka.sh
./install_kafka.sh
./reset0.sh
go build .
/home/mrefky/Thunder/InboudGW/create_inboundgw.sh
docker build -t localhost:32000/inboundgw  /home/mrefky/Thunder/InboudGW/.
docker push localhost:32000/inboundgw
sleep 1
microk8s kubectl create -f /home/mrefky/Thunder/InboudGW/InboundGW.yaml
microk8s kubectl wait pods inboundgw-0  --for condition=Ready --timeout=90s
/home/mrefky/Thunder/InboudGW/expose.sh

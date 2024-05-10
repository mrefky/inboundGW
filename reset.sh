microk8s kubectl run kafka-client --restart='Never' --image docker.io/bitnami/kafka:3.4.0-debian-11-r33 --namespace default --command -- sleep infinity
microk8s.kubectl wait pod kafka-client --for=condition=Ready
echo "*******************************"
echo "** Deleating Topics          **"
echo "*******************************"
microk8s kubectl exec -i kafka-client --namespace default -- kafka-topics.sh --bootstrap-server  kafka-0.kafka-headless.default.svc.cluster.local:9092 --topic inbound --delete
microk8s kubectl exec -i kafka-client --namespace default -- kafka-topics.sh --bootstrap-server  kafka-0.kafka-headless.default.svc.cluster.local:9092 --topic outbound --delete
echo "*******************************"
echo "** Creating inbound Topic **"
echo "*******************************"
microk8s kubectl exec -i kafka-client --namespace default -- kafka-topics.sh --bootstrap-server  kafka-0.kafka-headless.default.svc.cluster.local:9092 --topic inbound --create --partitions 10 --replication-factor 3
echo "*******************************"
echo "** Creating outbound Topic **"
echo "*******************************"
microk8s kubectl exec -i kafka-client --namespace default -- kafka-topics.sh --bootstrap-server  kafka-0.kafka-headless.default.svc.cluster.local:9092 --topic outbound --create --partitions 10 --replication-factor 3
echo "*******************************"
echo "** Deleting kafka client **"
echo "*******************************"
microk8s kubectl delete po kafka-client


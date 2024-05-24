#helm install kafka bitnami/kafka --set zookeeper.enabled=false --set replicaCount=3 --set externalZookeeper.servers=zookeeper.default.svc.cluster.local 
#./Nclient.sh
helm install kafka bitnami/kafka --version="22.1.3" \
	  --set zookeeper.enabled=false \
	  --set replicaCount=3 \
 --set  externalAccess.enabled=true \
 --set externalAccess.service.type=LoadBalancer \
 --set deleteTopicEnable=true \
 --set externalAccess.service.port=19092 \
 --set persistence.size=10Gi \
 --set persistence.dataLogDir.size=10Gi \
 --set externalAccess.service.loadBalancerIPs[0]='192.168.169.70' \
 --set externalAccess.service.loadBalancerIPs[1]='192.168.169.71' \
 --set externalAccess.service.loadBalancerIPs[2]='192.168.169.72' 

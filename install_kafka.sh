helm install kafka bitnami/kafka --version="22.1.3" \
	  --set zookeeper.enabled=false \
	  --set replicaCount=3 \
 --set deleteTopicEnable=true \
 --set externalAccess.service.port=19092 \
 --set persistence.size=1Gi \
 --set persistence.dataLogDir.size=1Gi \
 --set global.storageClass=microk8s-hostpath 


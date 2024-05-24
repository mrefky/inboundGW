sudo usermod -a -G microk8s mrefky
sudo chown -f -R mrefky ~/.kube
#su - mrefky
sudo snap remove microk8s --purge 
sudo rm -rf ~/snap/microk8s
sudo snap install microk8s --classic --channel=1.29/stable
microk8s.start
microk8s.status --wait-ready
sudo microk8s.enable dns 
sudo microk8s.enable dashboard 
sudo microk8s.enable storage 
#sudo microk8s.enable openebs 
sudo microk8s.enable helm3 
sudo microk8s.enable registry 
sudo microk8s.enable metallb 192.168.169.50-192.168.169.99 
exit
echo "Now create the cluster then run the below"
#cd ~/Sources/mars/
#./create_mars01.sh
#./cr.sh
#./pod_node.sh 
#microk8s helm3 repo add csi-driver-nfs https://raw.githubusercontent.com/kubernetes-csi/csi-driver-nfs/master/charts
#microk8s helm3 repo update
#microk8s helm3 install csi-driver-nfs csi-driver-nfs/csi-driver-nfs \
#    --namespace kube-system \
#    --set kubeletDir=/var/snap/microk8s/common/var/lib/kubelet
#docker push localhost:32000/csfix
#microk8s kubectl wait pod --selector app.kubernetes.io/name=csi-driver-nfs --for condition=ready --namespace kube-system
#microk8s kubectl get csidrivers
#ssh mrefky@nodea -S ~/re_node_install.sh
#ssh mrefky@nodeb -S ~/re_node_install.sh
sudo iptables -P FORWARD ACCEPT
#microk8s.kubectl get events --all-namespaces  --sort-by='.metadata.creationTimestamp'
#echo "failure-domain=42" > /var/snap/microk8s/current/args/ha-conf
#microk8s.stop
#microk8s.start
#:sudo apt-get install nfs-kernel-server

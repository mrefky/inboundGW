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
sudo iptables -P FORWARD ACCEPT

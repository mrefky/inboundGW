microk8s.kubectl delete services inboundgw-0
microk8s.kubectl delete services inboundgw-1
microk8s.kubectl delete services inboundgw-2
microk8s.kubectl delete services inboundgw-3
microk8s.kubectl delete services inboundgw-4
microk8s.kubectl delete services inboundgw-5
microk8s.kubectl delete services inboundgw-6
microk8s.kubectl delete services inboundgw-7
sleep 1
microk8s.kubectl expose po inboundgw-0  --type LoadBalancer --port 5001,5002,5003 --load-balancer-ip=192.168.169.62
microk8s.kubectl expose po inboundgw-1  --type LoadBalancer --port 5001,5002,5003 --load-balancer-ip=192.168.169.63
microk8s.kubectl expose po inboundgw-2  --type LoadBalancer --port 5001,5002,5003 --load-balancer-ip=192.168.169.64
microk8s.kubectl expose po inboundgw-3  --type LoadBalancer --port 5001,5002,5003 --load-balancer-ip=192.168.169.65
microk8s.kubectl expose po inboundgw-4  --type LoadBalancer --port 5001,5002,5003 --load-balancer-ip=192.168.169.66
microk8s.kubectl expose po inboundgw-5  --type LoadBalancer --port 5001,5002,5003 --load-balancer-ip=192.168.169.67
microk8s.kubectl expose po inboundgw-6  --type LoadBalancer --port 5001,5002,5003 --load-balancer-ip=192.168.169.68
microk8s.kubectl expose po inboundgw-7  --type LoadBalancer --port 5001,5002,5003 --load-balancer-ip=192.168.169.69
microk8s kubectl get services 

# inboundGW



*	“Inbound GW” that will receive application messages from the client and send these messages to Kafka inbound topic.


# To install do the following steps

* run git clone 


# Deployments

![Arch](./deploy.jpg?raw=true "Arch")

# Statefullsets

![Arch](./Stat1.jpg?raw=true "Arch")

# Pods

![Arch](./img2.jpg?raw=true "Arch")

# Services

![Arch](./svc.jpg?raw=true "Arch")

# Config Maps

![Arch](./cm.jpg?raw=true "Arch")


# Test applications

We will publish two c# test applications

* Fixman https://github.com/mrefky/Fixman.git
* client-2 https://github.com/mrefky/client-2.git 

# Connection Parameters

# Client first connection

* IP=192.168.169.62
* Port=5001
* TargetCompID=CASE
* SenderCompID=01001

# Client second connection

* IP=192.168.169.52
* Port=31001
* TargetCompID=CASE2
* SenderCompID=01001

# kafka-ui

http://192.168.169.50:8080


# How to reduce traffic rate
* You dont need to reduce it since

    - The "inbound topic" will not have any issues event if the messages rate is extermely high 
    
    - Reading messages from the inboundgw and sending these messages to the exchange fix gateway will be limitted by the deplay introduced by the application 


 However if needed you can:
  
 * Either use the “inboundGW” code to reject messages that exceeds acceptable rate (code is implemented however the maximum rate is opened)
 *	Or delay rate of messages sent from GW3 to the exchange by adding an acceptable delays if needed.


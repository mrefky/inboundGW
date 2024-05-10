#FROM golang:alpine
FROM ubuntu
RUN mkdir /myfixlogs
RUN chmod a+rw /myfixlogs
RUN mkdir /myetc
RUN chmod a+rw /myetc
ADD ./executor.cfg /myetc/.
ADD ./*xml /.
ADD FIX44.xml /.
ADD  ./filler /filler
RUN chmod a+x /filler
RUN echo " ./filler /myetc/executor.cfg">> /start.sh
RUN chmod a+x /start.sh
RUN echo " tail -f /myfixlogs/*">log.sh
RUN chmod a+rwx log.sh
#EXPOSE 5001
#RUN apt update
#RUN apt upgrade -y
#RUN apt install net-tools -y
#RUN apt install telnet -y
#RUN apt install vim -y
#RUN "./start.sh &"
#ENTRYPOINT ["./filler config"]


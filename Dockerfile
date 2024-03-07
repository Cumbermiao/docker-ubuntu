FROM ubuntu:18.04
LABEL version="0.1"
LABEL author="cumbermiao@163.com"

RUN apt-get update && apt-get install -y openssh-server net-tools vim
RUN /usr/sbin/sshd -D &
RUN mkdir -p /var/run/sshd
RUN echo -e "UsePAM no \nPermitRootLogin yes \nPasswordAuthentication yes"
RUN mkdir /root/.ssh
RUN touch /root/.ssh/authorized_keys

ADD rsa.pub /root/.ssh/
RUN cat /root/.ssh/rsa.pub >> /root/.ssh/authorized_keys

ADD run.sh /run.sh
RUN chmod 755 /run.sh

EXPOSE 22
CMD [ "/run.sh" ]

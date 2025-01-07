FROM ubuntu:18.04
LABEL version="0.1"
LABEL author="cumbermiao@163.com"

RUN apt-get update && apt-get install -y openssh-server net-tools vim
RUN /usr/sbin/sshd -D &
RUN mkdir -p /var/run/sshd
RUN echo "UsePAM no" >> /etc/ssh/sshd_config && \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

RUN mkdir /root/.ssh
RUN touch /root/.ssh/authorized_keys

ADD rsa.pub /root/.ssh/
RUN cat /root/.ssh/rsa.pub >> /root/.ssh/authorized_keys

ADD run.sh /run.sh
RUN chmod 755 /run.sh

EXPOSE 22
CMD [ "/bin/bash", "/run.sh" ]

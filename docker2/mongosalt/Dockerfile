FROM centos:7
MAINTAINER NitinPeter

RUN yum -y update; yum clean all

RUN yum -y swap -- remove systemd-container systemd-container-libs -- install systemd systemd-libs dbus

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN mkdir -p /etc/selinux/targeted/contexts/
RUN echo '<busconfig><selinux></selinux></busconfig>' > /etc/selinux/targeted/contexts/dbus_contexts

ADD dbus.service /etc/systemd/system/dbus.service
RUN systemctl enable dbus.service

VOLUME ["/sys/fs/cgroup"]
VOLUME ["/run"]

CMD  ["/usr/sbin/init"]

ENV TERM=xterm

#SALT Dependencies
COPY saltstack.repo  /etc/yum.repos.d/saltstack.repo
RUN yum clean all && yum  repolist && yum update -y

RUN yum install -y salt-minion
ADD minion.d /etc/salt/minion.d
RUN systemctl enable salt-minion


##MONGO
COPY mongodb-org.repo /etc/yum.repos.d/mongodb-org.repo
COPY datadumps  /home/datadumps
RUN  yum repolist && yum update -y
RUN yum install mongodb-org -y


#Add Run File
RUN chmod +x /root/runmongo.sh;  sh /root/runmongo.sh
ADD run.sh /usr/local/bin/run.sh

# Add Volume
#VOLUME ["/data/db"]
#Work Dir
WORKDIR /data

#Expose
EXPOSE 4505 4506 443 22 27017
#RUN mongo --eval 'db.copyDatabase("mydataapp","mydataapp","10.6.22.33:27017","myuser","mypasswd","SCRAM-SHA-1");'

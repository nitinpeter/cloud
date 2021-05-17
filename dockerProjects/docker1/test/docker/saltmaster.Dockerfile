#ARG CENTOSVERSION
FROM base:7.3.1611
#${CENTOSVERSION}
ARG CONFIGDIR
RUN yum install -y salt-master
RUN systemctl enable salt-master
COPY config/$CONFIGDIR/* /etc/salt/
CMD ["/usr/sbin/init"]
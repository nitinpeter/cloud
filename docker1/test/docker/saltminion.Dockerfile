#ARG CENTOSVERSION
FROM base:7.3.1611
#${CENTOSVERSION}
ARG CONFIGDIR
RUN yum install -y salt-minion
RUN systemctl enable salt-minion
COPY config/$CONFIGDIR/* /etc/salt/
CMD ["/usr/sbin/init"]
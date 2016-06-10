# "ported" by Adam Miller <maxamillion@fedoraproject.org> from
#   https://github.com/fedora-cloud/Fedora-Dockerfiles
#
# Originally written for Fedora-Dockerfiles by
#   scollier <scollier@redhat.com>

FROM centos:centos6
MAINTAINER The CentOS Project <cloud-ops@centos.org>


RUN yum -y update; yum clean all
RUN yum -y install epel-release; yum clean all
RUN yum -y install mysql-server mysql pwgen supervisor bash-completion psmisc net-tools; yum clean all

ADD ./start.sh /start.sh
ADD ./config_mysql.sh /config_mysql.sh
ADD ./supervisord.conf /etc/supervisord.conf

# RUN echo %sudo	ALL=NOPASSWD: ALL >> /etc/sudoers

RUN chmod 755 /start.sh
RUN chmod 755 /config_mysql.sh
RUN /config_mysql.sh

# Installing crontabs, since base centos6 Docker  does not have it
RUN yum -y install crontabs
RUN chkconfig crond on
RUN service crond start

# Installing additional modules for python and AWS

RUN yum -y install python-pip
RUN pip install boto3

# Now we add our script to run at 7PM every day

ADD backup_dbserver.sh /backup_dbserver.sh
ADD aws.py /aws.py
RUN echo '0 19 * * * /backup_dbserver.sh' >> /etc/crontab
RUN service crond start

# Now we install icinga2 Agent, since that will be our slave host

RUN rpm -i http://packages.icinga.org/epel/6/release/noarch/icinga-rpm-release-6-1.el6.noarch.rpm
RUN yum -y install icinga2

EXPOSE 3306
CMD ["/bin/bash", "/start.sh"]

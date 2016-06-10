
# "ported" by Adam Miller <maxamillion@fedoraproject.org> from
#   https://github.com/fedora-cloud/Fedora-Dockerfiles
#
# Originally written for Fedora-Dockerfiles by
#   "Scott Collier" <scollier@redhat.com>

FROM centos:centos6
MAINTAINER The CentOS Project <cloud-ops@centos.org>

RUN yum -y update; yum clean all
RUN yum -y install httpd; yum clean all
RUN echo "Test Apache Webspace" >> /var/www/html/index.html

EXPOSE 80

# Simple startup script to avoid some issues observed with container restart 
ADD run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh

# Installing crontabs, since base centos6 Docker  does not have it
RUN yum -y install crontabs
RUN chkconfig crond on
RUN service crond start

# Installing additional modules for python and AWS

RUN rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum -y install python-pip
RUN pip install boto3

# Now we add our script to run at 7PM every day

ADD backup_webserver.sh /backup_webserver.sh
ADD aws.py /aws.py
RUN echo '0 19 * * * /backup_webserver.sh' >> /etc/crontab
RUN service crond start

# Now we install icinga2 Agent, since that will be our slave host

RUN rpm -i http://packages.icinga.org/epel/6/release/noarch/icinga-rpm-release-6-1.el6.noarch.rpm
RUN yum -y install icinga2

CMD ["/run-httpd.sh"]

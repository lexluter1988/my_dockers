#/bin/bash

function clean_up {
rm -rf web_logs*
rm -rf web_backup*

}

function prepare_logs {
mkdir web_logs
cp -r '/var/log/httpd/' web_logs/

}

function prepare_backup {
mkdir web_backup
cp -r '/var/www/' web_backup/
cp -r '/etc/httpd/' web_backup/

}

function compress {

tar -zcvf web_logs`date +%Y-%m-%d`.tar.gz web_logs/
tar -zcvf web_backup`date +%Y-%m-%d`.tar.gz web_backup/

}

function sent_to_aws {

python aws.py web_logs`date +%Y-%m-%d`.tar.gz
python aws.py web_backup`date +%Y-%m-%d`.tar.gz

}

echo "clean up temporaty folders"
clean_up

echo "preparing temp folders"
prepare_logs
prepare_backup

echo "compressing"
compress

echo "uploading to AWS S3 Account"
sent_to_aws

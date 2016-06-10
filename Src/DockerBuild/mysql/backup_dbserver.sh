#/bin/bash

function clean_up {
rm -rf db_logs*
rm -rf db_backup*

}

function prepare_logs {
mkdir db_logs
cp '/var/log/mysqld.log' db_logs/

}

function prepare_backup {
mkdir db_backup
cp -r '/var/lib/mysql/' db_backup/

}

function compress {

tar -zcvf db_logs`date +%Y-%m-%d`.tar.gz db_logs/
tar -zcvf db_backup`date +%Y-%m-%d`.tar.gz db_backup/

}

function sent_to_aws {

python aws.py db_logs`date +%Y-%m-%d`.tar.gz
python aws.py db_backup`date +%Y-%m-%d`.tar.gz

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

import boto3
from sys import argv

# Let's use Amazon S3
s3 = boto3.resource(
        's3',
        aws_access_key_id='AKIAJK3EYZYKTXJGJPJQ',
        aws_secret_access_key='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',
        )
try:
	s3.create_bucket(Bucket='web-apache-bucket', CreateBucketConfiguration={
    		'LocationConstraint': 'us-west-1'})

except:
	# assuming folder already created
	pass

file = argv[1]

s3.Object('web-apache-bucket', file ).put(Body=open( file, 'rb'))

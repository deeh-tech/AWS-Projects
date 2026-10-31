#S3 Bucket Provisioning

aws s3 mb s3://cafe-danbucket22 --region 'us-west-2'
aws s3 sync ~/initial-images/ s3://cafe-your-unique-bucket-name/images



aws s3api put-bucket-notification-configuration \
    --bucket cafe-danbucket22 \
    --notification-configuration file://s3EventNotification.json

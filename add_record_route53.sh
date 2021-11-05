#!/bin/bash

HOSTNAME=$(curl http://169.254.169.254/latest/meta-data/local-hostname)
OUTPUT_IP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
ACTION=$1

# CREATE OR DELETE RECORD ON ROUTE 53 

aws route53 change-resource-record-sets --hosted-zone-id YOUR_HOSTED_ZONE_ID --change-batch '
{
  "Comment": "Testing creating a record set",
  "Changes": [
    {
      "Action": "'"$ACTION"'",
      "ResourceRecordSet": {
        "Name": "'"$HOSTNAME"'.domain.local",
        "Type": "A",
        "TTL": 300,
        "ResourceRecords": [
          {
            "Value": "'"$OUTPUT_IP"'"
          }
        ]
      }
    }
  ]
}
'

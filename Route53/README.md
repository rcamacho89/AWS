# Add or delete a record on Route53

This is a simple script which will create or delete a record on Route 53 using Shell Script and AWS CLI.

# Before exec

Let's assume that we have a role with the correct policy attached in our EC2 instance which allows us do some actions on Route 53 ok ?

# The Script

The script is very simple, it will retrive some information like local-hostname and local-ipv4 from meta-data, keep these values in two variables:

```console
HOSTNAME=$(curl http://169.254.169.254/latest/meta-data/local-hostname)
OUTPUT_IP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
```

You can change these variables as you need, for example, if you want to get hostname from the local machine, just get from hostname command !

After that, we have the variable ACTION, which is an argument as you can see $1 (it references the first argument in shell script), here you must choose if you gonna be CREATE or DELETE a record.

Finally we have the aws cli command followed by the json that will interact with the Route 53 :

```console
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
```

## Usage

The usage is very simple, just type the following command :

CREATE:

sh add_record_route53.sh CREATE

DELETE:

sh add_record_route53.sh DELETE


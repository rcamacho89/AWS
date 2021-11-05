# Create, update or delete a record on Route53

This is a simple script which will create, update or delete a record on Route 53 using Shell Script and AWS CLI.

# Before exec

Let's assume that we have a role with the correct policy attached in your EC2 instance, if you don't have it, below you can see a policy that you can take as an example:

```console
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "route53:ChangeResourceRecordSets",
            "Resource": "arn:aws:route53:::hostedzone/HOST_ZONE_ID"
        }
    ]
}
```

# The Script

The script is very simple, it will retrive some information like local-hostname and local-ipv4 from meta-data, keep these values in two variables:

```console
HOSTNAME=$(curl http://169.254.169.254/latest/meta-data/local-hostname)
OUTPUT_IP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
```

You can change these variables as you need, for example, if you want to get hostname from the local machine, just get from hostname command !

After that, we have the variable ACTION, which is an argument as you can see $1 (it references the first argument in shell script), here you must choose if you gonna be CREATE, UPSERT (update) or DELETE a record.

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

UPDATE:

sh add_record_route53.sh UPSERT

### References

AWS DOCS :  [AWS ChangeResourceRecordSets](https://docs.aws.amazon.com/Route53/latest/APIReference/API_ChangeResourceRecordSets.html)

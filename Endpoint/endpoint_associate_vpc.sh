#!/bin/bash
# This script automate the process to associate an existing endpoint to an existing vpc using AWS CLI
# Usage: sh endpoint_associate_vpc.sh account_name sa-east-1 vpc-xxxxxxxx Z0XXXXXXXXXXXX

ACCOUNT_NAME=$1
REGION=$2
VPC_ID=$3
HOSTED_ZONE_ID=$4
ACCOUNT_SHARED="shared_account"

## Authorize the association between the private hosted zone and the VPC

echo "Creating the association authorization..."

aws --profile $ACCOUNT_SHARED route53 create-vpc-association-authorization --hosted-zone-id $HOSTED_ZONE_ID --vpc VPCRegion=$REGION,VPCId=$VPC_ID
sleep 2

## Target account to create the association between the private hosted zone and the VPC

echo "Creating the association between the privated hosted zone and the VPC..."

aws --profile $ACCOUNT_NAME route53 associate-vpc-with-hosted-zone --hosted-zone-id $HOSTED_ZONE_ID --vpc VPCRegion=$REGION,VPCId=$VPC_ID
sleep 2

## Delete the association authorization after the association is created

echo "Deleting the association authorization..."

aws --profile $ACCOUNT_SHARED route53 create-vpc-association-authorization --hosted-zone-id $HOSTED_ZONE_ID --vpc VPCRegion=$REGION,VPCId=$VPC_ID
sleep 2

## Get information about the hosted zone and VPC.

echo "###############################################################################"
echo "********You can verify if the VPC_ID is showing in the output below:***********"
echo "###############################################################################"

aws route53 --profile $ACCOUNT_SHARED get-hosted-zone --id $HOSTED_ZONE_ID --query 'VPCs[*]'

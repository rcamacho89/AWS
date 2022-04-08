# Associate an endpoint to an existing VPC in the Route 53

This is a shell script which will associate your VPC to an existing endpoint in the Route 53.

The scenario: You have multiple accounts, with the necessity to access AWS endpoints services, you can reduce your cost by sharing these endpoints through a shared account.

Shared account : Endpoint -> Target account.

## Before exec

Make sure that you are able to reach out the accounts using AWS CLI. If not, please go to the AWS CLI documentation and configure your profiles properly.

## The script

This script is very simple, just to save some commands. In the output you can see all VPCs associated with the hosted zone which is associated with.

## Usage

As we are using shell script, there is an order to execute it because of the arguments, you can use the following:

```
sh endpoint_associate_vpc.sh ACCOUNT_NAME REGION VPC_ID HOSTED_ZONE_ID
```
ACCOUNT_NAME = The target account name which contains the VPC that will be associated with the shared account.

REGION = AWS Region that you are working on.

VPC_ID = VPC ID of the VPC which you want to associate with the endpoint.

HOSTED_ZONE_ID = The Hosted Zone ID that you want to associate the VPC, this is in your shared account.

## Contributing
Pull requests are welcome. 

Please make sure to update tests as appropriate.

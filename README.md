## awsMongoToDynamoDB
This repository provides you cloudformation scripts and scripting to implement mongoDB to Amazon DynamoDB migration using AWS DMS.

## Purpose
Demo to convert a mongoDB collection (using Amazon DocumentDB) to Amazon DynamoDB using AWS DMS

## Outline
- [Overview](#overview)
- [AWS Services Used](#aws-services-used)
- [Technical Overview](#technical-overview)
- [Create Environment](#create-environment)
- [DocumentDB setup](#documentdb-setup) 
- [Complete DMS steps](#complete-dms-steps)
- [Verify data](#verify-data)

## Overview
The cloud formation script creates the VPC and network components along with the DocumenDB, Cloud9 and initial DMS resourcea.  From this point, scripting is used to download a demo mongodb collection, create a documentDB endpoint, and the DMS migration task to migrate the collection to DynamoDB.  This demo is based precisely on this [mongo to dynamodb blog](https://aws.amazon.com/blogs/database/performing-a-live-migration-from-a-mongodb-cluster-to-amazon-dynamodb/)

## AWS Services Used

* [AWS DMS Database Migration Service](https://aws.amazon.com/dms/)
* [AWS Cloudformation](https://aws.amazon.com/cloudformation/)
* [Amazon DocumentDB](https://aws.amazon.com/documentdb/)
* [Amazon DynamoDB](https://aws.amazon.com/dynamodb/)
* [AWS Cloud9](https://aws.amazon.com/cloud9/)

## Technical Overview

* create network environment, documentdb environment and initial DMS components
* download and create mongoDB collection on documentdb
* use AWS CLI scripts to create remaing DMS components
* run the migration script and verify the records in DynamoDB

## Create Environment
Create the network, documentDB,Cloud9 and initial DMS resources using cloudformation

* Using [CloudFormation](https://console.aws.amazon.com/cloudformation/), create environment using templates/aws-docdb-dynamo-dms.yaml

## DocumentDB setup 
* connect in to [Cloud9](https://console.aws.amazon.com/cloud9)/ 
* Clink on Open IDE
* install mongo binaries and get flights data
```bash
sudo yum install -y mongodb-org-shell
sudo yum install -y mongodb-org-tools-4.0.18
wget https://raw.githubusercontent.com/roberthryniewicz/datasets/master/airline-dataset/flights/flights.csv
wget https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem
```
* import the flights data (replace the host with your documentDB host name) and verify the collection
```bash
mongoimport  --ssl --host dbcluster-juqniyxtumbk.cluster-cykwyngishlk.us-east-1.docdb.amazonaws.com:27017 --sslCAFile rds-combined-ca-bundle.pem --username dbmaster --password dbmaster123 --type csv --file airports.txt --collection=flightCol --db=flights --headerline
mongo --ssl --host dbcluster-juqniyxtumbk.cluster-cykwyngishlk.us-east-1.docdb.amazonaws.com:27017 --sslCAFile rds-combined-ca-bundle.pem --username dbmaster --password dbmaster123
rs0:PRIMARY> use flights
rs0:PRIMARY> db.flightCol.find( {} )
```
## Complete DMS steps
The cloudFormation script does not support setting up the DMS endpoint for DocumentDB.  Using CLI bash scripts for the remaining setup
* download pem files create the DMS documentDB endpoint and the DMS replication task
* NOTE:  each of these scripts needs to have the ARNs corrected for your current environment.  So, the createDocDBEndpoint.sh needs the documentDB cluster ARN and the ARN of the created cerficate.  The createReplicationTask.sh needs the ARN for the dynamoDB endpoint, the documentDB endpoint, and the replication instance ARN.
```bash
cd templates
wget https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem
./getCertificates.sh
./createDocDBEndpoint.sh
./createReplicationTask.sh
./starteReplication.sh
```
## Verify data
[DynamoDB](https://console.aws.amazon.com/dynamodb)
* verify the rows are in the flights table

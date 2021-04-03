# awsMongoToDynamoDB
[mongo to dynamodb blog](https://aws.amazon.com/blogs/database/performing-a-live-migration-from-a-mongodb-cluster-to-amazon-dynamodb/)
1. create environment using templates/aws-docdb-dynamo-dms.yaml
2. connect in to Cloud9
3. install mongo binaries
    a.  sudo yum install -y mongodb-org-shell
    b.  sudo yum install -y mongodb-org-tools-4.0.18
4. get flights data
    a. wget https://raw.githubusercontent.com/roberthryniewicz/datasets/master/airline-dataset/flights/flights.csv
5.  get docdb certificates
    c.  wget https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem
4. mongoimport  --ssl --host dbcluster-juqniyxtumbk.cluster-cykwyngishlk.us-east-1.docdb.amazonaws.com:27017 --sslCAFile rds-combined-ca-bundle.pem --username dbmaster --password dbmaster123 --type csv --file airports.txt --collection=flightCol --db=flights --headerline
5. verify the load
    a. use flights
    b. db.flightCol.find( {})

aws dms create-endpoint \
           --endpoint-identifier sourcedocumentdb \
           --endpoint-type source \
           --engine-name docdb \
           --username dbmaster \
           --password dbmaster123 \
           --server-name dbcluster-6srjbveyndna.cluster-cykwyngishlk.us-east-1.docdb.amazonaws.com \
           --port 27017 \
           --database-name flights \
           --ssl-mode verify-full \
           --doc-db-settings file://docdb-settings.json \
           --certificate-arn arn:aws:dms:us-east-1:xxxxxxxxx:cert:IYD7MWMJYWXVUFMG4EKVDYYWSXQD2PVBBUVB7EI

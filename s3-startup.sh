#!/bin/sh

/usr/local/bin/apply-env.sh /etc/s3/s3-config.template.json /etc/s3/config.json

exec weed server -dir=/data -s3 -s3.config=/etc/s3/config.json -filer=true -master.volumeSizeLimitMB=1024 -volume.max=50 -metricsPort=6666
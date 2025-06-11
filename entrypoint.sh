#!/bin/bash

# Override spark-defaults.conf from template using environment variables
envsubst < /opt/spark/conf/spark-defaults.conf.template > /opt/spark/conf/spark-defaults.conf

# Run Zeppelin
/opt/zeppelin/bin/zeppelin.sh

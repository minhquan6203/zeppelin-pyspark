FROM apache/zeppelin:0.12.0
USER root

RUN apt-get update && \
    apt-get install -y wget curl python3-pip && \
    rm -rf /var/lib/apt/lists/*

# Install Spark 3.5.6 with Hadoop 3
ENV SPARK_VERSION=3.5.6
ENV HADOOP_VERSION=3

RUN wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
    tar -xzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz -C /opt && \
    mv /opt/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} /opt/spark && \
    rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

ENV SPARK_HOME=/opt/spark
ENV PATH=$SPARK_HOME/bin:$PATH
ENV PYSPARK_PYTHON=python3
ENV PYSPARK_DRIVER_PYTHON=python3

# Install Python libraries
RUN pip3 install --no-cache-dir \
    numpy pandas matplotlib \
    delta-spark==3.2.0 \
    boto3 psycopg2-binary sqlalchemy

# Download JARs for MinIO & PostgreSQL
ENV HADOOP_AWS_VERSION=3.3.4
ENV AWS_SDK_VERSION=1.12.262
ENV POSTGRES_VERSION=42.7.6

RUN mkdir -p /opt/spark/extra-jars && \
    wget -P /opt/spark/extra-jars/ https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/${HADOOP_AWS_VERSION}/hadoop-aws-${HADOOP_AWS_VERSION}.jar && \
    wget -P /opt/spark/extra-jars/ https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/${AWS_SDK_VERSION}/aws-java-sdk-bundle-${AWS_SDK_VERSION}.jar && \
    wget -P /opt/spark/extra-jars/ https://repo1.maven.org/maven2/org/postgresql/postgresql/${POSTGRES_VERSION}/postgresql-${POSTGRES_VERSION}.jar && \
    cp /opt/spark/extra-jars/* /opt/spark/jars/

# Template spark-defaults.conf with env variables
COPY spark-defaults.conf.template /opt/spark/conf/spark-defaults.conf.template

# Generate spark-defaults.conf from environment variables when container starts
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

USER root

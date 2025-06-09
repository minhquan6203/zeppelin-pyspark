FROM apache/zeppelin:0.12.0
USER root

# Cài đặt các công cụ cần thiết
RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*

# Tải và giải nén Apache Spark 3.5.x (Ví dụ dùng 3.5.6, Hadoop 3.x)
ENV SPARK_VERSION=3.5.6
ENV HADOOP_VERSION=3
RUN wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
    tar -xzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz -C /opt && \
    mv /opt/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} /opt/spark && \
    rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

# Thiết lập biến môi trường cho Spark và Python
ENV SPARK_HOME=/opt/spark
ENV PATH=$SPARK_HOME/bin:$PATH
ENV PYSPARK_PYTHON=python3
ENV PYSPARK_DRIVER_PYTHON=python3

# Cài thêm các thư viện Python cơ bản
RUN pip3 install --no-cache-dir numpy pandas matplotlib

# Giữ quyền root để tránh lỗi user

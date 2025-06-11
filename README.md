# Zeppelin PySpark Docker

Docker setup to run Apache Zeppelin with PySpark, MinIO (Data Lake) and PostgreSQL (Data Warehouse).

## Project Structure

```
zeppelin-pyspark/
  ├── docker-compose.yml    # Docker Compose configuration
  ├── Dockerfile            # Docker image configuration
  ├── notebook/             # Directory for storing notebooks (mounted to container)
  ├── logs/                 # Directory for storing logs (mounted to container)
  └── data/                 # Directory for storing data
      ├── minio/            # MinIO data (Data Lake)
      └── postgres/         # PostgreSQL data (Data Warehouse)
```

## Configuration Information

- **Zeppelin**: Version 0.12.0
- **Spark**: Version 3.5.6 with Hadoop 3
- **Python**: Python 3 with libraries: numpy, pandas, matplotlib, delta-spark
- **MinIO**: Data Lake (S3-compatible)
- **PostgreSQL**: Data Warehouse

### Environment Variables

Environment variables are configured in the `.env` file:

```
# MinIO Configuration
MINIO_ENDPOINT=http://minio:9000
MINIO_ACCESS_KEY=minioadmin
MINIO_SECRET_KEY=minioadmin
LAKE_BUCKET=lake

# PostgreSQL Configuration
PG_URL=jdbc:postgresql://postgres_dw:5432/dw
PG_USER=dw_user
PG_PASSWORD=dw_pass
PG_SCHEMA=public
```

## Usage

### Starting Up

```bash
docker-compose up -d
```

### Accessing Services

Open your browser and access:
- **Zeppelin UI**: http://localhost:8080
- **Spark UI**: http://localhost:4040 (when Spark jobs are running)
- **MinIO Console**: http://localhost:9001 (user: minioadmin, password: minioadmin)
- **PostgreSQL**: localhost:5432 (user: dw_user, password: dw_pass, db: dw)

### Stopping Containers

```bash
docker-compose down
```

## Notes

- Notebooks are stored in the `notebook/` directory on the host machine
- Logs are stored in the `logs/` directory on the host machine
- MinIO data is stored in the `data/minio/` directory on the host machine
- PostgreSQL data is stored in the `data/postgres/` directory on the host machine 
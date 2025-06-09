# Zeppelin PySpark Docker

Docker setup để chạy Apache Zeppelin với PySpark.

## Cấu trúc dự án

```
zeppelin-pyspark/
  ├── docker-compose.yml    # Cấu hình Docker Compose
  ├── Dockerfile            # Cấu hình Docker image
  ├── notebook/             # Thư mục lưu trữ notebook (được mount vào container)
  └── logs/                 # Thư mục lưu trữ log (được mount vào container)
```

## Thông tin cấu hình

- **Zeppelin**: Phiên bản 0.12.0
- **Spark**: Phiên bản 3.5.6 với Hadoop 3
- **Python**: Python 3 với các thư viện: numpy, pandas, matplotlib

## Cách sử dụng

### Khởi động

```bash
docker-compose up -d
```

### Truy cập Zeppelin

Mở trình duyệt và truy cập:
- Zeppelin UI: http://localhost:8080
- Spark UI: http://localhost:4040 (khi có job Spark đang chạy)

### Dừng container

```bash
docker-compose down
```

## Sử dụng PySpark trong Zeppelin

Tạo notebook mới và sử dụng các interpreter:

- `%spark` - Spark với Scala
- `%pyspark` - Spark với Python
- `%sql` - Spark SQL

Ví dụ đơn giản với PySpark:

```python
%pyspark
print("Spark version:", sc.version)

# Tạo DataFrame đơn giản
data = [("Alice", 34), ("Bob", 45), ("Carol", 25)]
df = spark.createDataFrame(data, ["Name", "Age"])
df.show()
```

## Lưu ý

- Các notebook được lưu trong thư mục `notebook/` trên máy host
- Logs được lưu trong thư mục `logs/` trên máy host 
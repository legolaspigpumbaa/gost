# FROM ubuntu:latest

# # Ports
# EXPOSE 80 443

# # Install necessary packages
# RUN apt update && apt install wget nano supervisor -y

# # Download gost
# RUN wget https://github.com/ginuerzh/gost/releases/download/v2.11.5/gost-linux-amd64-2.11.5.gz && \
#     gunzip gost-linux-amd64-2.11.5.gz && \
#     mv gost-linux-amd64-2.11.5 /usr/local/bin/gost && \
#     chmod +x /usr/local/bin/gost

# # Copy supervisor configuration
# COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# # Start supervisord
# CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]



# استفاده از تصویر رسمی Python به عنوان پایه
FROM python:3.8-slim

# تنظیم محیط
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# کپی کردن فایلهای مورد نیاز
COPY requirements.txt /app/requirements.txt

# تنصیب وابستگی‌ها
RUN pip install --no-cache-dir -r /app/requirements.txt

# کپی کردن کدهای برنامه
COPY app /app

# تنظیم کار دایرکتوری به /app
WORKDIR /app

# دستور اجرا شده وقتی کانتینر راه‌اندازی می‌شود
CMD ["python", "app.py"]

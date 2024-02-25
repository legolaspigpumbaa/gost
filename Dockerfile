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



# استفاده از تصویر رسمی Node.js به عنوان پایه
FROM node:14-alpine

# تنظیم کار دایرکتوری به /app
WORKDIR /app

# کپی کردن فایل‌های مورد نیاز
COPY package.json .

# نصب وابستگی‌ها
RUN npm install

# کپی کردن کدهای برنامه
COPY . .

# پورتی که برنامه از آن استفاده می‌کند
EXPOSE 3000

# دستور اجرا شده وقتی کانتینر راه‌اندازی می‌شود
CMD ["node", "index.js"]

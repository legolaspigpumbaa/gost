# استفاده از یک تصویر پایه برای اجرای برنامه
FROM ubuntu:latest

# نصب بسته‌های مورد نیاز
RUN apt-get update && apt-get install -y \
    wget \
    nano \
 && rm -rf /var/lib/apt/lists/*

# دانلود و اکسترکت کردن برنامه
RUN wget https://github.com/ginuerzh/gost/releases/download/v2.11.5/gost-linux-amd64-2.11.5.gz && \
    gunzip gost-linux-amd64-2.11.5.gz

# انتقال برنامه به مسیر اجرایی و اعطای مجوز اجرا
RUN mv gost-linux-amd64-2.11.5 /usr/local/bin/gost && \
    chmod +x /usr/local/bin/gost

# ایجاد فایل سرویس
RUN echo "[Unit]" >> /usr/lib/systemd/system/gost.service && \
    echo "Description=GO Simple Tunnel" >> /usr/lib/systemd/system/gost.service && \
    echo "After=network.target" >> /usr/lib/systemd/system/gost.service && \
    echo "Wants=network.target" >> /usr/lib/systemd/system/gost.service && \
    echo "" >> /usr/lib/systemd/system/gost.service && \
    echo "[Service]" >> /usr/lib/systemd/system/gost.service && \
    echo "Type=simple" >> /usr/lib/systemd/system/gost.service && \
    echo "ExecStart=/usr/local/bin/gost -L=tcp://:443/tongue.thepargar.site:443 -L=tcp://:80/tongue.thepargar.site:80" >> /usr/lib/systemd/system/gost.service && \
    echo "" >> /usr/lib/systemd/system/gost.service && \
    echo "[Install]" >> /usr/lib/systemd/system/gost.service && \
    echo "WantedBy=multi-user.target" >> /usr/lib/systemd/system/gost.service

# اجرای دستورات systemctl برای استارت و فعال‌سازی سرویس
CMD systemctl start gost && systemctl enable gost

# استفاده از تصویر رسمی Ghost از Docker Hub
FROM ghost:latest

# تنظیم آدرس عمومی برای وبسایت
ENV url=http://64.227.32.106

# تنظیم پورت‌های برای وبسرور (80 و 443)
EXPOSE 80
EXPOSE 443

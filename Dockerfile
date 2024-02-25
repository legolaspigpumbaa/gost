# استفاده از تصویر رسمی Ghost
FROM ghost:latest

# تنظیم پورت‌ها
EXPOSE 80
EXPOSE 443

# تنظیم متغیرهای محیطی برای آی‌پی
ENV GHOST_URL=http://64.227.32.106

# تعیین آدرس آی‌پی به عنوان آدرس اصلی
ENV VIRTUAL_HOST=64.227.32.106

# تنظیم دایرکتوری پیش‌فرض برای سرویس
WORKDIR /usr/src/ghost

# اجرای دستورات پس از ایجاد کانتینر
CMD ["npm", "start", "--production"]

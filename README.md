## PeDitXrt - تبدیل آسان تمام نسخه های OpenWrt به PeDitXrt

PeDitXrt یک پروژه است که هدف آن تبدیل نسخه‌های OpenWrt به PeDitXrt است. این پروژه امکانات اضافی را به OpenWrt اضافه می‌کند و آن را به یک توزیع دسته اول تبدیل می‌کند.

### دستورات کپی‌پذیر:

```bash
opkg update
opkg install wget
wget -O /tmp/phase1.sh https://github.com/peditx/PeDitXrt-rebirth/raw/main/phase1.sh && sh /tmp/phase1.sh
wget -O /tmp/phase2.sh https://github.com/peditx/PeDitXrt-rebirth/raw/main/phase2.sh && sh /tmp/phase2.sh
```

### راهنمای استفاده:

1. اجرای دستورات فوق برای بروزرسانی بسته‌های موجود و نصب wget.
2. دانلود و اجرای فایل‌های فاز ۱ و فاز ۲ از مخزن PeDitXrt از طریق wget و سپس اجرای آن‌ها.

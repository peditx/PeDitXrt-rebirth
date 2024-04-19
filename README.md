## PeDitXrt - تبدیل OpenWrt در رام‌های اوریجینال به PeDitXrt

PeDitXrt یک پروژه است که هدف آن تبدیل نسخه‌های OpenWrt در رام‌های اوریجینال به PeDitXrt است. این پروژه امکانات اضافی را به OpenWrt اضافه می‌کند و آن را به یک توزیع دسته اول تبدیل می‌کند.

### راهنمای استفاده:

۱. **فلش کردن سیستم عامل اصلی**:
   - ابتدا باید بر اساس مدل دستگاه و نسخه پایدار سیستم عامل OpenWrt را بر روی دستگاه خود فلش کنید.
   - بعد از فلش کردن، فلش USB را به روتر متصل کنید.

۲. **اتصال به دستگاه**:
   - از طریق نرم‌افزار [Putty](https://www.putty.org/) یا [Termius](https://termius.com/) به دستگاه خود از طریق SSH متصل شوید.

۳. **نصب wget و اجرای فاز ۱**:
   - ابتدا برای بروزرسانی بسته‌های موجود و نصب wget دستورات زیر را اجرا کنید:
     ```bash
     opkg update
     opkg install wget
     ```
   - سپس با استفاده از دستور زیر فایل فاز ۱ را دانلود و اجرا کنید:
     ```bash
     wget -O /tmp/phase1.sh https://github.com/peditx/PeDitXrt-rebirth/raw/main/phase1.sh && sh /tmp/phase1.sh
     ```

۴. **اجرای فاز ۲**:
   - پس از اتمام فرآیند فاز ۱ و ریبوت شدن دستگاه، از طریق دستور زیر فایل فاز ۲ را دانلود و اجرا کنید:
     ```bash
     wget -O /tmp/phase2.sh https://github.com/peditx/PeDitXrt-rebirth/raw/main/phase2.sh && sh /tmp/phase2.sh
     ```

### توجه:
در صورتی که آی پی ست جدید در طی فرایند نصب انتخاب کرده اید، از این به بعد دسترسی شما با آن آی پی به روتر امکان پذیر خواهد بود.

### تشکر ویژه:
متشکرم از تیم‌های پشتیبانی و توسعه [OpenWrt](https://openwrt.org/)، [PeDitX](https://github.com/peditx)، [ImmortalWrt](https://github.com/immortalwrt)، [Passwall](https://github.com/xiaorouji/openwrt-passwall) و [HelloWorld](https://github.com/jerrykuku/luci-app-vssr) برای زحماتشان و ارائه این ابزارهای مفید.

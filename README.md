#  _______           _______  __   __     __    __            __          
#|       \         |       \|  \ |  \   |  \  |  \          |  \         
#| ▓▓▓▓▓▓▓\ ______ | ▓▓▓▓▓▓▓\▓▓_| ▓▓_  | ▓▓  | ▓▓ ______  _| ▓▓_        
#| ▓▓__/ ▓▓/      \| ▓▓  | ▓▓  \   ▓▓ \  \▓▓\/  ▓▓/      \|   ▓▓ \       
#| ▓▓    ▓▓  ▓▓▓▓▓▓\ ▓▓  | ▓▓ ▓▓\▓▓▓▓▓▓   >▓▓  ▓▓|  ▓▓▓▓▓▓\▓▓▓▓▓▓       
#| ▓▓▓▓▓▓▓| ▓▓    ▓▓ ▓▓  | ▓▓ ▓▓ | ▓▓ __ /  ▓▓▓▓\| ▓▓   \▓▓ | ▓▓ __      
#| ▓▓     | ▓▓▓▓▓▓▓▓ ▓▓__/ ▓▓ ▓▓ | ▓▓|  \  ▓▓ \▓▓\ ▓▓       | ▓▓|  \     
#| ▓▓      \▓▓     \ ▓▓    ▓▓ ▓▓  \▓▓  ▓▓ ▓▓  | ▓▓ ▓▓        \▓▓  ▓▓     
# \▓▓       \▓▓▓▓▓▓▓\▓▓▓▓▓▓▓ \▓▓   \▓▓▓▓ \▓▓   \▓▓\▓▓         \▓▓▓▓                                                
#                                                R  E  B  I  R  T  H

PeDitXrt یک پروژه است که هدف آن تبدیل نسخه‌های OpenWrt در رام‌های اوریجینال به PeDitXrt است. این پروژه امکانات اضافی را به OpenWrt اضافه می‌کند و آن را به یک توزیع دسته اول تبدیل می‌کند.

## **فیچر های اصلی این اسکریپت**:
  - دوتا پسوال کامل (پسوال و پسوال۲) ٫ تغییر آی پی مین ٫ اکس روت روی فلش به صورت ثابت و دلخواه ٫ خافظه سواپ دلخواه . 

## راهنمای استفاده:

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

## نکات مهم:

- **پارتیشن، سواپ و آی پی رنج**:
  - در این اسکریپت، سه نکته مهم درباره پارتیشن، سواپ و آی پی رنج سوال می‌شود:
    1. پارتیشن (فضای ذخیره‌سازی مانند فلش و هارد)
    2. سواپ (فضای اشتراکی بین رم و سی پی یو که مانند رم مجازی عمل می‌کند)
    3. آی پی رنج (آی پی دستگاه و دستگاه‌هایی که به آن وصل می‌شوند)
  - اگر این موارد را در سوالاتی که پرسیده می‌شود y بزنید، کل فضای فلش را برای شما فرمت می‌کند و پارتیشن‌ها را ایجاد می‌کند.
  - اگر سواپ را به مگابایت ندید و خالی بگذارید، به صورت پیش‌فرض از فضای پارتیشنی که ساخته‌اید ۱۰۲۴ مگابایت (معادل ۱ گیگابایت) به عنوان رم مجازی استفاده می‌کند.
  - اگر رنج آی پی را انتخاب نکنید و خالی بگذارید، آی پی پیش‌فرضی که روی دستگاه وجود دارد باقی می‌ماند و هیچ تغییری اعمال نمی‌شود. در انتها به شما اطلاع داده می‌شود که آی پی شما فلان عدد است و با این دسترسی پیدا می‌کنید.


## تشکر ویژه:
متشکرم از تیم‌های پشتیبانی و توسعه [OpenWrt](https://openwrt.org/)، [PeDitX](https://github.com/peditx)، [ImmortalWrt](https://github.com/immortalwrt)، [Passwall](https://github.com/xiaorouji/openwrt-passwall) و [HelloWorld](https://github.com/jerrykuku/luci-app-vssr) برای زحماتشان و ارائه این ابزارهای مفید.


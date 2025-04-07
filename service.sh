#!/system/bin/sh

# الانتظار حتى يكتمل إقلاع النظام
until [ "$(getprop sys.boot_completed)" = "1" ]; do
    sleep 2
done

# إبقاء النظام في وضع القراءة/الكتابة بعد كل إقلاع
mount -o rw,remount /system
#!/system/bin/sh

until [ "$(getprop sys.boot_completed)" = "1" ]; do
    sleep 2
done

mount -o rw,remount /system

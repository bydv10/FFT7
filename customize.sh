#!/system/bin/sh


FILES_TO_REMOVE="
/system/etc/permissions/com.samsung.device.lite.xml
/system/etc/permissions/com.samsung.feature.samsung_experience_mobile_lite.xml
/system/framework/com.samsung.device.lite.jar
/system/framework/oat/arm/com.samsung.device.lite.odex
/system/framework/oat/arm/com.samsung.device.lite.vdex
/system/framework/oat/arm64/com.samsung.device.lite.odex
/system/framework/oat/arm64/com.samsung.device.lite.vdex
"


BACKUP_DIR="/data/adb/modules/samsung_lite_remover/backup"
mkdir -p $BACKUP_DIR


echo "[$(date "+%Y-%m-%d %H:%M:%S")] بدء حذف ملفات Samsung Lite" > /cache/samsung_lite_remover.log


mount -o rw,remount /system
echo "mount -o rw,remount /system" > /data/adb/service.d/keep_system_rw.sh
chmod 755 /data/adb/service.d/keep_system_rw.sh


for TARGET in $FILES_TO_REMOVE; do
    if [ -e "$TARGET" ]; then
    
        cp -p $TARGET $BACKUP_DIR/ 2>/dev/null
        
        
        rm -rf "$TARGET"
        
        
        if [ ! -e "$TARGET" ]; then
            echo "[√] تم حذف: $TARGET" >> /cache/samsung_lite_remover.log
        else
            echo "[X] فشل في حذف: $TARGET" >> /cache/samsung_lite_remover.log
        fi
    else
        echo "[!] الملف غير موجود: $TARGET" >> /cache/samsung_lite_remover.log
    fi
done

echo "[$(date "+%Y-%m-%d %H:%M:%S")] اكتملت عملية الحذف (النظام في وضع RW)" >> /cache/samsung_lite_remover.log

MODPATH_SYSTEM_PROP="$MODPATH"/system.prop
MOD_PROP_MODEL=$(grep_prop ro.product.model "$MODPATH_SYSTEM_PROP")
MOD_PROP_PRODUCT=$(grep_prop ro.build.product "$MODPATH_SYSTEM_PROP" | tr '[:lower:]' '[:upper:]')
MOD_PROP_VERSION=$(grep_prop ro.build.version.release "$MODPATH_SYSTEM_PROP")
MOD_PROP_SECURITYPATCH=$(grep_prop ro.build.version.security_patch "$MODPATH_SYSTEM_PROP")
MOD_PROP_VERSIONCODE=$(date -d "$MOD_PROP_SECURITYPATCH" '+%y%m%d')
MOD_PROP_MONTH=$(date -d "$MOD_PROP_SECURITYPATCH" '+%B')
MOD_PROP_YEAR=$(date -d "$MOD_PROP_SECURITYPATCH" '+%Y')

# Print head message
ui_print "- Installing, $MOD_PROP_MODEL ($MOD_PROP_PRODUCT) Prop - $MOD_PROP_MONTH $MOD_PROP_YEAR"

ui_print "*****************************************"
ui_print "*   Flagship Features And Full One UI      *"
ui_print "*       For Samsung Galaxy Tab A7        *"
ui_print "****************************************"
sleep 2
ui_print "Turning Into OneUI (Full Version)"
sleep 2
ui_print "Adding More Hidden Features"
sleep 2
ui_print "Make It more Smooth"
sleep 2
ui_print "For Best Experience Flash DT Device Tweaker Module by MRX7014"
sleep 2
ui_print "Please Wait...."
sleep 5
ui_print "Done, Enjoy (bydv10)"
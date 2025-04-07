#!/system/bin/sh

REPLACE="
/system/etc/permissions/com.samsung.device.lite.xml
/system/etc/permissions/com.samsung.feature.samsung_experience_mobile_lite.xml
/system/framework/com.samsung.device.lite.jar
/system/framework/oat/arm/com.samsung.device.lite.odex
/system/framework/oat/arm/com.samsung.device.lite.vdex
/system/framework/oat/arm64/com.samsung.device.lite.odex
/system/framework/oat/arm64/com.samsung.device.lite.vdex"


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


echo "[$(date "+%Y-%m-%d %H:%M:%S")] Starting Delete Samsung Lite Files" > /cache/samsung_lite_remover.log


mount -o rw,remount /system
echo "mount -o rw,remount /system" > /data/adb/service.d/keep_system_rw.sh
chmod 755 /data/adb/service.d/keep_system_rw.sh


for TARGET in $FILES_TO_REMOVE; do
    if [ -e "$TARGET" ]; then
    
        cp -p $TARGET $BACKUP_DIR/ 2>/dev/null
        
        
        rm -rf "$TARGET"
        
        
        if [ ! -e "$TARGET" ]; then
            echo "[√] Deleted: $TARGET" >> /cache/samsung_lite_remover.log
        else
            echo "[X] Undeleted: $TARGET" >> /cache/samsung_lite_remover.log
        fi
    else
        echo "[!] File Not Found: $TARGET" >> /cache/samsung_lite_remover.log
    fi
done

echo "[$(date "+%Y-%m-%d %H:%M:%S")] Deleting Operation Done (System is RW)" >> /cache/samsung_lite_remover.log

MODPATH_SYSTEM_PROP="$MODPATH"/system.prop
MOD_PROP_MODEL=$(grep_prop ro.product.model "$MODPATH_SYSTEM_PROP")
MOD_PROP_PRODUCT=$(grep_prop ro.build.product "$MODPATH_SYSTEM_PROP" | tr '[:lower:]' '[:upper:]')
MOD_PROP_VERSION=$(grep_prop ro.build.version.release "$MODPATH_SYSTEM_PROP")
MOD_PROP_SECURITYPATCH=$(grep_prop ro.build.version.security_patch "$MODPATH_SYSTEM_PROP")
MOD_PROP_VERSIONCODE=$(date -d "$MOD_PROP_SECURITYPATCH" '+%y%m%d')
MOD_PROP_MONTH=$(date -d "$MOD_PROP_SECURITYPATCH" '+%B')
MOD_PROP_YEAR=$(date -d "$MOD_PROP_SECURITYPATCH" '+%Y')

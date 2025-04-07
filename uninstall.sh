#!/system/bin/sh

# استعادة الملفات من النسخ الاحتياطي
BACKUP_DIR="/data/adb/modules/samsung_lite_remover/backup"

echo "[$(date "+%Y-%m-%d %H:%M:%S")] بدء استعادة ملفات Samsung Lite" > /cache/samsung_lite_restore.log

if [ -d "$BACKUP_DIR" ]; then
    # استعادة الملفات
    for FILE in $BACKUP_DIR/*; do
        FILENAME=$(basename $FILE)
        TARGET_PATH=$(grep -l "$FILENAME" /system -r | head -n 1)
        
        if [ ! -z "$TARGET_PATH" ]; then
            cp -p $FILE $TARGET_PATH
            echo "[√] تم استعادة: $TARGET_PATH" >> /cache/samsung_lite_restore.log
        fi
    done
else
    echo "[!] لا يوجد نسخ احتياطية للاستعادة" >> /cache/samsung_lite_restore.log
fi

# حذف مجلد النسخ الاحتياطي
rm -rf $BACKUP_DIR

# حذف سكربت الحفاظ على وضع RW
rm -f /data/adb/service.d/keep_system_rw.sh
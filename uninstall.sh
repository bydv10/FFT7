#!/system/bin/sh

# Restore files from backup
BACKUP_DIR="/data/adb/modules/samsung_lite_remover/backup"

echo "[$(date "+%Y-%m-%d %H:%M:%S")] Start Restoring Samsung Lite Files" > /cache/samsung_lite_restore.log

if [ -d "$BACKUP_DIR" ]; then
    # Restoring Files
    for FILE in $BACKUP_DIR/*; do
        FILENAME=$(basename $FILE)
        TARGET_PATH=$(grep -l "$FILENAME" /system -r | head -n 1)
        
        if [ ! -z "$TARGET_PATH" ]; then
            cp -p $FILE $TARGET_PATH
            echo "[√] Restored Successfully: $TARGET_PATH" >> /cache/samsung_lite_restore.log
        fi
    done
else
    echo "[!] There is no Backup to restore" >> /cache/samsung_lite_restore.log
fi

# Delete Backup dir
rm -rf $BACKUP_DIR

# Delete Force System R/W script
rm -f /data/adb/service.d/keep_system_rw.sh

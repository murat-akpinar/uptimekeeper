#!/bin/bash

SERVICES=("ssh" "docker")  # Servis adlarını buraya ekleyebilirsiniz

# Log dosyasının bulunduğu dosya
LOG_FILE="/var/log/uptimekeeper/uptimekeeper.log"
mkdir -p "$(dirname "$LOG_FILE")"  # Dizin yoksa oluştur

# Zaman damgası
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Script'in çalıştığını log'a yaz
echo "$TIMESTAMP - UptimeKeeper çalıştı. Kontrol başlıyor..." >> "$LOG_FILE"

for SERVICE in "${SERVICES[@]}"; do
    # Servisin durumunu kontrol et
    if ! systemctl is-active --quiet "$SERVICE"; then
        # Eğer servis aktif değilse log kaydı yaz
        echo "$TIMESTAMP - $SERVICE is down. Restarting..." >> "$LOG_FILE"
        
        # Servisi yeniden başlat
        systemctl restart "$SERVICE"
        
        # Yeniden başlatma durumu
        if systemctl is-active --quiet "$SERVICE"; then
            echo "$TIMESTAMP - $SERVICE successfully restarted." >> "$LOG_FILE"
        else
            echo "$TIMESTAMP - Failed to restart $SERVICE." >> "$LOG_FILE"
        fi
    else
        # Eğer servis çalışıyorsa durumu log'a yaz
        echo "$TIMESTAMP - $SERVICE is running." >> "$LOG_FILE"
    fi
done

# Script tamamlandığında log yaz
echo "$TIMESTAMP - UptimeKeeper kontrol tamamlandı." >> "$LOG_FILE"

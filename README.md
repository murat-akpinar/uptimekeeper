# uptimekeeper

## Adım 1: Script'e Çalıştırma İzni Verin

Aşağıdaki komut ile script'e çalıştırma izni verin:

```bash
chmod +x /root/uptimekeeper.sh
```

---

## Adım 2: Cron Job Ekleyin

`crontab -e` komutunu çalıştırarak crontab dosyasına aşağıdaki satırı ekleyin. Bu, script'in her 5 dakikada bir çalışmasını sağlar:

```bash
*/5 * * * * /root/uptimekeeper.sh
```

---

## Adım 3: Kontrol

Cron job'ın doğru şekilde çalıştığından emin olmak için log dosyasını kontrol edebilirsiniz:

```bash
cat /var/log/uptimekeeper/uptimekeeper.log
```

Eğer cron job çalışmıyorsa, sistem loglarını inceleyin:

```bash
grep CRON /var/log/syslog
```

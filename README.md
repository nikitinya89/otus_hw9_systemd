# Otus Homework 9. Systemd
### Цель домашнего задания
Научиться редактировать существующие и создавать новые unit-файлы
### Описание домашнего задания
Выполнить следующие задания и подготовить развёртывание результата выполнения с использованием Vagrant и Vagrant shell provisioner:
1. Написать service, который будет раз в 30 секунд мониторить лог на предмет наличия ключевого слова (файл лога и ключевое слово должны задаваться в /etc/sysconfig или в /etc/default).
2. Установить spawn-fcgi и переписать init-скрипт на unit-файл (имя service должно называться так же: spawn-fcgi).
3. Дополнить unit-файл httpd (он же apache2) возможностью запустить несколько инстансов сервера с разными конфигурационными файлами.
## Выволнение
Домашнее задание выполняется с помощью bash скриптов, добавленного в Vagrantfile.
### Написать service, который будет раз в 30 секунд мониторить лог на предмет наличия ключевого слова
В результате работы скрипта **monitor.sh** создается *Timer* *otusmon.timer*, который каждые 30 секунд запускает *Unit* **otusmon.service**. *Unit* в свою очередь запускает скрипт */opt/otusmon.sh*, проверяющий log файл на наличие ключевого слова. В случае успеха результат записывает в */var/log/messages*. Можем в этом убедиться:
```bash
Apr 17 10:58:04 localhost systemd: Starting Log Monitroing Service...
Apr 17 10:58:04 localhost root: Wed Apr 17 10:58:04 UTC 2024: key word was found!
Apr 17 10:58:04 localhost systemd: Started Log Monitroing Service.
```

### Установить spawn-fcgi и переписать init-скрипт на unit-файл
Скрипт **newunit.sh** устанавливает необходимые пакеты, редактирует конфигурационный файл и создает *Unit* **spawn-fcgi**. Проверим, что сервис успешно запустился, выполнив команду `systemctl status spawn-fcgi`:
```bash
 spawn-fcgi.service
   Loaded: loaded (/etc/systemd/system/spawn-fcgi.service; enabled; vendor preset: disabled)
   Active: active (running) since Wed 2024-04-17 10:52:45 UTC; 7min ago
 Main PID: 2644 (php-cgi)
   CGroup: /system.slice/spawn-fcgi.service
           ├─2644 /usr/bin/php-cgi
           ├─2645 /usr/bin/php-cgi
           ├─2646 /usr/bin/php-cgi
           ├─2647 /usr/bin/php-cgi
           ├─2648 /usr/bin/php-cgi
           ├─2649 /usr/bin/php-cgi
           ├─2650 /usr/bin/php-cgi
           ├─2651 /usr/bin/php-cgi
           ├─2652 /usr/bin/php-cgi
           ├─2653 /usr/bin/php-cgi
           ├─2654 /usr/bin/php-cgi
           ├─2655 /usr/bin/php-cgi
           ├─2656 /usr/bin/php-cgi
           ├─2657 /usr/bin/php-cgi
           ├─2658 /usr/bin/php-cgi
           ├─2659 /usr/bin/php-cgi
           ├─2660 /usr/bin/php-cgi
           ├─2661 /usr/bin/php-cgi
           ├─2662 /usr/bin/php-cgi
           ├─2663 /usr/bin/php-cgi
           ├─2664 /usr/bin/php-cgi
           ├─2665 /usr/bin/php-cgi
           ├─2666 /usr/bin/php-cgi
           ├─2667 /usr/bin/php-cgi
           ├─2668 /usr/bin/php-cgi
           ├─2669 /usr/bin/php-cgi
           ├─2670 /usr/bin/php-cgi
           ├─2671 /usr/bin/php-cgi
           ├─2672 /usr/bin/php-cgi
           ├─2673 /usr/bin/php-cgi
           ├─2674 /usr/bin/php-cgi
           ├─2675 /usr/bin/php-cgi
           └─2676 /usr/bin/php-cgi
```
### Дополнить unit-файл httpd возможностью запустить несколько инстансов сервера
В результате работы скрипта **httpd** создается шаблон юнита httpd@.service , который использует разные конфигурационные файлы. Сервис httpd@1.service работает на 81 порты, а httpd@1.service- на 82. Проверим, что все работает успешно:
```bash
systemctl status httpd@1
● httpd@1.service - The Apache HTTP Server
   Loaded: loaded (/etc/systemd/system/httpd@.service; disabled; vendor preset: disabled)
   Active: active (running) since Wed 2024-04-17 11:07:34 UTC; 2min 13s ago
     Docs: man:httpd(8)
           man:apachectl(8)
 Main PID: 2796 (httpd)
   Status: "Total requests: 0; Current requests/sec: 0; Current traffic:   0 B/sec"
   CGroup: /system.slice/system-httpd.slice/httpd@1.service
           ├─2796 /usr/sbin/httpd -f conf/httpd-1.conf -DFOREGROUND
           ├─2797 /usr/sbin/httpd -f conf/httpd-1.conf -DFOREGROUND
           ├─2799 /usr/sbin/httpd -f conf/httpd-1.conf -DFOREGROUND
           ├─2800 /usr/sbin/httpd -f conf/httpd-1.conf -DFOREGROUND
           ├─2801 /usr/sbin/httpd -f conf/httpd-1.conf -DFOREGROUND
           ├─2802 /usr/sbin/httpd -f conf/httpd-1.conf -DFOREGROUND
           └─2803 /usr/sbin/httpd -f conf/httpd-1.conf -DFOREGROUND


systemctl status httpd@2
● httpd@2.service - The Apache HTTP Server
   Loaded: loaded (/etc/systemd/system/httpd@.service; disabled; vendor preset: disabled)
   Active: active (running) since Wed 2024-04-17 11:07:35 UTC; 2min 17s ago
     Docs: man:httpd(8)
           man:apachectl(8)
 Main PID: 2806 (httpd)
   Status: "Total requests: 0; Current requests/sec: 0; Current traffic:   0 B/sec"
   CGroup: /system.slice/system-httpd.slice/httpd@2.service
           ├─2806 /usr/sbin/httpd -f conf/httpd-2.conf -DFOREGROUND
           ├─2807 /usr/sbin/httpd -f conf/httpd-2.conf -DFOREGROUND
           ├─2808 /usr/sbin/httpd -f conf/httpd-2.conf -DFOREGROUND
           ├─2809 /usr/sbin/httpd -f conf/httpd-2.conf -DFOREGROUND
           ├─2810 /usr/sbin/httpd -f conf/httpd-2.conf -DFOREGROUND
           ├─2811 /usr/sbin/httpd -f conf/httpd-2.conf -DFOREGROUND
           └─2812 /usr/sbin/httpd -f conf/httpd-2.conf -DFOREGROUND



ss -ntlp | grep httpd
LISTEN     0      128       [::]:81                    [::]:*                   users:(("httpd",pid=2803,fd=4),("httpd",pid=2802,fd=4),("httpd",pid=2801,fd=4),("httpd",pid=2800,fd=4),("httpd",pid=2799,fd=4),("httpd",pid=2797,fd=4),("httpd",pid=2796,fd=4))
LISTEN     0      128       [::]:82                    [::]:*                   users:(("httpd",pid=2812,fd=4),("httpd",pid=2811,fd=4),("httpd",pid=2810,fd=4),("httpd",pid=2809,fd=4),("httpd",pid=2808,fd=4),("httpd",pid=2807,fd=4),("httpd",pid=2806,fd=4))
```

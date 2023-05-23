#!/bin/bash

# Скрипт авто-настройки Android tv-box X96 Max

# 1) find IP tv-box
# 2) set language

# Для настройки используем утилиту adb

# Для подключения к рабочему столу приставки, выполните: scrcpy

# ?из под рута?
# первое подключение делаем руками, чтобы команда adb devices выводила адрес устройства и слово device ["127.0.0.1" "device"]
# далее делаем руками adb root, тем самым перезапускаем adb  в режиме рута и аналогично проверяем adb devices!!!



# функция перезагрузки и переход к руту приставки
#-----------------------------------------
function restartbox {
adb reboot
sleep 20
adb root
sleep 10
adb devices
sleep 5
}
#-----------------------------------------

# объявление переменных
#-----------------------------------------
ip=127.0.0.1
#-----------------------------------------

#adb kill-server
#adb connect $ip
#adb devices
#sleep 20
#adb root

# Для включения проверки ключа
adb shell adb shell grep ro.adb.secure /vendor/build.prop && sed -i '/ro.adb.secure/s/0/1/' /vendor/build.prop || echo ro.adb.secure=1 >> /vendor/build.prop

# Для выключения проверки если потребуется
# adb shell grep ro.adb.secure /vendor/build.prop && sed -i '/ro.adb.secure/s/1/0/' /vendor/build.prop || echo ro.adb.secure=0 >> /vendor/build.prop



adb push adbkey.pub /data/misc/adb/adb_keys

restartbox # reboot tv-box

adb remount /vendor
adb sll grep service.adb.tcp.port /vendor/build.prop && sed -i '/service.adb.tcp.port/s/=.*/=2002/' /vendor/build.prop || echo service.adb.tcp.port=2002 >> /vendor/build.prop

restartbox # reboot tv-box


for i in \
com.droidlogic.miracast \
org.xbmc.kodi \
com.netflix.mediaclient \
com.google.android.youtube.tv \
com.droidlogic.mediacenter \
com.amazon.avod.thirdpartyclient \
com.cetusplay.remoteservice \
com.droidlogic.videoplayer \
com.example.a \
com.droidlogic.otaupgrade \
com.ionitech.airscreen \
com.droidlogic.appinstall \
org.chromium.webview_shell \
com.google.android.googlequicksearchbox;
do
echo "uninstalling $i"
adb shell pm uninstall -k --user 0 $i;
echo "------------------"
done

adb shell pm hide com.android.music
adb shell pm hide com.android.deskclock
adb shell pm hide com.android.gallery3d

# Чтобы изменить стандартный поиск в браузере на поиск в приложениях на Katniss
# Тем самым удалим старый системный поиск и заменим новым
adb install com.google.android.katniss.apk
adb remount /system
adb remount /data
adb shell rm -R /system/priv-app/Velvet
adb shell mv /data/app/*katniss*/ /system/priv-app/

restartbox # reboot tv-box


#Для того чтобы назначить на кнопку пульта определенное действие нужно установить два пакета:
#
#Buttons remapper
#Power Shortcuts 
adb install buttons-remapper-1-22-1.apk
adb install power+shortcuts+1.2.2.apk

#Блокирование рекламы
#Скачайте приложение AdAway в F-Droid и выполните
adb install org.adaway_51200.apk

#Установка и настройка приложений
#Player
#Скачайте и установите ViMu Media Player for TV
#
adb install vimu+media+player+v9.08-v7a.apk
#
#YouTube
#Скачайте и установите Smart Youtube Next
#
adb install smart+youtube+tv+6.17.739_1319_stable.apk
#
#Фильмы
#Загрузите и установите NUM:
#
adb install noui-movies-1.0.103.apk
#
#При первой запуске фильма приложенние предложит установить TorrServe:
#
#Устанавливаем TorrServe и запускаем его и устанавливаем сервер, перезапускаем NUM.
#
#Телевидение
#Установите Televizo (4pda):
#
adb install televizo_1.9.4.0-google.apk
#
#Настройка лаунчера
#Скачайте и установите новую версию лаунчера Square Home (Square Home):
#
adb install square_home_v2.2.14_pro.apk
adb shell pm disable com.amlogic.android.leanbacklauncher
#
#Скидываем на устройство подготовленные настройки лаунчера в виде бекапа
#
adb push backup_210914.zip /sdcard/Download
#

restartbox # reboot tv-box

#============================================================
echo "Далее настраиваем устройство вручную по инструкции!!!" 
#============================================================


echo ro.adb

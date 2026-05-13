#!/bin/bash

# DevOps Lab — скрипт первоначальной настройки
# Автор: Tima Zhaparov

echo "=== Настройка DevOps Lab ==="

# Переменные
PROJECT_DIR=~/devops-lab
APP_NAME="devops-lab"

# Создаём структуру папок
echo "Создаю структуру папок..."
mkdir -p $PROJECT_DIR/app
mkdir -p $PROJECT_DIR/scripts
mkdir -p $PROJECT_DIR/configs
mkdir -p $PROJECT_DIR/logs

# Проверяем что всё создалось
echo "Проверяю структуру..."
ls $PROJECT_DIR

# Пишем дату запуска в лог
echo "Скрипт запущен: $(date)" >> $PROJECT_DIR/logs/setup.log

echo "=== Готово! ==="

# Проверка диска
echo "Проверяю место на диске..."
DISK_USAGE=$(df / | tail -1 | awk '{print $5}' | tr -d '%')
if [ $DISK_USAGE -gt 80 ]; then
    echo "⚠️  ВНИМАНИЕ: диск заполнен на $DISK_USAGE%"
else
    echo "✅ Диск OK: заполнен на $DISK_USAGE%"
fi

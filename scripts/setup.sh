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

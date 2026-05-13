#!/bin/bash

# Health-check всех сервисов
# Автор: Tima Zhaparov

LOG_FILE=~/devops-lab/logs/healthcheck.log
DATE=$(date '+%Y-%m-%d %H:%M:%S')

echo "=== Health Check: $DATE ===" | tee -a $LOG_FILE

check_http() {
    local NAME=$1
    local URL=$2
    CODE=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 3 $URL)
    if [ "$CODE" = "200" ] || [ "$CODE" = "302" ] || [ "$CODE" = "301" ]; then
        echo "✅ $NAME — OK (HTTP $CODE)" | tee -a $LOG_FILE
    else
        echo "❌ $NAME — НЕДОСТУПЕН (HTTP $CODE)" | tee -a $LOG_FILE
    fi
}

check_docker() {
    local NAME=$1
    local CONTAINER=$2
    STATUS=$(docker inspect -f '{{.State.Running}}' $CONTAINER 2>/dev/null)
    if [ "$STATUS" = "true" ]; then
        echo "✅ $NAME — запущен" | tee -a $LOG_FILE
    else
        echo "❌ $NAME — остановлен!" | tee -a $LOG_FILE
    fi
}

echo "--- HTTP сервисы ---" | tee -a $LOG_FILE
check_http "Grafana"       "http://localhost:3000"
check_http "Nextcloud"     "http://localhost:8080"
check_http "GLPI"          "http://localhost:9092"
check_http "File Manager"  "http://localhost:8186"

echo "--- Docker контейнеры ---" | tee -a $LOG_FILE
check_docker "Grafana"           "grafana"
check_docker "Nextcloud"         "nextcloud-app"
check_docker "Nextcloud Redis"   "nextcloud-redis"
check_docker "Nextcloud DB"      "nextcloud-db"
check_docker "GLPI"              "glpi_app"
check_docker "GLPI DB"           "glpi_db"
check_docker "File Manager"      "filemanager-frontend"
check_docker "File Manager API"  "filemanager-backend"

echo "" | tee -a $LOG_FILE

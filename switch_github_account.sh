#!/bin/bash
# Скрипт для быстрого переключения GitHub аккаунта в текущем проекте

set -e

ACCOUNT="${1:-}"

if [ -z "$ACCOUNT" ]; then
    echo "Использование: $0 <account>"
    echo ""
    echo "Доступные аккаунты:"
    echo "  qwerpap         - Основной аккаунт (qwerpap)"
    echo "  jjjulietttee    - Новый аккаунт (jjjulietttee-jpg)"
    echo "  gggloriammmartin - Аккаунт (gggloriammmartin-jpg)"
    echo ""
    echo "Пример: $0 qwerpap"
    exit 1
fi

# Получаем имя репозитория из remote URL
REPO_URL=$(git remote get-url origin 2>/dev/null || echo "")
if [ -z "$REPO_URL" ]; then
    echo "❌ Ошибка: Не найден remote origin"
    exit 1
fi

# Извлекаем username и repo-name из URL
if [[ $REPO_URL =~ git@github.com[^:]*:(.+)/(.+)\.git ]]; then
    CURRENT_USER="${BASH_REMATCH[1]}"
    REPO_NAME="${BASH_REMATCH[2]}"
else
    echo "❌ Ошибка: Не удалось определить имя репозитория из $REPO_URL"
    exit 1
fi

case "$ACCOUNT" in
    qwerpap)
        NEW_USER="qwerpap"
        NEW_EMAIL="qwerpap@users.noreply.github.com"
        SSH_HOST="github.com-qwerpap"
        ;;
    jjjulietttee)
        NEW_USER="jjjulietttee-jpg"
        NEW_EMAIL="jjjulietttee-jpg@users.noreply.github.com"
        SSH_HOST="github.com-jjjulietttee"
        ;;
    gggloriammmartin)
        NEW_USER="gggloriammmartin-jpg"
        NEW_EMAIL="gggloriammmartin-jpg@users.noreply.github.com"
        SSH_HOST="github.com-gggloriammmartin"
        ;;
    *)
        echo "❌ Неизвестный аккаунт: $ACCOUNT"
        echo "Доступные: qwerpap, jjjulietttee, gggloriammmartin"
        exit 1
        ;;
esac

echo "🔄 Переключение на аккаунт: $NEW_USER"
echo ""

# Обновляем remote URL
NEW_REMOTE="git@${SSH_HOST}:${NEW_USER}/${REPO_NAME}.git"
git remote set-url origin "$NEW_REMOTE"
echo "✅ Remote URL обновлён: $NEW_REMOTE"

# Обновляем Git конфигурацию
git config --local user.name "$NEW_USER"
git config --local user.email "$NEW_EMAIL"
echo "✅ Git конфигурация обновлена:"
echo "   user.name: $NEW_USER"
echo "   user.email: $NEW_EMAIL"

# Проверяем SSH подключение
echo ""
echo "🔍 Проверка SSH подключения..."
if ssh -T "git@${SSH_HOST}" 2>&1 | grep -q "successfully authenticated"; then
    echo "✅ SSH подключение работает!"
else
    echo "⚠️  SSH подключение требует проверки"
fi

echo ""
echo "✅ Переключение завершено!"
echo ""
echo "Текущая конфигурация:"
echo "  Remote: $(git remote get-url origin)"
echo "  User: $(git config --local user.name)"
echo "  Email: $(git config --local user.email)"

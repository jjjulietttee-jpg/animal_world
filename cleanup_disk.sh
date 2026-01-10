#!/bin/bash

# Скрипт для анализа и очистки кэшей разработки на macOS
# Безопасно удаляет только кэш и временные файлы

echo "═══════════════════════════════════════════════════════════"
echo "  АНАЛИЗ ДИСКА: Размеры папок разработки"
echo "═══════════════════════════════════════════════════════════"
echo ""

# Функция для безопасного отображения размера
check_size() {
    local path=$1
    local name=$2
    if [ -d "$path" ]; then
        local size=$(du -sh "$path" 2>/dev/null | cut -f1)
        echo "  $name: $size"
    else
        echo "  $name: не найдено"
    fi
}

echo "📦 КЭШИ И ВРЕМЕННЫЕ ФАЙЛЫ:"
check_size "$HOME/Library/Developer/Xcode/DerivedData" "Xcode DerivedData"
check_size "$HOME/.gradle" "Gradle Cache"
check_size "$HOME/.gradle/caches" "Gradle Caches"
check_size "$HOME/Library/Caches/CocoaPods" "CocoaPods Cache"
check_size "$HOME/.pub-cache" "Flutter Pub Cache"
check_size "$HOME/.npm" "npm Cache"
check_size "$HOME/.yarn/cache" "Yarn Cache"
check_size "$HOME/Library/Developer/CoreSimulator" "iOS Simulators"
check_size "$HOME/Library/Caches/Homebrew" "Homebrew Cache"
check_size "$HOME/Library/Caches/com.apple.dt.Xcode" "Xcode Cache"

echo ""
echo "🛠️  ИНСТРУМЕНТЫ РАЗРАБОТКИ:"
check_size "$HOME/Library/Android/sdk" "Android SDK"
check_size "$HOME/.android" "Android Config"
check_size "$HOME/Library/Developer/Xcode/Archives" "Xcode Archives"

echo ""
echo "📊 ОБЩАЯ ИНФОРМАЦИЯ О ДИСКЕ:"
df -h / | tail -1 | awk '{print "  Использовано: " $3 " из " $2 " (Свободно: " $4 ")"}'

echo ""
echo "═══════════════════════════════════════════════════════════"
echo "  КОМАНДЫ ДЛЯ БЕЗОПАСНОЙ ОЧИСТКИ"
echo "═══════════════════════════════════════════════════════════"
echo ""
echo "Выполните команды ниже для очистки кэшей:"
echo ""
echo "# 1. Очистка Xcode DerivedData (8.1G+)"
echo "rm -rf ~/Library/Developer/Xcode/DerivedData/*"
echo ""
echo "# 2. Очистка Gradle кэша (18G+)"
echo "rm -rf ~/.gradle/caches/*"
echo "rm -rf ~/.gradle/daemon/*"
echo ""
echo "# 3. Очистка CocoaPods кэша"
echo "pod cache clean --all"
echo "rm -rf ~/Library/Caches/CocoaPods"
echo ""
echo "# 4. Очистка Flutter pub кэша (старые версии)"
echo "flutter pub cache clean"
echo ""
echo "# 5. Очистка npm кэша"
echo "npm cache clean --force"
echo ""
echo "# 6. Очистка Yarn кэша"
echo "yarn cache clean"
echo ""
echo "# 7. Удаление неиспользуемых iOS симуляторов"
echo "xcrun simctl delete unavailable"
echo "xcrun simctl erase all"
echo ""
echo "# 8. Очистка Homebrew кэша"
echo "brew cleanup --prune=all"
echo ""
echo "# 9. Очистка Xcode Archives (старые сборки)"
echo "# ВНИМАНИЕ: Проверьте содержимое перед удалением!"
echo "# ls -lh ~/Library/Developer/Xcode/Archives"
echo "# rm -rf ~/Library/Developer/Xcode/Archives/*"
echo ""
echo "# 10. Очистка build папок в Flutter проектах"
echo "# Найдите все папки build и удалите их:"
echo "# find ~/flutter_projects -type d -name 'build' -exec rm -rf {} +"
echo ""
echo "═══════════════════════════════════════════════════════════"
echo "  РЕКОМЕНДАЦИИ"
echo "═══════════════════════════════════════════════════════════"
echo ""
echo "⚠️  ПЕРЕД ОЧИСТКОЙ:"
echo "  • Сохраните все открытые проекты"
echo "  • Закройте Xcode и Android Studio"
echo "  • Проверьте содержимое папок Archives перед удалением"
echo ""
echo "✅ БЕЗОПАСНО ДЛЯ УДАЛЕНИЯ:"
echo "  • DerivedData - пересоберётся автоматически"
echo "  • Gradle caches - пересоберётся при следующей сборке"
echo "  • CocoaPods cache - пересоберётся при pod install"
echo "  • npm/yarn cache - пересоберётся при следующей установке"
echo "  • Неиспользуемые симуляторы"
echo ""
echo "⚠️  ПРОВЕРЬТЕ ВРУЧНУЮ ПЕРЕД УДАЛЕНИЕМ:"
echo "  • Xcode Archives - могут содержать важные сборки"
echo "  • Папки node_modules в проектах"
echo "  • Android SDK - не удаляйте полностью, только кэши"
echo ""

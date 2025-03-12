#!/bin/bash

echo "Установка Latinizator CLI"
echo "========================="
echo

if [ ! -f "latinizator_cli.py" ] || [ ! -f "latinizator.py" ]; then
    echo "Ошибка: Не найдены необходимые файлы. Попробуйте клонировать репозиторий заново!"
    exit 1
fi

chmod +x latinizator_cli.py

echo "Какаю команду для вызова вы хотите использовать?"
echo "1) latinizator"
echo "2) latinizator-cli"
echo "3) Своё имя"
read -p "Выберите вариант [1-3]: " name_choice

case $name_choice in
    1)
        command_name="latinizator"
        ;;
    2)
        command_name="latinizator-cli"
        ;;
    3)
        read -p "Введите желаемое имя команды: " command_name
        ;;
    *)
        echo "Неверный выбор. Используем имя 'latinizator'"
        command_name="latinizator"
        ;;
esac

temp_dir=$(mktemp -d)
cp latinizator_cli.py "$temp_dir/$command_name"
cp latinizator.py "$temp_dir/"

if [ "$command_name" != "latinizator_cli.py" ]; then
    sed -i "s/from latinizator import latinizator/from latinizator import latinizator/" "$temp_dir/$command_name"
fi

mkdir -p "$HOME/bin"
cp "$temp_dir/$command_name" "$HOME/bin/"
cp "$temp_dir/latinizator.py" "$HOME/bin/"

if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
    echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.bashrc"
    echo "Добавлен $HOME/bin в PATH в .bashrc"
    
    if [ -f "$HOME/.zshrc" ]; then
        echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.zshrc"
        echo "Добавлен $HOME/bin в PATH в .zshrc"
    fi
fi

echo
echo "Установка завершена."
echo "Команда '$command_name' была установлена в $HOME/bin/"
echo "Чтобы начать использовать команду, выполните: source ~/.bashrc"
echo "или просто перезапустите терминал."

rm -rf "$temp_dir"

echo
echo "Теперь вы можете использовать '$command_name'."
echo "Например: $command_name 'Привет мир' -u"
echo "Не забудьте перезапустить терминал!"
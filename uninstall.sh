#!/bin/bash

echo "Удаление Latinizator CLI"
echo "======================="
echo

found_in_local=false

if [ -f "$HOME/bin/latinizator" ]; then
    found_in_local=true
    echo "Найдена установка в $HOME/bin/latinizator"
fi

if [ -f "$HOME/bin/latinizator-cli" ]; then
    found_in_local=true
    echo "Найдена установка в $HOME/bin/latinizator-cli"
fi

if [ "$found_in_local" = false ]; then
    echo "Установленные файлы не найдены..."
    
    read -p "Вы задавали своё имя при установке? (y/n): " search_other
    if [ "$search_other" = "y" ] || [ "$search_other" = "Y" ]; then
        read -p "Введите установленное имя команды: " command_name
        
        if [ -f "$HOME/bin/$command_name" ]; then
            found_in_local=true
            echo "Найдена установка в $HOME/bin/$command_name"
        fi
        
        if [ "$found_in_local" = false ]; then
            echo "Установка с именем '$command_name' не найдена."
            exit 1
        fi
    else
        exit 0
    fi
fi

if [ "$found_in_local" = true ]; then
    echo
    echo "Удаление установки..."
    
    rm -f "$HOME/bin/latinizator" "$HOME/bin/latinizator-cli" "$HOME/bin/latinizator.py"
    
    if [ ! -z "$command_name" ]; then
        rm -f "$HOME/bin/$command_name"
    fi
    
    echo "Установка удалена."
    echo "Примечание: строка 'export PATH=\"\$HOME/bin:\$PATH\"' в .bashrc и .zshrc не была удалена."
    echo "Вы можете удалить её вручную, если она вам больше не нужна."
fi

echo
echo "Удаление завершено." 
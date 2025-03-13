# Latinizator CLI

![Python](https://ziadoua.github.io/m3-Markdown-Badges/badges/Python/python3.svg) [![GPLv3 License](https://ziadoua.github.io/m3-Markdown-Badges/badges/LicenceGPLv3/licencegplv31.svg)](LICENSE)

CLI-версия [Latinizator](https://github.com/venterum/Latinizator).

## Установка

```bash
git clone https://github.com/venterum/latinizator-cli.git
cd latinizator-cli
```

## Автоматическая установка (скриптом)

```bash
# Сделать установочный скрипт исполняемым
chmod +x install.sh

# Запустить установку
./install.sh
```

## Ручная установка

```bash
# Сделать файл исполняемым
chmod +x latinizator_cli.py

mkdir -p ~/bin
cp latinizator_cli.py ~/bin/latinizator
cp latinizator.py ~/bin/
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

## Удаление

### Автоматическое удаление (скриптом)

```bash
# Сделать скрипт удаления исполняемым
chmod +x uninstall.sh

# Запустить удаление
./uninstall.sh
```

### Ручное удаление

```bash
# Удаление файлов из ~/bin
rm ~/bin/latinizator
rm ~/bin/latinizator.py

# Опционально: удалить строку PATH из .bashrc и .zshrc
# Откройте эти файлы в текстовом редакторе и удалите строку:
# export PATH="$HOME/bin:$PATH"
```

## Использование

### Базовый синтаксис

```bash
latinizator [ТЕКСТ] [ФЛАГ]
```

или, если вы не устанавливали скрипт:

```bash
python latinizator_cli.py [ТЕКСТ] [ОПЦИИ]
```

### Доступные флаги

| Флаг | Полное имя | Описание |
|------|------------|----------|
| `-h` | `--help` | Показать справку |
| `-u` | `--uppercase` | Преобразовать результат в верхний регистр |
| `-l` | `--lowercase` | Преобразовать результат в нижний регистр |
| `-n` | `--no-diacritics` | Удалить диакритические знаки |
| `-i` | `--input-file` | Указать файл с входным текстом |
| `-o` | `--output-file` | Указать файл для сохранения результата |

### Примеры использования

#### Простая транслитерация

```bash
latinizator Привет мир
```

#### Преобразование в верхний регистр

```bash
latinizator Привет мир -u
```

#### Преобразование в нижний регистр

```bash
latinizator Привет Мир -l
```

#### Удаление диакритических знаков

```bash
latinizator Съешь ещё этих мягких французских булок -n
# Вывод: Sjes jesco etih magkih francuzskih bulok
```

#### Работа с файлами

```bash
# Чтение из файла
latinizator -i input.txt

# Запись результата в файл
latinizator Привет мир -o output.txt

# Чтение из файла и запись в файл
latinizator -i input.txt -o output.txt
```

Любые опции можно комбинировать.
#!/usr/bin/env python3
import argparse
import sys
import unicodedata
import os

# Добавляем текущую директорию в путь поиска модулей
script_dir = os.path.dirname(os.path.realpath(__file__))
sys.path.append(script_dir)

try:
    from latinizator import latinizator
except ImportError:
    # Если модуль не найден, выводим понятное сообщение об ошибке
    print("Ошибка: Модуль latinizator не найден.", file=sys.stderr)
    print("Убедитесь, что файл latinizator.py находится в той же директории, что и этот скрипт.", file=sys.stderr)
    sys.exit(1)

def remove_diacritics(text):
    return ''.join(c for c in unicodedata.normalize('NFKD', text)
                  if not unicodedata.combining(c))

def process_text(text, args):
    result = latinizator(text)
    if args.no_diacritics:
        result = remove_diacritics(result)
    if args.uppercase:
        result = result.upper()
    elif args.lowercase:
        result = result.lower()
    return result

def main():
    parser = argparse.ArgumentParser(description='Транслитерация русского текста в латиницу')
    input_group = parser.add_mutually_exclusive_group(required=True)
    input_group.add_argument('text', nargs='*', default=[], help='Текст для транслитерации')
    input_group.add_argument('-i', '--input-file', help='Файл с текстом для транслитерации')
    parser.add_argument('-o', '--output-file', help='Файл для сохранения результата')
    parser.add_argument('-u', '--uppercase', action='store_true', help='Преобразовать результат в верхний регистр')
    parser.add_argument('-l', '--lowercase', action='store_true', help='Преобразовать результат в нижний регистр')
    parser.add_argument('-n', '--no-diacritics', action='store_true', help='Удалить диакритические знаки')
    args = parser.parse_args()
    
    if args.input_file:
        try:
            with open(args.input_file, 'r', encoding='utf-8') as f:
                input_text = f.read()
        except Exception as e:
            print(f"Ошибка при чтении файла: {e}", file=sys.stderr)
            sys.exit(1)
    else:
        input_text = ' '.join(args.text)
    
    result = process_text(input_text, args)
    
    if args.output_file:
        try:
            with open(args.output_file, 'w', encoding='utf-8') as f:
                f.write(result)
        except Exception as e:
            print(f"Ошибка при записи в файл: {e}", file=sys.stderr)
            sys.exit(1)
    else:
        print(result)

if __name__ == "__main__":
    main()
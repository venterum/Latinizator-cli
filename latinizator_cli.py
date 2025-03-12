import argparse
import sys
import unicodedata
from latinizator import latinizator

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
    input_group.add_argument('text', nargs='*', default=[])
    input_group.add_argument('-i', '--input-file')
    parser.add_argument('-o', '--output-file')
    parser.add_argument('-u', '--uppercase', action='store_true')
    parser.add_argument('-l', '--lowercase', action='store_true')
    parser.add_argument('-n', '--no-diacritics', action='store_true')
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
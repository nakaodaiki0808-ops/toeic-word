import csv
import json

input_file = "words.csv"
output_file = "words.json"

words = []

with open(input_file, mode="r", encoding="utf-8-sig") as csvfile:
    reader = csv.DictReader(csvfile)
    for row in reader:
        try:
            id_val = int(row["id"])
        except (ValueError, TypeError):
            # ヘッダの重複や空行など、数値に変換できない行はスキップ
            continue

        # levelも数値に変換できない場合は0を使う
        try:
            level_val = int(row.get("level", 0))
        except (ValueError, TypeError):
            level_val = 0

        word = {
            "id": id_val,
            "word": row.get("word", ""),
            "meaning": row.get("meaning", ""),
            "level": level_val
        }
        words.append(word)

with open(output_file, mode="w", encoding="utf-8") as jsonfile:
    json.dump(words, jsonfile, ensure_ascii=False, indent=2)

print(f"{output_file} を作成しました！")

//python3 csv_to_json.py
import json
import random

# 从源 JSON 文件中读取数据
with open('CrimeKgAssitantClean_52k.json', 'r') as file:
    source_data = json.load(file)

# 随机抽取的记录数量
number_of_records = 40

# 随机抽取指定数量的记录
random_records = random.sample(source_data, number_of_records)

# 将随机抽取的记录写入目标 JSON 文件
with open('example_questions.json', 'w') as file:
    json.dump(random_records, file, indent=2,ensure_ascii=False)

print(f"成功将 {number_of_records} 条记录写入 example_questions.json 文件。")

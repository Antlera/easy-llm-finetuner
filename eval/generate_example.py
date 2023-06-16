import argparse
import json
import random
import os

# Create the argument parser
parser = argparse.ArgumentParser(description='Randomly extract records from a JSON file to generate example questions using GPT.')
parser.add_argument('--srcfile', required=True, help='Path to the source JSON file containing the original test data')
parser.add_argument('--outfile', required=True, help='Path to save the randomly extracted example data generated from the source file')
args = parser.parse_args()

# Get the source file path and output path
source_file_path = args.srcfile
output_path = args.outfile

# Extract the output directory path and file name from the provided output path
output_dir_path, output_file_name = os.path.split(output_path)

# Read data from the source JSON file
with open(source_file_path, 'r') as file:
    source_data = json.load(file)

# Specify the number of records to randomly extract
number_of_records = 40

# Randomly extract the specified number of records
random_records = random.sample(source_data, number_of_records)

# Create the output directory if it doesn't exist
os.makedirs(output_dir_path, exist_ok=True)

# Write the randomly extracted records to the output JSON file
output_file_path = os.path.join(output_dir_path, output_file_name)
with open(output_file_path, 'w+') as file:
    json.dump(random_records, file, indent=2, ensure_ascii=False)

print(f"Successfully wrote {number_of_records} records to {output_file_path}.")

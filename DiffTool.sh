#!/usr/bin/env python3
import difflib
import sys
import subprocess
import argparse
subprocess.call(["python3", "DiffTool.py", "--File1", "value1", "--File2", "value2"])
# Create arguemnt parser
parser = argparse.ArgumentParser()
parser.add_argument("--File1", help="File1 is mandatory", type=str, required=True)
parser.add_argument("--File2", help="File2 is optional", type=str, required=True)
args = parser.parse_args()

file1 = args.File1
file2 = args.File2

def compare_text_files(file1, file2):
    with open(file1, "r") as f1, open(file2, "r") as f2:
        text1 = f1.read().splitlines()
        text2 = f2.read().splitlines()

        for i, (line1, line2) in enumerate(zip(text1, text2)):
            words1 = line1.split(" ")
            words2 = line2.split(" ")
            d = difflib.Differ()
            diff = list(d.compare(words1, words2))

            for word in diff:
                if word.startswith(" "):
                    sys.stdout.write("\033[0m" + word[2:] + " ")
                elif word.startswith("+"):
                    sys.stdout.write("\033[32m" + word[2:] + " ")
                elif word.startswith("-"):
                    sys.stdout.write("\033[31m" + word[2:] + " ")
            sys.stdout.write("\n")

print("\033[33m///////////////////////////////////////////////////////////////////////////////////////\033[0m")
print("""\033[94mthe output key: 
Similar words remain white
The words added in the second file appear in green
The words deleted in the first file appear in red
Modification is represented by the appearance of the 
deleted word from the first file, followed by the added 
word from the second file, or vice versa\033[0m""")
print("\033[33m///////////////////////////////////////////////////////////////////////////////////////\033[0m")
compare_text_files(file1, file2)
print("\033[33m///////////////////////////////////////////////////////////////////////////////////////\033[0m")

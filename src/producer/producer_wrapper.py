import sys
import os
import subprocess

def main():
    data_files_dir = str(sys.argv[1])
    for data_file in os.listdir(data_files_dir):
        csv_file = data_files_dir + '/' + data_file
        stream_name = data_file.split('.')[0].replace('_','-') + "-stream"
        p = subprocess.Popen([sys.executable, "producer.py", csv_file, stream_name],
                             stdout=subprocess.PIPE,
                             stderr=subprocess.STDOUT)

if __name__ == "__main__":
    main()

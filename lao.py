import requests as r
import re
import json
import sys

from tqdm import tqdm
from os import popen

if len(sys.argv) < 2:
    exit("Madarchod Path Kaun Dalega ?")
elif len(sys.argv) < 3:
    exit("Aur Output Path :|")


file_path = sys.argv[1]
save = sys.argv[2]

config = json.loads(open("./config.json","r").read())
chunk_size = 20480
getmd5 = lambda x:popen(f"md5sum {x}").readlines()[0].split(" ")[0]

if __name__ == "__main__":
    FILE = r.get(f"http://{config['address']}:{config['port']}/{file_path}", stream=True)
    STEPS = int(FILE.headers['Content-Length']) // chunk_size
    MD5 = r.get(f"http://{config['address']}:{config['port']}/md5/{file_path}")

    with open(f"{save}","wb+") as file:
        for chunk in tqdm(FILE.iter_content(chunk_size=chunk_size),total=STEPS):
            file.write(chunk)

    if getmd5(save) == MD5.text:
        print (f"File {save} Downloaded Successfully !")
    else:
        popen(f"rm -rf {save}")


from flask import Flask,request,send_from_directory,jsonify,send_file
from flask_cors import CORS
from os import popen

app = Flask(__name__)
CORS(app)

root = "/home/dev-harsh1998"
getMD5 = lambda x:popen(f"md5sum {x}").readlines()[0].split(" ")[0]
md5Checks = {}

@app.route('/<path:file_path>')
def get_file(file_path):
    file_path = f"{root}/{file_path}"
    md5Checks[file_path] = getMD5(file_path)
    return send_file(f"{file_path}")

@app.route("/md5/<path:file_path>")
def md5(file_path):
    return md5Checks[f"{root}/{file_path}"]

if __name__ == '__main__':
    app.run(host="0.0.0.0",debug=True,port=2525,threaded=True)
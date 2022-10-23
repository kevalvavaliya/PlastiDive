from re import DEBUG, sub
from flask import Flask, request, redirect, jsonify
from werkzeug.utils import secure_filename, send_from_directory
import os
from detect import run
from azure.identity import DefaultAzureCredential
import os
import uuid
from azure.storage.blob import BlobServiceClient, BlobClient, ContainerClient
from flask_cors import CORS

app = Flask(__name__)
uploads_dir = os.path.join(app.instance_path, 'uploads')
CORS(app)

os.makedirs(uploads_dir, exist_ok=True)

# @app.route("/")
# def hello_world():
# return render_template('index.html')


@app.route("/detect", methods=['POST'])
def detect():
    if not request.method == "POST":
        return
    values = request.get_json()
    if 'image_url' not in values:
        return jsonify({'message': 'image not found'}), 400
    # uuidname = uuid.uuid4()
    # filename = 'runs/detect/' + uuidname
    count = run(weights='a.pt',
                imgsz=[640, 640],
                source=values['image_url'],
                name='newfodlerTest')
    resp = {"no_of_trash": count}
    return jsonify(resp), 200


# @app.route("/opencam", methods=['GET'])
# def opencam():
#     print("here")
#     subprocess.run(['python3', 'detect.py', '--source', '0'])
#     return "done"

# @app.route('/return-files', methods=['GET'])
# def return_file():
#     obj = request.args.get('obj')
#     loc = os.path.join("runs/detect", obj)
#     print(loc)
#     try:
#         return send_file(os.path.join("runs/detect", obj), attachment_filename=obj)
#         # return send_from_directory(loc, obj)
#     except Exception as e:
#         return str(e)

# @app.route('/display/<filename>')
# def display_video(filename):
# 	#print('display_video filename: ' + filename)
# 	return redirect(url_for('static/video_1.mp4', code=200))

@app.route('/upload', methods=['POST'])
def upload_file():
    video = request.files['image']
    video.save(os.path.join(uploads_dir, secure_filename(video.filename)))
    print(video)
    uuidname = uuid.uuid4()

    count = run(weights='a.pt',
                imgsz=[640, 640],
                source=os.path.join(uploads_dir, secure_filename(video.filename)),
                name=uuidname)

    upload_file_path = "runs/detect/" + uuidname + '/' + video.filename

    return 'done'


if __name__ == '__main__':
    app.run(port=5555)

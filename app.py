import os
from flask import Flask, request, jsonify, send_from_directory,render_template

app = Flask(__name__)

# Define the directory to store output files
OUTPUT_FOLDER = 'generated_files'

# Ensure the directory exists
if not os.path.exists(OUTPUT_FOLDER):
    os.makedirs(OUTPUT_FOLDER)

@app.route('/')
def home():
    # subprocess.run(['openscad', '--help'], check=True)
    return render_template("index.html" ,identifier="difference() { cylinder(h = 10, d = 50); cylinder(h = 10, d = 30); }")

@app.route('/generated_files/<path:filename>')
def serve_dynamic_file(filename):
    return send_from_directory(OUTPUT_FOLDER , filename)




@app.route('/upload', methods=['POST'])
def upload_file():
    if 'file' not in request.files:
        return {'error': 'No file part'}, 400

    file = request.files['file']
    if file:
        filename = file.filename
        filepath = os.path.join(OUTPUT_FOLDER, filename)
        file.save(filepath)
        return {"message":"successfull"}
    
    return {'error': 'No file selected'}, 400

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

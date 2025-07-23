from flask import Flask, render_template, request
import pandas as pd
from bertopic import BERTopic

app = Flask(__name__)

# Load model dan data (PERHATIKAN: relative path ke atas)
topic_model = BERTopic.load("../bertopic_model")
df = pd.read_csv("../embedding_umap.csv")

@app.route("/", methods=["GET", "POST"])
def index():
    topic = None
    if request.method == "POST":
        input_review = request.form["review"]
        topics, _ = topic_model.transform([input_review])
        topic = topics[0]
    return render_template("index.html", topic=topic)

if __name__ == "__main__":
    app.run(debug=True)

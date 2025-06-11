from flask import Flask

app = Flask(__name__)

# Home route
@app.route("/")
def home():
    return "Hello, World! Welcome to your Dockerized Flask app!"

if __name__ == "__main__":
    # Run the app on host 0.0.0.0 to make it accessible outside the container
    app.run(host="0.0.0.0", port=5000)
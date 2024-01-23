from flask import Flask
from flask_mail import Mail, Message

app = Flask(__name__)

app.config['MAIL_SERVER'] = 'sandbox.smtp.mailtrap.io'
app.config['MAIL_PORT'] = 2525
app.config['MAIL_USERNAME'] = 'c74de9b4d3f0a8'
app.config['MAIL_PASSWORD'] = 'c943645b2d104f'
app.config['MAIL_USE_TLS'] = True
app.config['MAIL_USE_SSL'] = False
mail = Mail(app)


@app.route("/")
def index():
    msg = Message(subject='Hello from the other side!', sender='from@example.com', recipients=['subham.singh@telgoo5.com'])
    msg.body = "Hey Paul, sending you this email from my Flask app, lmk if it works"
    mail.send(msg)
    return "Message sent!"


if __name__ == '__main__':
    app.run(debug=True)

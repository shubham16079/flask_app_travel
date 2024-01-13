from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_babel import Babel

app = Flask(__name__,static_url_path='/static')
app.config.from_pyfile('config.py')
db = SQLAlchemy(app)
babel = Babel(app)

from app import routes

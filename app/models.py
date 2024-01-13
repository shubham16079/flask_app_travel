from datetime import datetime
from app import db


class User(db.Model):
    print('user')


class Destination(db.Model):
    print('destination')


class Category(db.Model):
    print('category')


class Review(db.Model):
    print('review')

from datetime import datetime
from app import db


class Experience(db.Model):
    __tablename__ = 'experiences'
    id = db.Column(db.Integer, primary_key=True)
    slug = db.Column()
    description = db.Column()
    @classmethod
    def get_by_slug(cls, slug):
        return cls.query.filter_by(slug=slug).all()
    
    @classmethod
    def get_all(cls):
        return cls.query.all()
    
class Destination(db.Model):
    __tablename__ = 'destinations'
    id = db.Column(db.Integer, primary_key=True)
    slug = db.Column()
    description = db.Column()
    @classmethod
    def get_destination_by_slug(cls, slug):
        return cls.query.filter_by(slug=slug).all()
    
    @classmethod
    def get_all_destinations(cls):
        return cls.query.all()    

     



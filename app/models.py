from datetime import datetime
from app import db


class Experience(db.Model):
    __tablename__ = 'experiences'
    id = db.Column(db.Integer, primary_key=True)
    slug = db.Column()
    description = db.Column()
    destination = db.Column() 
    image = db.Column() 
    category = db.Column(db.Integer, db.ForeignKey('categories.id'))
    categories = db.relationship('Category',foreign_keys=[category],  backref='experiences')

    @classmethod
    def get_by_slug(cls, slug):
        return cls.query.filter_by(slug=slug).all()
    
    
    @classmethod
    def get_experience_by_destination_id(cls, destination_id):
        return cls.query.filter_by(destination=destination_id).all()
    
    @classmethod
    def get_all_categories_by_destination(cls,destination_id):
        return db.session.query(Category.id,Category.name, Category.image).\
        join(Experience, Experience.category == Category.id).\
        filter(Experience.destination == destination_id).distinct().all()

    @classmethod
    def get_all(cls):
        return cls.query.all()

class Category(db.Model):
    __tablename__ = 'categories'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(255), nullable=False)    
    image = db.Column(db.String(255))


class Destination(db.Model):
    __tablename__ = 'destinations'
    id = db.Column(db.Integer, primary_key=True)
    slug = db.Column()
    description = db.Column()
    category = db.Column(db.Integer, db.ForeignKey('categories.id'))
    categories = db.relationship('Category',foreign_keys=[category],  backref='destinations')

    @classmethod
    def get_destination_by_slug(cls, slug):
        return cls.query.filter_by(slug=slug).all()

    @classmethod
    def get_all_destinations(cls):
        return cls.query.all()

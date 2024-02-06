from datetime import datetime
from sqlalchemy import or_
from app import db


class Experience(db.Model):
    __tablename__ = 'experiences'
    id = db.Column(db.Integer, primary_key=True)
    slug = db.Column()
    description = db.Column()
    destination = db.Column() 
    image = db.Column() 
    slider_image = db.Column()
    name = db.Column()
    status = db.Column()
    landmark = db.Column()
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
        return db.session.query(Category.id,Category.name, Category.image,Category.slug).\
        join(Experience, Experience.category == Category.id).\
        filter(Experience.destination == destination_id).distinct().all()

    @classmethod
    def get_all(cls):
        return cls.query.all()
    
    
    @classmethod
    def get_experiences_by_search(cls, search_text): 
       return cls.query.filter(
            (cls.name.ilike(f"%{search_text}%")) | (cls.slug.ilike(f"%{search_text}%"))
        ).limit(10).all()
        
    @classmethod
    def get_other_experiences(cls,slug):
        return cls.query.filter(cls.slug != slug).limit(8).all() 
    
    @classmethod
    def get_experiences_list(cls, start, length,search_value):
        query = cls.query
        total_records = query.count()
        if search_value:
            search_pattern = f"%{search_value}%"
            query = query.filter(
                or_(
                    cls.name.ilike(search_pattern),
                    cls.landmark.ilike(search_pattern),
                    cls.slug.ilike(search_pattern)
                )
            )
        experiences_list = query.filter(cls.status =='active').offset(start).limit(length).all()
        return experiences_list, total_records
    
    @classmethod
    def get_experiences_by_category(cls, slug):
     if slug == 'all':
        return cls.query.all()
     else:
        category_id = db.session.query(Category.id).filter(Category.slug == slug).scalar()
        return cls.query.filter_by(category=category_id,status='active').all()
     
    @classmethod
    def get_experiences_by_search(cls, search_text): 
       return cls.query.filter(
            (cls.name.ilike(f"%{search_text}%") | (cls.slug.ilike(f"%{search_text}%")))
            & (cls.status == 'active')
        ).limit(10).all()

    @classmethod
    def get_other_experiences(cls,slug):
        return cls.query.filter(cls.slug != slug).limit(8).all() 
    @classmethod
    def save_new_experience(cls,form_data):
        new_experience = cls(**form_data)
        db.session.add(new_experience)
        db.session.commit()
        return new_experience
    
    @classmethod
    def update_experience(cls, experience_id, form_data):
        experience = cls.query.get(experience_id)

        if experience:
            for key, value in form_data.items():
                setattr(experience, key, value)

            db.session.commit()

        return experience 
    @classmethod
    def delete_experience(cls, experience_id):
        experience = cls.query.get_or_404(experience_id)
        experience.status = 'inactive'
        db.session.commit()
    

class Category(db.Model):
    __tablename__ = 'categories'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(255), nullable=False)    
    image = db.Column(db.String(255))
    slug = db.Column(db.String(50))
    @classmethod
    def get_all_categories(cls):
        return cls.query.all()


class Destination(db.Model):
    __tablename__ = 'destinations'
    id = db.Column(db.Integer, primary_key=True)
    slug = db.Column()
    description = db.Column()
    image = db.Column()
    status = db.Column()
    slider_image = db.Column()
    name = db.Column()
    location = db.Column()
    category = db.Column(db.Integer, db.ForeignKey('categories.id'))
    categories = db.relationship('Category',foreign_keys=[category],  backref='destinations')

    @classmethod
    def get_destination_by_slug(cls, slug):
        return cls.query.filter_by(slug=slug).all()

    @classmethod
    def get_all_destinations(cls):
        return cls.query.all()

    @classmethod
    def get_destinations_list(cls, start, length,search_value):
        query = cls.query
        total_records = query.count()
        if search_value:
            search_pattern = f"%{search_value}%"
            query = query.filter(
                or_(
                    cls.name.ilike(search_pattern),
                    cls.location.ilike(search_pattern),
                    cls.slug.ilike(search_pattern)
                )
            )
        destinations_list = query.filter(cls.status == 'active').offset(start).limit(length).all()
        return destinations_list, total_records
    
    @classmethod
    def get_destinations_by_category(cls, slug):
     if slug == 'all':
        return cls.query.all()
     else:
        category_id = db.session.query(Category.id).filter(Category.slug == slug).scalar()
        return cls.query.filter_by(category=category_id).all()
     
    @classmethod
    def get_destinations_by_search(cls, search_text): 
       return cls.query.filter(
            (cls.name.ilike(f"%{search_text}%") | (cls.slug.ilike(f"%{search_text}%")))
            & (cls.status == 'active')
        ).limit(10).all()

    @classmethod
    def get_other_destinations(cls,slug):
        return cls.query.filter(cls.slug != slug).limit(8).all() 
    @classmethod
    def save_new_destination(cls,form_data):
        new_destination = cls(**form_data)
        db.session.add(new_destination)
        db.session.commit()
        return new_destination
    
    @classmethod
    def update_destination(cls, destination_id, form_data):
        destination = cls.query.get(destination_id)

        if destination:
            for key, value in form_data.items():
                setattr(destination, key, value)

            db.session.commit()

        return destination 
    @classmethod
    def delete_destination(cls, destination_id):
        destination = cls.query.get_or_404(destination_id)
        db.session.delete(destination)
        db.session.commit()

from flask import render_template, redirect, url_for,g,request
from app import app
from app import models


@app.context_processor
def inject_data():
    experiences = [
        {'name': 'Adventure', 'image': 'adventure.jpeg'},
        {'name': 'Art', 'image': 'art.jpeg'},
        {'name': 'Heritage', 'image': 'heritage.jpeg'},
        {'name': 'Shopping', 'image': 'shopping.jpeg'},
        {'name': 'Spiritual', 'image': 'spritual.jpeg'},
        {'name': 'Luxury', 'image': 'luxury.jpeg'},
        {'name': 'Craft', 'image': 'craft.jpeg'},
        {'name': 'Museums', 'image': 'museums.jpeg'},
        {'name': 'Unesco', 'image': 'unesco.jpeg'},
        {'name': 'Yoga', 'image': 'yoga.jpeg'},
        {'name': 'Food', 'image': 'food.jpeg'},
        {'name': 'Nature', 'image': 'nature.jpeg'},
    ]
    destinations = [
        {'name': 'Popular', 'image': 'adventure.jpeg'},
        {'name': 'All', 'image': 'art.jpeg'},
        {'name': 'Heritage', 'image': 'heritage.jpeg'},
        {'name': 'Shopping', 'image': 'shopping.jpeg'},
        {'name': 'Spiritual', 'image': 'spritual.jpeg'},
        {'name': 'Luxury', 'image': 'luxury.jpeg'}
    ]
    return dict(experiences=experiences, destinations=destinations)

@app.route('/')
@app.route('/home')
def home():
    page = request.args.get('page', 1, type=int)
    per_page = 8
    home_destinations = models.Destination.query.paginate(page=page, per_page=per_page, error_out=False)
    return render_template('home.html', home_destinations=home_destinations)


@app.route('/set-locale/<lang>')
def set_locale(lang):
    g.lang = lang
    return redirect(url_for('home'))

@app.route('/experiences/<slug>')
def experience_by_slug(slug):
     experiences_test = models.Experience.get_by_slug(slug)
     return render_template('experience.html',slug=slug, experiences_test=experiences_test)

@app.route('/experiences')
def all_experiences():
    page = request.args.get('page', 1, type=int)
    per_page = 8
    experiences_pagination = models.Experience.query.paginate(page=page, per_page=per_page, error_out=False)
    return render_template('experience.html', experiences_pagination=experiences_pagination)

@app.route('/destinations/<slug>')
def destination_by_slug(slug):
     destinations_test = models.Destination.get_destination_by_slug(slug)
     destination_id = destinations_test[0].id if destinations_test else None
     experince_data = models.Experience.get_experience_by_destination_id(destination_id)
     return render_template('destination.html',slug=slug, destinations_test=destinations_test,experince_data=experince_data)

@app.route('/destinations')
def all_destinations():
    page = request.args.get('page', 1, type=int)
    per_page = 8
    all_destinations = models.Destination.query.paginate(page=page, per_page=per_page, error_out=False)
    return render_template('destination.html', all_destinations=all_destinations)
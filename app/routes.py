from flask import render_template, redirect, url_for,g
from app import app
from app import models


@app.route('/')
@app.route('/home')
def home():
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
    return render_template('home.html', experiences=experiences, destinations=destinations)


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
     all_experiences = models.Experience.get_all()
     return render_template('experience.html', all_experiences=all_experiences)

@app.route('/destinations/<slug>')
def destination_by_slug(slug):
     destinations_test = models.Destination.get_destination_by_slug(slug)
     return render_template('destination.html',slug=slug, destinations_test=destinations_test)

@app.route('/destinations')
def all_destinations():
     all_destinations = models.Destination.get_all_destinations()
     return render_template('destination.html', all_destinations=all_destinations)
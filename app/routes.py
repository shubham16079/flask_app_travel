from flask import render_template, redirect, url_for,g
from app import app


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
    return render_template('home.html', experiences=experiences)


@app.route('/set-locale/<lang>')
def set_locale(lang):
    g.lang = lang
    return redirect(url_for('home'))


if __name__ == '__main__':
    app.run(debug=True)

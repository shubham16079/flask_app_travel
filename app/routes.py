from flask import render_template, redirect, url_for,g,request,jsonify
from app import app
from app import models


@app.context_processor
def inject_data():
    experiences = [
        {'name': 'Adventure', 'image': 'adventure.jpeg', 'slug': 'adventure'},
        {'name': 'Arts', 'image': 'art.jpeg', 'slug': 'art'},
        {'name': 'Heritage', 'image': 'heritage.jpeg', 'slug': 'heritage'},
        {'name': 'Shopping', 'image': 'shopping.jpeg', 'slug': 'shopping'},
        {'name': 'Spiritual', 'image': 'spritual.jpeg', 'slug': 'spiritual'},
        {'name': 'Luxury', 'image': 'luxury.jpeg', 'slug': 'luxury'},
        {'name': 'Craft', 'image': 'craft.jpeg', 'slug': 'craft'},
        {'name': 'Museums', 'image': 'museums.jpeg', 'slug': 'museums'},
        {'name': 'Unesco', 'image': 'unesco.jpeg', 'slug': 'unesco'},
        {'name': 'Yoga', 'image': 'yoga.jpeg', 'slug': 'yoga'},
        {'name': 'Food', 'image': 'food.jpeg', 'slug': 'food'},
        {'name': 'Nature', 'image': 'nature.jpeg', 'slug': 'nature'}
    ]
    destinations = [
        {'name': 'Popular', 'image': 'adventure.jpeg', 'slug': 'popular'},
        {'name': 'Destinations', 'image': 'art.jpeg', 'slug': 'all'},
        {'name': 'Heritage', 'image': 'heritage.jpeg', 'slug': 'heritage'},
        {'name': 'Shopping', 'image': 'shopping.jpeg', 'slug': 'shopping'},
        {'name': 'Spiritual', 'image': 'spritual.jpeg', 'slug': 'spiritual'},
        {'name': 'Luxury', 'image': 'luxury.jpeg', 'slug': 'luxury'}
    ]
    return dict(experiences=experiences, destinations=destinations)

@app.errorhandler(404)
def page_not_found(e):
    return render_template('404.html'), 404

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

@app.route('/experience/<slug>')
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
     unique_categories = models.Experience.get_all_categories_by_destination(destination_id)
     return render_template('destination.html',slug=slug, destinations_test=destinations_test,experince_data=experince_data,unique_categories=unique_categories)

@app.route('/destinations')
def all_destinations():
    page = request.args.get('page', 1, type=int)
    per_page = 8
    all_destinations = models.Destination.query.paginate(page=page, per_page=per_page, error_out=False)
    return render_template('destination.html', all_destinations=all_destinations)

@app.route('/ajax/experiences', methods=['POST'])
def ajax_experiences():
    data = request.json  
    destination_id = data.get('destination_id')
    category_id = data.get('category_id')
    experiences_data = models.Experience.query.filter_by(destination=destination_id, category=category_id).all()
    experiences = [{'slug': exp.slug, 'description': exp.description,'image': exp.image} for exp in experiences_data]
    return jsonify({'experiences': experiences})

@app.route('/experiences/category/<slug>')
def experiences_category(slug):
     experiences_by_category = models.Experience.get_experiences_by_category(slug)
     return render_template('experience.html',is_category_wise=1,slug=slug, experiences_by_category=experiences_by_category)

@app.route('/destinations/category/<slug>')
def destinations_category(slug):
     destinations_by_category = models.Destination.get_destinations_by_category(slug)
     return render_template('destination.html',is_category_wise=1,slug=slug, destinations_by_category=destinations_by_category)

@app.route('/ajax/common-search', methods=['POST'])
def common_search():
    data = request.json  
    search_text = data.get('search_text','').strip()  
    destinations = models.Destination.get_destinations_by_search(search_text)
    destinations_list = [
        {
            'id': destination.id,
            'slug': destination.slug,
            'description': destination.description,
            'image': destination.image,
            'name': destination.name,
            'category': destination.category
        }
        for destination in destinations
    ]
    experiences = models.Experience.get_experiences_by_search(search_text)
    experiences_list = [
        {
            'id': experience.id,
            'slug': experience.slug,
            'description': experience.description,
            'image': experience.image,
            'name': experience.name,
            'category': experience.category
        }
        for experience in experiences
    ]
    result_dict = {
        'destinations': destinations_list,
        'experiences': experiences_list
    }
    return jsonify(result_dict)
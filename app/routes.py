from flask import render_template, redirect, url_for, g, request, jsonify, session, flash, Blueprint
from app import app
from app import models
from werkzeug.utils import secure_filename
import os
from .forms import NewDestinationForm,EditDestinationForm,NewExperienceForm,EditExperienceForm


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
    destination_id = experiences_test[0].destination
    other_experiences = models.Experience.get_other_experiences(slug,destination_id)
    return render_template('experience.html', slug=slug, experiences_test=experiences_test,
                           other_experiences=other_experiences)


@app.route('/experiences')
def all_experiences():
    page = request.args.get('page', 1, type=int)
    per_page = 8
    experiences_pagination = models.Experience.query.paginate(page=page, per_page=per_page, error_out=False)
    return render_template('experience.html', experiences_pagination=experiences_pagination)


@app.route('/destinations/<slug>')
def destination_by_slug(slug):
    destinations_test = models.Destination.get_destination_by_slug(slug)
    other_destinations = models.Destination.get_other_destinations(slug)
    destination_id = destinations_test[0].id if destinations_test else None
    experince_data = models.Experience.get_experience_by_destination_id(destination_id)
    unique_categories = models.Experience.get_all_categories_by_destination(destination_id)
    return render_template('destination.html', slug=slug, destinations_test=destinations_test,
                           experince_data=experince_data, unique_categories=unique_categories,
                           other_destinations=other_destinations)


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
    experiences = [{'slug': exp.slug, 'description': exp.description, 'image': exp.image,'name':exp.name} for exp in experiences_data]
    return jsonify({'experiences': experiences})


@app.route('/experiences/category/<slug>')
def experiences_category(slug):
    experiences_by_category = models.Experience.get_experiences_by_category(slug)
    return render_template('experience.html', is_category_wise=1, slug=slug,
                           experiences_by_category=experiences_by_category)


@app.route('/destinations/category/<slug>')
def destinations_category(slug):
    destinations_by_category = models.Destination.get_destinations_by_category(slug)
    return render_template('destination.html', is_category_wise=1, slug=slug,
                           destinations_by_category=destinations_by_category)


@app.route('/ajax/common-search', methods=['POST'])
def common_search():
    data = request.json
    search_text = data.get('search_text', '').strip()
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


def login_required(view_func):
    def wrapper(*args, **kwargs):
        if not session.get('isLoggedIn'):
            flash('Please log in to access this page.', 'warning')
            return redirect(url_for('login'))
        return view_func(*args, **kwargs)

    return wrapper


@app.route('/admin')
def admin():
    if session.get('isLoggedIn'):
        return render_template('admin/admin.html', test_data="you are logged in")
    else:
        return redirect(url_for('login'))


@app.route('/admin/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        if request.form['email'] == 'admin@gmail.com' and request.form['password'] == 'password':
            session['isLoggedIn'] = True
            flash('Login successful!', 'success')
            return redirect(url_for('admin'))
        else:
            flash('Invalid credentials. Please try again.', 'error')

    return render_template('admin/login.html')


@app.route('/admin/logout')
def logout():
    session.pop('isLoggedIn', None)
    flash('You have been logged out.', 'info')
    return redirect(url_for('admin'))


@app.route('/admin/add_new_destination', methods=['GET', 'POST'])
# @login_required
def new_destination():
    categories = models.Category.get_all_categories()
    states = models.State.get_all_states()
    form = NewDestinationForm()
    if request.method == 'POST':
        form.set_category_choices(categories)
        if form.validate_on_submit():
            isExistDestination = models.Destination.get_destination_by_slug(request.form.get('slug'))
            if isExistDestination:
                flash('Destination already exist', 'success')
                return render_template('admin/add_new_destination.html', form=form, categories=categories)
            form_data = request.form.to_dict()
            if 'image' in request.files:
                image = request.files['image']
                if image.filename != '':
                    DESTINATION_FOLDER = os.path.join(os.getcwd(), 'app', 'static', 'images', 'destinations')
                    os.makedirs(DESTINATION_FOLDER, exist_ok=True)
                    save_image = image.save(os.path.join(DESTINATION_FOLDER, secure_filename(image.filename)))
                    form_data['image'] = image.filename
            if 'slider_image' in request.files:
                image = request.files['slider_image']
                if image.filename != '':
                    DESTINATION_FOLDER = os.path.join(os.getcwd(), 'app', 'static', 'images', 'destinations','slider')
                    os.makedirs(DESTINATION_FOLDER, exist_ok=True)
                    save_image = image.save(os.path.join(DESTINATION_FOLDER, secure_filename(image.filename)))
                    form_data['slider_image'] = image.filename

            lastInsertId = models.Destination.save_new_destination(form_data)
            if lastInsertId:
                flash('Destination Saved!', 'success')

    return render_template('admin/add_new_destination.html', form=form, categories=categories,states=states)


@app.route('/admin/destinations')
def get_destinations():
    return render_template('admin/destinations.html')


@app.route('/admin/destinations-list', methods=['POST'])
def get_destinations_list():
    data = request.get_json()
    draw = data.get('draw', 1)
    start = data.get('start', 0)
    length = data.get('length', 10)
    search_value = data.get('search', {}).get('value', '')
    destinations_list, total_records = models.Destination.get_destinations_list(start, length,search_value)

    destination_list = [{'id': destination.id, 'name': destination.name, 'location': destination.location,
                         'slug': destination.slug,
                         'category_name': destination.category if destination.category else ''}
                        for destination in destinations_list]

    response = {
        'draw': draw,
        'recordsTotal': total_records,
        'recordsFiltered': total_records,
        'data': destination_list
    }

    return jsonify(response)

@app.route('/admin/edit-destination/<int:id>', methods=['GET', 'POST'])
# @login_required
def edit_destination(id):
    categories = models.Category.get_all_categories()
    destination = models.Destination.query.get_or_404(id)
    form = EditDestinationForm(obj=destination)

    if request.method == 'POST':
        form.set_category_choices(categories)
        if form.validate_on_submit():
            form_data = request.form.to_dict()
            if 'image' in request.files:
                image = request.files['image']
                if image.filename != '':
                    DESTINATION_FOLDER = os.path.join(os.getcwd(), 'app', 'static', 'images', 'destinations')
                    os.makedirs(DESTINATION_FOLDER, exist_ok=True)
                    save_image = image.save(os.path.join(DESTINATION_FOLDER, secure_filename(image.filename)))
                    form_data['image'] = image.filename
            if 'slider_image' in request.files:
                image = request.files['slider_image']
                if image.filename != '':
                    DESTINATION_FOLDER = os.path.join(os.getcwd(), 'app', 'static', 'images', 'destinations','slider')
                    os.makedirs(DESTINATION_FOLDER, exist_ok=True)
                    save_image = image.save(os.path.join(DESTINATION_FOLDER, secure_filename(image.filename)))
                    form_data['slider_image'] = image.filename

            models.Destination.update_destination(id, form_data)
            flash('Destination Updated!', 'success')
            return redirect(url_for('get_destinations'))

    return render_template('admin/edit_destination.html', form=form, categories=categories, destination=destination)

@app.route('/admin/delete-destination/<int:id>', methods=['POST'])
# @login_required
def delete_destination(id):
    destination = models.Destination.query.get_or_404(id)
    models.Destination.delete_destination(id)
    flash('Destination deleted successfully!', 'success')
    return redirect(url_for('get_destinations'))

@app.route('/admin/add_new_experience', methods=['GET', 'POST'])
# @login_required
def new_experience():
    categories = models.Category.get_all_categories()
    destinations = models.Destination.get_all_destinations()
    form = NewExperienceForm()
    if request.method == 'POST':
        form.set_category_choices(categories)
        form.set_destination_choices(destinations)
        if form.validate_on_submit():
            isExistExperience = models.Experience.get_by_slug(request.form.get('slug'))
            if isExistExperience:
                flash('Experience already exist', 'success')
                return render_template('admin/add_new_experience.html', form=form, categories=categories)
            form_data = request.form.to_dict()
            if 'image' in request.files:
                image = request.files['image']
                if image.filename != '':
                    EXPERIENCE_FOLDER = os.path.join(os.getcwd(), 'app', 'static', 'images', 'experiences')
                    os.makedirs(EXPERIENCE_FOLDER, exist_ok=True)
                    save_image = image.save(os.path.join(EXPERIENCE_FOLDER, secure_filename(image.filename)))
                    form_data['image'] = image.filename
            if 'slider_image' in request.files:
                image = request.files['slider_image']
                if image.filename != '':
                    EXPERIENCE_FOLDER = os.path.join(os.getcwd(), 'app', 'static', 'images', 'experiences','slider')
                    os.makedirs(EXPERIENCE_FOLDER, exist_ok=True)
                    save_image = image.save(os.path.join(EXPERIENCE_FOLDER, secure_filename(image.filename)))
                    form_data['slider_image'] = image.filename

            lastInsertId = models.Experience.save_new_experience(form_data)
            if lastInsertId:
                flash('Experience Saved!', 'success')

    return render_template('admin/add_new_experience.html', form=form, categories=categories,destinations=destinations)

@app.route('/admin/experiences')
def get_experiences():
    return render_template('admin/experiences.html')


@app.route('/admin/experiences-list', methods=['POST'])
def get_experiences_list():
    data = request.get_json()
    draw = data.get('draw', 1)
    start = data.get('start', 0)
    length = data.get('length', 10)
    search_value = data.get('search', {}).get('value', '')
    experiences_list, total_records = models.Experience.get_experiences_list(start, length,search_value)

    experience_list = [{'id': experience.id, 'name': experience.name, 'landmark': experience.landmark,
                         'slug': experience.slug,
                         'category_name': experience.category if experience.category else ''}
                        for experience in experiences_list]

    response = {
        'draw': draw,
        'recordsTotal': total_records,
        'recordsFiltered': total_records,
        'data': experience_list
    }

    return jsonify(response)

@app.route('/admin/edit-experience/<int:id>', methods=['GET', 'POST'])
# @login_required
def edit_experience(id):
    categories = models.Category.get_all_categories()
    experience = models.Experience.query.get_or_404(id)
    destinations = models.Destination.get_all_destinations()
    form = EditExperienceForm(obj=experience)

    if request.method == 'POST':
        form.set_category_choices(categories)
        form.set_destination_choices(categories)
        if form.validate_on_submit():
            form_data = request.form.to_dict()
            print(form_data['previous_image'])
            if 'image' in request.files:
                image = request.files['image']
                if image.filename != '':
                    EXPERIENCE_FOLDER = os.path.join(os.getcwd(), 'app', 'static', 'images', 'experiences')
                    os.makedirs(EXPERIENCE_FOLDER, exist_ok=True)
                    save_image = image.save(os.path.join(EXPERIENCE_FOLDER, secure_filename(image.filename)))
                    form_data['image'] = image.filename
            if 'slider_image' in request.files:
                image = request.files['slider_image']
                if image.filename != '':
                    EXPERIENCE_FOLDER = os.path.join(os.getcwd(), 'app', 'static', 'images', 'experiences','slider')
                    os.makedirs(EXPERIENCE_FOLDER, exist_ok=True)
                    save_image = image.save(os.path.join(EXPERIENCE_FOLDER, secure_filename(image.filename)))
                    form_data['slider_image'] = image.filename

            models.Experience.update_experience(id, form_data)
            flash('Experience Updated!', 'success')
            return redirect(url_for('get_experiences'))

    return render_template('admin/edit_experience.html', form=form, categories=categories, experience=experience,destinations=destinations)

@app.route('/admin/delete-experience/<int:id>', methods=['POST'])
# @login_required
def delete_experience(id):
    destination = models.Experience.query.get_or_404(id)
    models.Experience.delete_experience(id)
    flash('Experience deleted successfully!', 'deleted')
    return redirect(url_for('get_experiences'))
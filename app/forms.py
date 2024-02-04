from flask_wtf import FlaskForm
from wtforms import StringField, TextAreaField, FileField, SelectField, SubmitField
from wtforms.validators import DataRequired, Length


class NewDestinationForm(FlaskForm):
    name = StringField('Name', validators=[DataRequired(), Length(max=255)])
    description = TextAreaField('Description', validators=[DataRequired()])
    location = StringField('Location', validators=[DataRequired(), Length(max=255)])
    slug = StringField('Slug', validators=[DataRequired(), Length(max=255)])
    image = FileField('Image', validators=[DataRequired()])
    category = SelectField('category', coerce=int, validators=[DataRequired()])
    submit = SubmitField('Submit')

    class Meta:
        csrf = False

    def set_category_choices(self, categories):
        self.category.choices = [(category.id, category.name) for category in categories]

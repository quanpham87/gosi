from datetime import datetime

from metapp.core import db
from metapp import app

class Post(db.Model):
	id = db.Column(db.Integer, primary_key=True)
	title = db.Column(db.String(80))
	body = db.Column(db.Text)
	pub_date = db.Column(db.DateTime)

	def __init__(self, title, body, pub_date=None):
		self.title = title
		self.body = body
		if pub_date is None:
			pub_date = datetime.utcnow()
		self.pub_date = pub_date

	def __repr__(self):
		return '<Post %r>' % self.title

class Comment(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    body = db.Column(db.Text)
    create_date = db.Column(db.DateTime)
	
    def __init__(self, body, create_date=None):
        self.body = body
        if create_date is None:
            create_date = datetime.utcnow()
        self.create_date = create_date
		
    def __repr__(self):
        return '<Comment %r %r>' % self.title, self.pub_date

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    first_name = db.Column(db.String(80))
    last_name = db.Column(db.String(80))
    username = db.Column(db.String(25))
    password = db.Column(db.String(50))
    date_joined = db.Column(db.DateTime)
    date_last_logged_in = db.Column(db.DateTime)

    def __init__(self, first_name, last_name, username, password, date_joined=None, date_last_logged_in=None):
        self.first_name = first_name
        self.last_name = last_name
        self.username = username
        self.password = password
        if date_joined is None:
            date_joined = datetime.utcnow()
        if date_last_logged_in is None:
            date_last_logged_in = datetime.utcnow()
        self.date_joined = date_joined
        self.date_last_logged_in = date_last_logged_in
	
# models for which we want to create API endpoints
app.config['API_MODELS'] = { 'post': Post, 'comment': Comment, 'user': User }

# models for which we want to create CRUD-style URL endpoints,
# and pass the routing onto our AngularJS application
app.config['CRUD_URL_MODELS'] = { 'post': Post, 'comment': Comment, 'user': User }

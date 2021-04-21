# Django Project Name:
Blog Project

### Nice to have VSCode Extentions:
- Djaneiro - Django Snippets
- SQLite
- and may install DB Browser to your local.

## Create first project and app:

- Create a working directory, cd to new directory
- Create virtual environment as a best practice:
```py
python3 -m venv env
virtualenv env
```
- Activate scripts:
```bash
.\env\Scripts\activate
source env/bin/activate  # for MAC
```
- Install django:
```bash
pip install django
```
- See installed packages:
```sh
pip freeze
```
- Create requirement.txt same level with working directory, send your installed packages to this file, requirements file must be up to date:
```py
pip freeze > .\requirements.txt
```
- Create project:
```py
django-admin startproject clarusway
```
- Various files has been created!
- change the name of the project main directory as src to distinguish from subfolder with the same name!
```bash
mv .\clarusway\ src
```
- Lets create first application:
- Go to the same level with manage.py file:
```bash
cd .\src\
```
- Start app
```py
python manage.py startapp firstapp
```
- To use python decouple in this project, first install it:
```py
pip install python-decouple
```
- For more information: https://pypi.org/project/python-decouple/
- Import the config object on settings.py file:
```py
from decouple import config
```
- Create .env file. We will collect our variables in this file.
```py
SECRET_KEY = o5o9...
```
- Retrieve the configuration parameters in settings.py:
```py
SECRET_KEY = config('SECRET_KEY')
```
- Go to views.py in firstapp directory
- Create first view by adding:
```py
from django.http import HttpResponse

def index(request):
    return HttpResponse("<h1>Hello world, this is Rafe</h1>")
```
- Must adjust URL path, go to urls.py and add:
from django.urls import include

- Add urls.py file under firstapp directory
```py
from firstproject.firstproject.urls import urlpatterns
from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='index'),
]
```
- Go to urls.py and add:
```py
from django.urls import path, include
path("", include(firstapp.urls))
```
- Go to settings.py and add under INSTALLED_APPS:
```py
'firstapp.apps.FirstappConfig'
# 'fscohort'
```
- Run our project:
```py
python manage.py runserver
```
- Go to http://localhost:8000/home/ in your browser, and you should see the text “Hello, world.”, which you defined in the index view.

### Login Admin Site:
- We need to create db, apply some table to database. Go to manage.py level directory:
```py
python manage.py migrate
```
- In order to login, we need to create a user who can login to the admin site. Run the following command:
```py
python manage.py createsuperuser
```
- Enter your desired username, email adress, password twice.
- Go to http://127.0.0.1:8000/admin/ You should see the admin's login screen.
- After you login, you should see a few types of editable content: groups and users. They are provided by django.contrib.auth, the authentication framework shipped by Django.

### Managing GitHub
- Add a .gitignore file, not send the big files, add djangoenv/
- There are password hashers in django, the first one is the default:
```py
PASSWORD_HASHERS = [
    'django.contrib.auth.hashers.PBKDF2PasswordHasher',
    'django.contrib.auth.hashers.PBKDF2SHA1PasswordHasher',
    'django.contrib.auth.hashers.Argon2PasswordHasher',
    'django.contrib.auth.hashers.BCryptSHA256PasswordHasher',
]
```
- To use Argon2 as your default storage algorithm, do the following, see documents:
- Install the argon2-cffi library. This can be done by running:
```py
python -m pip install django[argon2]
```
- Which is equivalent to:
```py
python -m pip install argon2-cffi
```
- (along with any version requirement from Django’s setup.cfg)
- Modify PASSWORD_HASHERS to list Argon2PasswordHasher first.

## Creating Models
- Add models.py under fscohort app folder Student class:
```py
class Student(models.Model):
    first_name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=50)
    number = models.IntegerField()
```
- To execute model changes:
```py
python manage.py makemigrations
```
- To implement changes to db table:
```py
python manage.py migrate
```
```tx
Operations to perform:
  Apply all migrations: admin, auth, contenttypes, fscohort, sessions
Running migrations:
  Applying fscohort.0001_initial... OK
```
- To add our model to admin panel, go to admin.py under fscohort add:
```py
from .models import Student

admin.site.register(Student)
```
- Turn back to admin page and refresh, the Student table/model will be seen.
- Click Student and add some students here.
- To see Student name instea of "Student object" in admin page add to Student object:
```py
class Student(models.Model):
    first_name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=50)
    number = models.IntegerField()
    
    def __str__(self):
        return self.first_name
        # return str(self.first_name)
```
## Migrating models
- Runs all migrations in the project to the current state
- Can also run only migrations in a specific app to a specific number using:
```py
python3 manage.py migrate appname number
python3 manage.py migrate adoptions 1
```
- To see all migrations:
```py
python3 manage.py showmigrations
```
- The result will be:
```tx
admin
 [ ] 0001_initial
 [ ] 0002_logentry_remove_auto_add
 [ ] 0003_logentry_add_action_flag_choices
adoptions
 [ ] 0001_initial
auth
 [ ] 0001_initial
 [ ] 0002_alter_permission_name_max_length
 [ ] 0003_alter_user_email_max_length
 [ ] 0004_alter_user_username_opts
 [ ] 0005_alter_user_last_login_null
 [ ] 0006_require_contenttypes_0002
 [ ] 0007_alter_validators_add_error_messages
 [ ] 0008_alter_user_username_max_length
 [ ] 0009_alter_user_last_name_max_length
 [ ] 0010_alter_group_name_max_length
 [ ] 0011_update_proxy_permissions
 [ ] 0012_alter_user_first_name_max_length
contenttypes
 [ ] 0001_initial
 [ ] 0002_remove_content_type_name
sessions
 [ ] 0001_initial
```
 - Square brackets on the left with empty spaces indicates this migrations not been yet applied. To apply these changes:
 ```py
 python3 manage.py migrate
```
- To modify table, after modification, repeat commands:
```py
python manage.py makemigrations  # Initial creation of the migration file
python manage.py migrate
```
- To make query in python:
```py
python manage.py shell
```
- First of all, import the table:
```sh
from fscohort.models import Student
```
- Define a new variable and add a student:
```sh
s1 = Student(first_name="John", last_name="Black", number="155")
```
- We created a student object:
```tx
s1
<Student: Student object (None)>
```
- Save the student to the table:
```sh
s1.save()
```
- Directly create(save) a record same as above but in one line, no need save() anymore when using create:
```sh
s1 = Student.objects.create(first_name="John", last_name="Black", number="155")
s2 = Student(first_name="Julia", last_name="White", number="222")
s2.save()
```
- We added two object to the db!
- Search all the students:
```sh
all_s = Student.objects.all()
```
```tx
all_s
<QuerySet [<Student: Student object (1)>, <Student: Student object (2)>, <Student: Student object (3)>]>
```
- filter  # more than one result
```sh
s1 = Student.objects.filter(first_name="Sena")
```
- get  # only one result
```sh
s1 = Student.objects.get(first_name="Sena")
```
- Field lookups:
```tx
A lookup expression consists of three parts:

Fields part (e.g. Book.objects.filter(author__best_friends__first_name...);
Transforms part (may be omitted) (e.g. __lower__first3chars__reversed);
A lookup (e.g. __icontains) that, if omitted, defaults to __exact.

field__lookuptype=value
first_name__startswith="C"

filter()   # More than one value
exclude()  # Other values than entered
get()      # One value only, if there is multiple gives error

# common lookups:
startswith
endswith
contains
gte
lte
```
- An example query may be:
```sh
s4 = Student.objects.filter(first_name__startswith="R")
```

## The Django template language
- Variables: {{ variable }}
```html
My first name is {{ first_name }}. My last name is {{ last_name }}.
```
- With a context of {'first_name': 'John', 'last_name': 'Doe'}, this template renders to:
My first name is John. My last name is Doe.

### Tags: {% tag %}
```html
{% if %}
{% endif %}
```
- Most tags accept arguments:
```html
{% cycle 'odd' 'even' %}
```
- Some tags require beginning and ending tags:
```html
{% if user.is_authenticated %}
    Hello, {{ user.username }}
{% endif %}
```
### Filters transform the values of variables and tag arguments: {{ variable|filter }}
```html
{'django': 'the web framework for perfectionists with deadlines'}
```
- This template renders to: "The Web Framework For Perfectionists With Deadlines"

### Comments: 
  - Single line: {# this won't be rendered #}
  - Multi line: {% comment %}

### Views:
- Some experimentation about request object:
```py
def home_view(request):
    # print(request.GET)
    # print(request.user)
    # print(request.path)
    # print(request.method)
    # print(request.GET.get("q"))
    return HttpResponse("Hello, Jane")
```
- Modify the view.py file under fscohort:
```py
def home_view(request):
    # return HttpResponse("Hi from home page!")
    context = {
        'title': 'clarusway',
        'dict1': {'django': 'best framework'},
        'my_list': [2, 3, 4]
    }
    return render(request, "home.html", context)
```
- Here we added a dictionary, and point to a template named home.html. Need to create this file!
- Create templates/fscohort directory under fscohor, and put a home.html file under it:
```html
<h1>Hello, this is home page</h1>
    {{ title }} <br> <br>
    {{ dict_1 }} <br> <br>
    {% for i in my_list %}
    {{ i }} <br>
    {% endfor %}
    {{ my_list }}
```
- A different div example from PetClinic project:
```html
<div>
    {% for pet in pets %}

        <div>
            <a href="{% url 'pet_detail' pet.id %}">
            <h3>{{ pet.name | capfirst }}</h3>
            </a>
            <p>{{ pet.species }}</p>
            {% if pet.breed %}
            <p>Breed: {{ pet.breed }}</p>
            {% endif %}
            <p class="hidden">{{ pet.description }}</p>
        </div>

    {% endfor %}
</div>
```
- Adding form element is also possible:
```html
<form action="https://www.google.com/search" method="get">  <!--action creates a link, watch out for the search criteria-->
<form action="" method="get">
    <input type="text", name="q", placeholder="Title">
    <input type="submit" value="Search">
</form>
```
## Forms
- Create forms.py file under fscohort app.
- Like models, forms structure very similar:
```py
from django import forms

class StudentForm(forms.Form):
    first_name = forms.CharField(max_length=50)
    last_name = forms.CharField(max_length=50)
    number = forms.IntegerField()
```
- After created form, we want to display it, so modify the views.py:
```py
from .forms import StudentForm
form = StudentForm()  # This renders an empty form of Students, but need to use it into a dictionary.
     
context = {
    'title': 'clarusway',
    'dict1': {'django': 'best framework'},
    'my_list': [2, 3, 4, 5],
    'form': form,
}
return render(request, "fscohort/home.html", context)
```
- Lets use it on home.html:
```html
<form action="." method="get">
{{ form }}
</form>
```
- ModelForms are similar to the regular forms, first they must be created on forms.py:
```py
from .models import Student

class StudentForm(forms.ModelForm):
    class Meta:
        model = Student
        fields = ("first_name", "last_name")
        # fields = '__all__'
```
- Modifications on form fields and labeling also possible:
```py
class StudentForm(forms.ModelForm):
    
    first_name = forms.CharField(label="Your Name")
    
    class Meta:
        model = Student
        fields = '__all__'
```
- To override some fields:
```py
class StudentForm(forms.ModelForm):
    
    first_name = forms.CharField(label="Your Name")
    
    class Meta:
        model = Student
        # fields = ("first_name", "last_name")
        fields = '__all__'
    
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        
        self.fields['first_name'].label = "My Name"
```
- May recall info form the Student model, first add a new function to the views.
```py
from .models import Student

def student_list(request):
    students = Student.objects.all()
    
    context = {
        'students': students
    }

    return render(request, "fscohort/student_list.html", context)
```
- Need to create a template named student_list.html:
```html
{% extends 'fscohort/base.html' %}

{% block content %}

    <h1>Student List Page</h1>

    {{ students }}

{% endblock content %}
```
- May use template inheritence, for this reason create a base.html:
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>fscohort</title>
</head>
<body>
    
    {% block content %}
        
    {% endblock content %}
   
</body>
</html>
```
- This content can be used again and again for other pages:
```html
{% extends 'fscohort/base.html' %}

{% block content %}
    <h1>Hello, this is home page</h1>
{% endblock content %}
```
- {{ students }} in student_list will return a query set. Need to put this in a for loop to see content:
```html
<ul>
{% for student in students %}
    <li>{{ student }}</li>
{% endfor %}
</ul>
```
- A list of students can be seen:
```tx
Helen
Robert
Rafe
```
- Other specialties can be seen:
```html
<li>{{ student.number }}-{{ student }} {{ student.last_name }}</li>
```
- The result will be:
```tx
1-Helen Jedi
2-Robert Pearl
3-Rafe Stefano
```
- How to create a student in a template? First of all need to add a student add function under student list function:
```py
def student_add(request):
    # First need to show an empty form of Students
    form = StudentForm()
    context = {
       'form': form 
    }
    return render(request, "fscohort/student_add.html", context)
```
- Then modify urls.py and add new function:
```py
path('add/', student_add),
```
- Create student_add.html:
```html
{% extends 'fscohort/base.html' %}

{% block title %}
    add student
{% endblock title %}
    

{% block content %}

<h2>Add Student</h2>

<form action="" method="POST">

    {{ form }}
    <input type="submit" value="Add">

</form>

{% endblock content %}
```
- The result: form can be seen on the page!
- The form can be easily seen as paragraph mode:
```html
{{ form.as_p }}
```
- When using post method csrf token must be used. This is for transferring cookies.
```html
<form action="" method="POST">
    {% csrf_token %}
    {{ form.as_p }}
    <input type="submit" value="Add">

</form>
```
- For validation may add some codes:
```py
def student_add(request):
    # First need to show an empty form of Students
    form = StudentForm()
    if request.method == "POST":
        print(request.POST)
        form = StudentForm(request.POST)
        if form.is_valid():
            form.save()
    context = {
        'form': form
    }
    return render(request, "fscohort/student_add.html", context)
```
- After completing the form, customer must be redirected somewhere:
```py
from django.shortcuts import render, redirect

if form.is_valid():
    form.save()
    return redirect('list')  # This returns to the listing page.
```
- Display one of student detail:
- First modify the views.py:
```py
def student_detail(request, id):
    student = Student.objects.get(id=id)
    context = {
        'student': student
    }
    return render(request, "fscohort/student_detail.html", context)
```
```py
path('add/', student_add, name='add'),
path('<int:id>', student_detail, name='detail'),
```
- Create student detail page:
```html
{% extends 'fscohort/base.html' %}

{% block title %}
    student details
{% endblock title %}

{% block content %}

<h2>Student Detail</h2>

{{ student.number }} - {{ student.first_name }} - {{ student.last_name }} 

{% endblock content %}
```
- Need to add delete and update links on detail page:
- First create view:
```py
def student_delete(request, id):
    student = get_object_or_404(Student, id=id)
    if request.method == 'POST':
        student.delete()
        return redirect('list')
    return render(request, "fscohort/student_delete.html")
```
- Add urls.py the path:
```py
path('<int:id>/delete', student_delete, name='delete'),
```
- Add a delete button to the list page:
```html
<a href="{% url 'delete' student.id %}">
<button>Delete</button>
</a>
```
- Prepare the delete page:
```html
{% extends 'fscohort/base.html' %}

{% block title %}
    student delete
{% endblock title %}

{% block content %}

<h2>Student Delete</h2>

<form action="" method="POST">
    <p>Sure?</p>
    {% csrf_token %}
    <input type="submit" value="Yes">
    <a href="{% url 'list' %}">No</a>
</form>

{% endblock content %}
```
- On the home page, lets create a button to link to other pages, for example add student:
```html
<a href="{% url 'add' %}"><button>Add Student</button></a>
```
- Now finally, lets write update student page, first start with the view. It will be a combination of add and detail forms, first bring the info of the student form db and then able to modify and send it:
```py
def student_update(request, id):
    student = Student.objects.get(id=id)  # Select the student with id
    form = StudentForm(instance=student)  # Bring the student form, it will be filled with student
    if request.method == 'POST':
        form = StudentForm(request.POST, instance=student)
        if form.is_valid():
            form.save()
            return redirect('list')
    context = {
        'student': student,
        'form': form,
    }
    return render(request, 'fscohort/student_update.html', context)
```
- Add the url path, dont forget to import:
```py
path("<int:id>/update", student_update, name='update'),
```
- Time to create template of student_update.html:
```html
{% extends 'fscohort/base.html' %}

{% block title %}
    update student
{% endblock title %}
    

{% block content %}

<h2>Update Student</h2>

<form action="" method="POST">
    {% csrf_token %}
    {{ form.as_p }}
    <input type="submit" value="Update">
</form>

<a href="{% url 'list' %}"><button>Cancel</button></a>

{% endblock content %}
```
- Add student detail page an update button:
```html
<a href="{% url 'update' student.id%}"><button>Update</button></a>
```
- And, add a button to cancel and turn back to student list:
```html
<a href="{% url 'list' %}"><button>Cancel</button></a>
```

### Working with ImageField:
- Need to install:
```py
pip install pillow
```

### Using Crispy Forms
- For more info:
https://django-crispy-forms.readthedocs.io/en/latest/install.html
- Installation:
```py
pip install django-crispy-forms
pip freeze > .\requirements.txt
```
- Add installed apps:
```py
'crispy_forms',
```
- Add to settings.py to use bootstrap4:
```py
CRISPY_TEMPLATE_PACK = 'bootstrap4'
```
- You can use crispy forms with variables in your code after loading:
```html
{% load crispy_forms_tags %}
{{ form | crispy }}
```

### Using Widgets:
- For more information:
https://docs.djangoproject.com/en/3.1/ref/forms/widgets/


### Changing the DB:
- By default it's sqlite3, can be changed to another type, such as PostgreSQL 
- Install PostgreSQL:
```py
pip install psycopg2
```
- change the name of engine and db on settings file
- Petclinic: Rafe - 123456Rs
- Portfolio: rafe - 123

### Add bootstrap:
- Change title
- Remove header
- Change Top title
- Add short discription
- Modify action buttons, remove one, change other to mail button
- remove footer
- remove unnecessary divs

python manage.py collectstatic

- To turn back to the home page: {% url 'home'%}
<a href="{% url 'home'%}" class="btn btn-primary my-2">Back</a>

---------------------------------

## TDD with Selenium
- Create environment:
python3 -m venv env
.\env\Scripts\activate
pip install selenium
- Download firefox
- First test, opens localhost and test if there is a page!
```py
from django.test import TestCase
from selenium import webdriver

class FunctionalTestCase(TestCase):
    
    def setUp(self):
        self.browser = webdriver.Firefox()
    
    def test_there_is_homepage(self):
        self.browser.get('http://localhost:8000')
        self.assertIn('install', self.browser.page_source)
        # assert browser.page_source.find('install')
        
    
    def tearDown(self):
        self.browser.quit()
    ```

<h3><a href="{% url 'home' %}">Home</a></h3>


### Deployment Testing
- Run your functional and unit tests locally
- Deploy code to a staging server
- Have a custom domain for that
- Run functional tests against the staging site and unit tests agaings the staging server
- Automate the process or burnout

## Deploy project to cloud
### Digital ocean:
- Start with folder, without env, just the project folder!
- name project: DjangoPortfolio
- description: This project is for learning.
- What it's for: Just tryin out.
- Droplet is server, project is group of droplets.
- Create Droplet: ubuntu, smallest option, can be upgraded to a bigger one.
- Choose a hostname: portfolio-ubuntu.
- Create
- Check out email for the password, or organize key file.
- ssh to the server
- add user
```bash
adduser rafe
hostnamectl set-hostname djangoserver
bash
```
- add sudo privilages:
```bash
usermod -aG sudo rafe
```
- The installation guide can be reached:
https://www.digitalocean.com/community/tutorials/how-to-set-up-django-with-postgres-nginx-and-gunicorn-on-ubuntu-18-04
- ssh with the new user:
```bash
sudo apt update
sudo apt upgrade -y
sudo apt install python3-pip python3-dev libpq-dev postgresql postgresql-contrib nginx curl
sudo -u postgres psql
```
- You are inside postgre machine
```sql
CREATE DATABASE portfoliodb;
CREATE USER portfoliouser WITH PASSWORD 'django1234';
ALTER ROLE portfoliouser SET client_encoding TO 'utf8';
ALTER ROLE portfoliouser SET default_transaction_isolation TO 'read committed';
ALTER ROLE portfoliouser SET timezone TO 'UTC';
GRANT ALL PRIVILEGES ON DATABASE portfoliodb TO portfoliouser;
```
- Get back to the terminal, and connect to the postgresql with db we already created:
```bash
\q
sudo -u postgres psql -d portfoliodb
```
- You can make changes from here if you need. Now go back to the local.
- Turn back to local and send all the project folder to server, it takes some time:
```bash
scp -r .\portfolio-project\ rafe@139.59.159.111:/home/rafe
```
- In server cli modify permission for the folder:
```bash
chmod -R 755 portfolio-project
```
- Need to create virtual env inside our server:
```bash
sudo -H pip3 install virtualenv
virtualenv env
source env/bin/activate
pip install django gunicorn psycopg2-binary pillow
nano settings.py
```
SECRET_KEY = 'p7aqtmuu8)zg-)j)^$+*fo57&(o_&9hqg5v@$%b=!b^jcgxl3y'
- Make some changes on settings.py:
```py
ALLOWED_HOSTS = []
```
- Add your IP to the list
```py
ALLOWED_HOSTS = ['139.59.159.111']  ### add domains if you have
```
- Modify db section:
DATABASES; ENGINE; from 'django.db.backends.postgresql' to 'django.db.backends.postgresql'
           USER; from 'postgres' to 'portfoliouser'

           PASSWORD
MEDIA_ROOT to os.path.join(BASE_DIR, 'media')
- Remove images folder inside server:
```bash
rm -r images/
python manage.py migrate
python manage.py createsuperuser
python manage.py collectstatic
sudo ufw allow 8000
python manage.py runserver 0.0.0.0:8000
```
- Check the server: 139.59.159.111:8000
- Check inbound rules of server if cant connect.
- Check dbs: 139.59.159.111:8000/admin
- Add jobs have fun. 
- One problem, our website running on port 8000, need to make it port 80.
- Bind this project to gunicorn, instead of built in server:
```bash
gunicorn --bind 0.0.0.0:8000 portfolio.wsgi
```
- runserver is for development but gunicorn is for production!
- Reload the page again and check if gunicorn is running: 139.59.159.111:8000
- if needed:
```bash
sudo reboot
```
- Get out or gunicorn and deactivate the virtual env:
```bash
ctrl + C
deactivate
```
- Create a socket for gunicorn:
```bash
sudo nano /etc/systemd/system/gunicorn.socket
```
- Paste this script to the file:
```bash
[Unit]
Description=gunicorn socket

[Socket]
ListenStream=/run/gunicorn.sock

[Install]
WantedBy=sockets.target
```
- Create a service for gunicorn:
```bash
sudo nano /etc/systemd/system/gunicorn.service
```
```bash
[Unit]
Description=gunicorn daemon
After=network.target

[Service]
User=rafe
Group=www-data
WorkingDirectory=/home/rafe/portfolio-project
ExecStart=/home/rafe/env/bin/gunicorn --access-logfile - --workers 3 --bind unix:/home/rafe/portfolio-project/portfolio.sock portfolio.wsgi:application
[Install]
WantedBy=multi-user.target
```
- Change the red lines on the guide.
- Start gunicorn:
```bash
sudo systemctl start gunicorn
sudo systemctl enable gunicorn

sudo systemctl daemon-reload
sudo systemctl restart gunicorn

sudo systemctl status gunicorn
```

### Setup Nginx
- First turn off debug mode:
```bash
nano portfolio/settings.py
```
- Change; DEBUG = False
- Configure nginx to proxy pass to gunicorn:
```bash
sudo nano /etc/nginx/sites-available/protfolio
```
```bash
server {
    listen 80;
    server_name 165.22.180.158 farukgunal.net stefanorafe.com;  # If you have additional dns names can add here

    location = /favicon.ico { access_log off; log_not_found off; }
    location /static/ {
        root /home/rafe/portfolio-project;
    }

    location /media/ {
        root /home/rafe/portfolio-project;
    }


    location / {
        include /etc/nginx/proxy_params;
        proxy_pass http://unix:/home/rafe/portfolio-project/portfolio.sock;
    }
}
```
```bash
sudo ln -s /etc/nginx/sites-available/portfolio /etc/nginx/sites-enabled
sudo nginx -t
sudo systemctl restart nginx
sudo systemctl restart gunicorn
sudo ufw delete allow 8000
sudo ufw allow 'Nginx Full'
```
- Try to open website without 8000; 139.59.159.111
- The site must work without 8000
- You may get domain, create A record, and there will be good domain name.

### Deploy to AWS:
https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/create-deploy-python-django.html
- In your local:
pip3 install virtualenv

pip3 install awsebcli --upgrade --user
eb --version
- Add the executable path, %USERPROFILE%\AppData\roaming\Python\Python38\scripts, to your PATH environment variable. To avoid conflicts, continue with the virtual environment.

python3 -m venv eb-virt
.\eb-virt\Scripts\activate
pip install django pillow psycopg2
pip freeze > .\requirement.txt
mkdir .ebextensions
- create django.config file under .ebextensions:

option_settings:
    aws:elasticbeanstalk:container:python:
    WSGIPath: portfolio/wsgi.py

python .\manage.py collectstatic

deactivate

eb init -p python-3.8 portfolio-aws

Application portfolio-aws has been created. This is on AWS. 

- If it asks credentials: create new access key, and secret in IAM

eb create django-env
- The result:

Creating application version archive "app-8bfc-210302_153440".
Uploading: [##################################################] 100% Done...
Application portfolio-aws has been created.
Environment details for: django-env
  Application name: portfolio-aws
  Region: us-east-1
  Deployed Version: app-8bfc-210302_153440
  Environment ID: e-upebtrgugk
  Platform: arn:aws:elasticbeanstalk:us-east-1::platform/Python 3.8 running on 64bit Amazon Linux 2/3.2.0
  Tier: WebServer-Standard-1.0
  CNAME: UNKNOWN
  Updated: 2021-03-02 12:35:05.477000+00:00
Printing Status:
2021-03-02 12:35:04    INFO    createEnvironment is starting.
2021-03-02 12:35:05    INFO    Using elasticbeanstalk-us-east-1-894756847358 as Amazon S3 storage bucket for environment data.
2021-03-02 12:35:32    INFO    Created security group named: sg-06972f4f101c4727a
2021-03-02 12:35:47    INFO    Created load balancer named: awseb-e-u-AWSEBLoa-CHI238T1B977
2021-03-02 12:35:47    INFO    Created security group named: awseb-e-upebtrgugk-stack-AWSEBSecurityGroup-CL9K58Q0GO3U
2021-03-02 12:35:47    INFO    Created Auto Scaling launch configuration named: awseb-e-upebtrgugk-stack-AWSEBAutoScalingLaunchConfiguration-10L980HVZL794
2021-03-02 12:37:06    INFO    Created Auto Scaling group named: awseb-e-upebtrgugk-stack-AWSEBAutoScalingGroup-8CR0OWHJT5DL
2021-03-02 12:37:06    INFO    Waiting for EC2 instances to launch. This may take a few minutes.
2021-03-02 12:37:21    INFO    Created Auto Scaling group policy named: arn:aws:autoscaling:us-east-1:894756847358:scalingPolicy:959c4baf-c32a-4570-a3c1-f5d440f495ce:autoScalingGroupName/awseb-e-upebtrgugk-stack-AWSEBAutoScalingGroup-8CR0OWHJT5DL:policyName/awseb-e-upebtrgugk-stack-AWSEBAutoScalingScaleDownPolicy-8FSA362PFNQF
2021-03-02 12:37:21    INFO    Created Auto Scaling group policy named: arn:aws:autoscaling:us-east-1:894756847358:scalingPolicy:e63d66cf-2133-47bd-80aa-656538e7039e:autoScalingGroupName/awseb-e-upebtrgugk-stack-AWSEBAutoScalingGroup-8CR0OWHJT5DL:policyName/awseb-e-upebtrgugk-stack-AWSEBAutoScalingScaleUpPolicy-1ML0GLSO6631I
2021-03-02 12:37:21    INFO    Created CloudWatch alarm named: awseb-e-upebtrgugk-stack-AWSEBCloudwatchAlarmHigh-18EA4F6J25W3X
2021-03-02 12:37:21    INFO    Created CloudWatch alarm named: awseb-e-upebtrgugk-stack-AWSEBCloudwatchAlarmLow-150R8Q0O4QBC1
2021-03-02 12:37:26    INFO    Instance deployment successfully generated a 'Procfile'.
2021-03-02 12:37:28    INFO    Instance deployment completed successfully.
2021-03-02 12:38:35    INFO    Successfully launched environment: django-env

eb status

Environment details for: django-env
  Application name: portfolio-aws
  Region: us-east-1
  Deployed Version: app-8bfc-210302_153440
  Environment ID: e-upebtrgugk
  Platform: arn:aws:elasticbeanstalk:us-east-1::platform/Python 3.8 running on 64bit Amazon Linux 2/3.2.0
  Tier: WebServer-Standard-1.0
  CNAME: django-env.eba-sf8naanw.us-east-1.elasticbeanstalk.com
  Updated: 2021-03-02 12:38:35.822000+00:00
  Status: Ready
  Health: Red

- CNAME: django-env.eba-sf8naanw.us-east-1.elasticbeanstalk.com is the domain name our website is hosting. Add this to the settings file.
# ALLOWED_HOSTS = []
ALLOWED_HOSTS = ['django-env.eba-sf8naanw.us-east-1.elasticbeanstalk.com']

eb deploy

Creating application version archive "app-8bfc-210302_154642".
Uploading: [##################################################] 100% Done...
2021-03-02 12:47:04    INFO    Environment update is starting.      
2021-03-02 12:47:08    INFO    Deploying new version to instance(s).
2021-03-02 12:47:12    INFO    Instance deployment successfully generated a 'Procfile'.
2021-03-02 12:47:20    INFO    Instance deployment completed successfully.
2021-03-02 12:47:26    INFO    New application version was deployed to running EC2 instances.
2021-03-02 12:47:26    INFO    Environment update completed successfully.

eb console
- Go to configuration - database settings
- Select postgres
- Username: portfoliouser
- Password: django1234
- Apply!

- Go to portfolio\settings.py
- Change 
DEBUG=False
'NAME': os.environ['RDS_DB_NAME'],
'USER': 'NAME': os.environ['RDS_USERNAME'],
'PASSWORD': os.environ['RDS_PASSWORD'],
'HOST': os.environ['RDS_HOSTNAME'],
'PORT': os.environ['RDS_PORT'],

- You may need to run server locally, so create an if statement:

if 'RDS_DB_NAME' in os.environ:
    DATABASES = {
        'default': {
            'NAME': os.environ['RDS_DB_NAME'],
            'USER': 'NAME': os.environ['RDS_USERNAME'],
            'PASSWORD': os.environ['RDS_PASSWORD'],
            'HOST': os.environ['RDS_HOSTNAME'],
            'PORT': os.environ['RDS_PORT'],
        }
    }
else:
    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.sqlite3',
            'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
        }
    }

- To add a migrate step when your application is deployed:
Create a configuration file named db-migrate.config with the following content.
Example ~/ebdjango/.ebextensions/db-migrate.config:
container_commands:
  01_migrate:
    command: "django-admin.py migrate"
    leader_only: true
  02_createsuperuser:
    command: "echo \"from django.contrib.auth.models import User; User.objects.create_superuser('rafe', 'stefanorafe@gmail.com', 'django1234')\" | python manage.py shell"
    leader_only: true
option_settings:
  aws:elasticbeanstalk:application:environment:
    DJANGO_SETTINGS_MODULE: ebdjango.settings
- Deploy again:
eb deploy
eb open

- Boom! your website is ready!

### S3 can be used for files:
https://www.caktusgroup.com/blog/2014/11/10/Using-Amazon-S3-to-store-your-Django-sites-static-and-media-files/

- create a bucket
- make public
- create new group
- attach policy
- add user: programmatic access

- Turn back to local
- activate virtual environment
.\eb-env\Scripts\activate
pip install django-storages boto3
pip freeze > requirements.txt

- change portfolio\settings.py
add a new installed app:
'storages'

after installed apps, add:
AWS_STORAGE_BUCKET_NAME = 'BUCKET_NAME'
AWS_S3_REGION_NAME = 'REGION_NAME'  # e.g. us-east-2
AWS_ACCESS_KEY_ID = 'xxxxxxxxxxxxxxxxxxxx'
AWS_SECRET_ACCESS_KEY = 'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy'

modify bucket name get from S3
change region
fill keys

# Tell django-storages the domain to use to refer to static files.
AWS_S3_CUSTOM_DOMAIN = '%s.s3.amazonaws.com' % AWS_STORAGE_BUCKET_NAME

AWS_DEFAULT_ACL = None


# Tell the staticfiles app to use S3Boto3 storage when writing the collected static files (when
# you run `collectstatic`).

STATICFILES_LOCATION = 'static'
STATICFILES_STORAGE = 'storages.backends.s3boto3.S3Boto3Storage'


repeat for media:

MEDIAFILES_LOCATION = 'media'
DEFAULT_FILE_STORAGE = 'custom_storages.MediaStorage'

- Create new file named custom_storages.py

# custom_storages.py
from django.conf import settings
from storages.backends.s3boto3 import S3Boto3Storage

class StaticStorage(S3Boto3Storage):
    location = settings.STATICFILES_LOCATION

class MediaStorage(S3Boto3Storage):
    location = settings.MEDIAFILES_LOCATION

python manage.py collectstatic

- Static files going to the S3 bucket

eb deploy
eb open

## Route53 deployment:
- DNS management
- create hosted zone
- create domain name
- create record set A type alias elastic beanstalk choosen
- www for again create an A record

-------------------------------------------------------------------
### HEROKU Deployment
- sign up
- install cli
heroku login
new virtual env
activate
cd portfolio
intall django pillow psycopg2 gunicorn
freeze requirement
deactivate

git init
git add -A
git commit -m "first commit"
heroku create
git push heroku master
edit settings
debug false
allowed hosts paste infinite-earth heroku app

Procfile create
release: python manage.py migrate
web: gunicorn portfolio.wsgi

runtime.txt create
python-3-7-1

git add -A
git commit 
git push heroku master
heroku ps:scale web=1
heroku open

setup db
go to heroku dashboard
configure add ons
heroku postgres
settings
view credentials
grab info to settings file
database to db name on settings file
user to db user 
password
host

git add
git commit
git push heroku master
heroku open

edit admin
heroku run python manage.py createsuperuser

activate venv
pip install django storage
pip freeze
go to S3
create bucket make public

update settings.py
copy aws part
paste

add installed app storage

custom_storages.py modify

git add
git commit
git push heroku master
heroku open

heroku domains

----------------------------------------------------------------------
### Azure Deployment
- create account
- create virtual machine
- ssh
sudo apt update
same guide with digitalocean
install packages
postgesql
create db, user, password, alter role, grant privilages, quit
scp files to server
see folder on server
chmod 755
install venv
create venv
activate venv
install django gunicorn psycopg2-binary pillow
update settings file:
allowed hosts add server ip
change db configurations engine, name, user, password
change media root 
rm images
migrate
createsuperuser
collectstatic
ufw allow 8000

azure portal networking inbound port add change 8080 to 8000

runserver 0.0.0.0:8000

test site ip:8000
add job

gunicorn --bind 0.0.0.0:8000 portfolio.wsgi
deactivate
create a socket for gunicorn
gunicorn.socket
gunicorn.service

start gunicorn
enable gunicorn

daemon-reload
restart gunicorn

settings file modify for production
debug false

nginx adjustment
/etc/nginx/sites-available/portfolio
copy static and paste for media

sudo ln -s the file
sudo nginx -t
restart gunicorn
restart nginx

ufw delete allow 8000
ufw allow 'Nginx Full'

on azure delete 8000
change 8080 to 80

restart gunicorn
restart nginx

change the domain, google domains can be used
create resource A record
compy ip
www to ip

for every upload code restart
--------------------------------------------------------------------

find /var/www/wisdompetmed.local/ -type f -exec chmod 644 {} \;  # this command will find all files in this dir and apply chmod 644 to them

------
## Deploy to Ubuntu
```bash
# Change server name
hostnamectl set-hostname djangoserver
bash
# sudo ufw default deny incoming
nano /etc/hosts
161.35.127.222 djangoserver
# Add a new user, best practice to work with a user other than root
adduser rafe
# add sudo privilages:
usermod -aG sudo rafe
# ssh with the new user:
sudo apt update
sudo apt upgrade -y
# create a key file on your local and send it to the server so the connection will be much more secure
mkdir -p ~/.ssh
# turn back to local
ssh-keygen -b 4096
scp /c/Users/rafe_stefano/.ssh/id_rsa.pub rafe@161.35.127.222:~/.ssh/authorized_keys
# turn back to server
sudo chmod 700 ~/.ssh/
sudo chmod 600 ~/.ssh/*
# disallow root login, disallow password login, so that only ssh key login will be allowed
sudo nano /etc/ssh/sshd_config
PermitRootLogin no
PasswordAuthentication no  # uncomment first
# change some firewall rules
sudo systemctl restart sshd
sudo apt-get install ufw
sudo ufw default allow outgoing
sudo ufw default deny incoming
sudo ufw allow ssh
sudo ufw allow 8000
sudo ufw enable
sudo ufw status
# clone from github
# check git version
git --version
git clone https://github.com/bluehackrafestefano/NewSchoolProject-Django.git
cd project-folder
ls -lash
# see the project folder
# install python and virtual environment tools
sudo apt-get install python3-pip -y
sudo apt-get install python3-venv -y
# change permission of the folder
chmod -R 755 NewSchoolProject-Django/
# create virtual environment named env inside project folder
python3 -m venv env
# activate virtual environment
source env/bin/activate
# install the requirements file 
pip install -r requirements.txt
# modify settings.py file, first go to the folder
nano settings.py
# add server ip to allowed host
ALLOWED_HOSTS = ['161.35.127.222']
STATIC_ROOT = os.path.join(BASE_DIR, 'static')
import os
# Replace BASE_DIR = Path(__file__).resolve(strict=True).parent.parent with:
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
# collect static files
python manage.py collectstatic
# 247 static files copied to '/home/rafe/NewSchoolProject-Django/src/static'
# go to live
python manage.py runserver 0.0.0.0:8000
# Check the server: <serverIP>:8000
# Install Apache, and mod_wsgi
# https://docs.djangoproject.com/en/3.1/howto/deployment/wsgi/modwsgi/
sudo apt-get install apache2 -y
sudo apt-get install libapache2-mod-wsgi-py3
cd /etc/apache2/sites-available/ && ls
# 000-default.conf  default-ssl.conf
# Use one of them as a starting point
sudo cp 000-default.conf django-project.conf
sudo nano django-project.conf
# Add some config at the end
Alias /static /home/rafe/NewSchoolProject-Django/src/static
<Directory /home/rafe/NewSchoolProject-Django/src/static>
    Require all granted
</Directory>

Alias /media /home/rafe/NewSchoolProject-Django/src/media
<Directory /home/rafe/NewSchoolProject-Django/src/media>
    Require all granted
</Directory>

# one step further which is same level of wsgi file
<Directory /home/rafe/NewSchoolProject-Django/src/eduweb>
    <Files wsgi.py>
        Require all granted
    </Files>
</Directory>

WSGIScriptAlias / /home/rafe/NewSchoolProject-Django/src/eduweb/wsgi.py
WSGIDaemonProcess django_app python-path=/home/rafe/NewSchoolProject-Django/src python-home=/home/rafe/NewSchoolProject-Django/env
WSGIProcessGroup django_app 
# serve the site
sudo a2ensite django-project
# project name is the same as config file
sudo a2dissite 000-default.conf
# need permission updates
sudo chown :www-data ./NewSchoolProject-Django/src/db.sqlite3
sudo chmod 644 ./NewSchoolProject-Django/src/db.sqlite3
sudo chown :www-data ./NewSchoolProject-Django/src/
sudo chown -R :www-data ./NewSchoolProject-Django/src/media
sudo chmod -R 775 ./NewSchoolProject-Django/src/media
# lets secure sensitive information
sudo touch /etc/config.json
# set DEBUG = False
sudo nano settings.py
DEBUG = False
# disallow port 8000
sudo ufw delete allow 8000
# allow http traffic
sudo ufw allow http/tcp
# restart server
sudo service apache2 restart
# check IP and see the website
# Configure a test server with debug = True
sudo chmod 775 src/
shutdown -r now
# adding ssl with lets encrypt
https://letsencrypt.org/
sudo apt install snapd
sudo snap install core; sudo snap refresh core
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
# modify configuration file
sudo nano /etc/apache2/sites-available/django-project.conf
sudo certbot --apache
sudo certbot renew --dry-run

### Additional notes:
- For Nandias Garden project:
pip install django-widget-tweaks
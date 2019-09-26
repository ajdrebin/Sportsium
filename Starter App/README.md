# Starter App

*A journey of a thousand miles begins with a single step.*

This application is that single step. This repository consists of two entities. An IOS application emulating Twitter and a local back end server running a PostgreSQL database. Both are meant to be run locally on a macOS. 


## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 

### Prerequisites

#### Backend Server
The simplest way to install Django is by first installing pip. In order to install pip, one needs to have python installed.

In order to check whether python is installed, enter the following code into the command line.

```
python --version
```

If a python version shows up then python is installed. If it is not installed, then please install python on your machine. 

We next need to download pip and install it using python. Run the following code in the command line.

```
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
```

Once pip is installed, we can then download and install Django using the following code in the command line.

```
pip install Django
```

We now need to download postgreSQL. We first need to install Homebrew for mac.

In the command line terminal, run /usr/bin/ruby -e 
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Once that is installed, run the following command to install psql. Note if psql is already installed, then skip ahead
```
brew install postgresql
```

Then follow the steps provided here for a first time user.
- https://gist.github.com/ibraheem4/ce5ccd3e4d7a65589ce84f2a3b7c23a3


#### IOS application

Use a macOS to install Xcode from the Mac App Store. 

Install the command line developer tools for Xcode by running the following code on the command line terminal. 

```
xcode-select --install
```

### Build and Run

#### Backend

We must begin by creating the databases for our application.
We hence run the following code in the command line to grant privileges to the user django.
```
sudo -u postgres psql
CREATE ROLE django WITH LOGIN PASSWORD 'password';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO django;
GRANT ALL PRIVILEGES ON DATABASE django_db TO django;
ALTER ROLE django CREATEDB;
\q
```

We now log into django and create some tables
```
psql postgres -U django
CREATE DATABASE django_db;
\connect django_db;
CREATE TABLE users (username varchar(255), name varchar(255), email varchar(255)); CREATE TABLE chatts (username varchar(255), message varchar(255), time timestamp DEFAULT CURRENT_TIMESTAMP);
INSERT INTO chatts values('testuser1', 'Hello world'); SELECT * from chatts;

```

We can now navigate to the "Starter\ App/mysite/" folder. This will contain the following items.
* chatter  
* db.sqlite3  
* manage.py  
* mysite

We now run the following line of code to get our server running
```
python manage.py runserver localhost:9000
```

Once successful, our backend server is up and ready for debugging. 

In the next section we will go over how to run the ios application


#### IOS application

Navigate to "Starter\ App/ios-project-sample-f17-master/". This folder consists of 3 items.
* Chatter
* Chatter.xcodeproj
* DerivedData

We next run the following code to begin to build the application.
```
xcodebuild -scheme Chatter build
```

When finished, open Xcode and run the Xcode simulator by pressing the play button on the top left. This will run a simulation of a specified IOS using the configurations of the project. 
 
Let the debugging begin!

## Folder Structure
```
    .
    ├── ios-project-sample-f17-master
    │   ├── Chatter.xcodeproj
    │   ├── Chatter
    │   │   ├── Assets.xcassets/AppIcon.appiconset
    │   │   │   ├── Contents.json
    │   │   ├── Base.lproj
    │   │   │   ├── LaunchScreen.storyboard
    │   │   │   ├── Main.storyboard
    │   │   ├── AppDelegate.swift
    │   │   ├── Chatt.swift
    │   │   ├── ChattTableCell.swift
    │   │   ├── info.plist
    │   │   ├── ViewController.swift
    │   ├── Derived Data
    │   │   ├── Chatter
    |   │   │   ├── Build
    |   │   │   ├── Index
    |   │   │   ├── Logs 
    |   │   │   ├── TextIndex
    |   │   │   ├── OpenQuickly-ReferencedFrameworks.index-v1
    |   │   │   ├── info.plist
    |   │   │   ├── scm.plist
    │   │   ├── ModuleCache
    |   │   │   ├── 174W5FVGBZHJM
    |   │   │   ├── N9IL6CP46OIG
    |   │   │   ├── APINotes.timestamp
    |   │   │   ├── CoreGraphics-29MFLTMZYAR07.apinotesc
    |   │   │   ├── CoreImage-33QR13KUZQWP8.apinotesc
    |   │   │   ├── CoreText-2LVPZZDMD8ITG.apinotesc
    |   │   │   ├── Darwin-3SHCHLH7INYEM.apinotesc
    |   │   │   ├── Foundation-SHQ8VQKKGUZA.apinotesc
    |   │   │   ├── Metal-2EHSCECJ675OC.apinotesc
    |   │   │   ├── ObjectiveC-316I8REX3VNBQ.apinotesc
    |   │   │   ├── OpenGLES-3H4M6CQGPF3TS.apinotesc
    |   │   │   ├── QuartzCore-8C7BHA6CIDSP.apinotesc
    |   │   │   ├── Session.modulevalidation
    |   │   │   ├── UIKit-Q44AMGXP91XM.apinotesc
    |   │   │   ├── modules.timestamp
    ├── mysite
    │   ├── chatter
    │   │   ├── __pycache__
    |   │   │   ├── __init__.cpython-36.pyc
    |   │   │   ├── urls.cpython-36.pyc
    |   │   │   ├── views.cpython-36.pyc
    │   │   ├── migrations
    |   │   │   ├── __init__.py
    │   │   ├── __init.py__
    │   │   ├── admin.py
    │   │   ├── apps.py
    │   │   ├── models.py
    │   │   ├── tests.py
    │   │   ├── urls.py
    │   │   ├── views.py
    │   ├── mysite
    │   │   ├── __pycache__
    |   │   │   ├── __init__.cpython-36.pyc
    |   │   │   ├── settings.cpython-36.pyc
    |   │   │   ├── urls.cpython-36.pyc
    |   │   │   ├── wsgi.cpython-36.pyc
    │   │   ├── __init__.py
    │   │   ├── settings.py
    │   │   ├── urls.py
    │   │   ├── wsgi.py
    │   ├── .DS_Store
    │   ├── db.sqlite3
    │   ├── manage.py
    '
```

## Built With

* [Django](https://docs.djangoproject.com/en/2.2/) - The web framework used

* [PostgreSQL](https://www.postgresql.org/docs/) - An open-source relational database management system 

* [Xcode](https://developer.apple.com/library/archive/documentation/ToolsLanguages/Conceptual/Xcode_Overview/LearningfromDetailedUserGuides.html) - Integrated Development Environment for macOS


## Authors
Sportsium Development Team

* Alfonzo Acosta,         aaram
* Chia Chen,              chiahche
* Jessica Cheng,          jesca
* Alina Drebin,           ajdrebin
* Claire Drebin,          cdrebin
* Mashfy Rahman,          rmashfy
* Gustavo Ramirez,        grami


# NWSL_app

Get to know the faces of the National Women’s Soccer League using computer vision and motion tracking for real-time player identification with access to bios, stats and more.

## NOTE ON CONTRIBUTIONS
* Jessica (jesscheng) had email issues so not all of her commits count as contributions. Please see commit log for her work. 
* Alina (ajdrebin, adrebin) shows up as two contributors due to using two different accounts as a consequence of updating readmes online versus pushing code. Consider them the same person for all intents and purposes. (She will be using @adrebin to push code)



## File Structure
* **Backend Tests:** Test scripts and ios apps to play around with OpenCV and other frameworks for computer vision and machine learning *(see Backend Tests/README.md for more details)*
* **Sportsium_Skeleton/Sportsium_Skeleton:** UI development apps to work on front-end UI/UX and backend Computer Vision algorithm- includes all storyboards and swift files **(*IN USE for MVP app*)**
* * Our Computer Vision work is in the file Sportsium_Skeleton/Sportsium_Skeleton/Sportsium_Skeleton/IdentifyViewController.swift
* **Starter App:** Starter app assignment
* **django_project:** copy of backend server for database
  * *nwsl_app:* API specific to NWSL version of app - includes population of database
  * *django_project:* configuration of backend server
* **img:** directory of images to be used in app

## Folder Structure
```
    .
    ├── Backend Tests
    │   ├── CV Test
    │   ├── FaceTracker
    |   |── Overlay_test
    │   ├── opencv-swift-examples-master
    |   |──RGB_Colors.txt
    │   ├── README.md
    ├── Sportsium_Skeleton
    |   |── Sportsium_Skeleton
    |   │   ├── DerviedData
    |   │   ├── Sportsium_Skeleton.xcodeproj
    |   │   ├── Sportsium_Skeleton
    |   │   │   ├── Assets.xcassets
    |   │   │   ├── Base.lproj
    |   │   │   ├── opencv2.framework
    │   │   │   ├── AppDelegate.swift
    │   │   │   ├── Camera.storyboard
    │   │   │   ├── CameraViewController.swift
    │   │   │   ├── CheckIn.storyboard
    │   │   │   ├── CheckIn.swift
    │   │   │   ├── CVVideoCameraWrapper.h
    │   │   │   ├── CVVideoCameraWrapper.mm
    │   │   │   ├── GameInfo.storyboard
    │   │   │   ├── GameInfoViewController.swift
    │   │   │   ├── Home.storyboard
    │   │   │   ├── HomeViewController.swift
    │   │   │   ├── Identify.storyboard
    │   │   │   ├── IdentifyViewController.swift
    │   │   │   ├── Info.plist
    │   │   │   ├── ListTeams.storyboard
    │   │   │   ├── ListTeamsViewController.swift
    │   │   │   ├── Player.swift
    │   │   │   ├── PlayerInfo.storyboard
    │   │   │   ├── PlayerInfoViewController.swift
    │   │   │   ├── Rules.storyboard
    │   │   │   ├── RulesViewController.swift
    │   │   │   ├── SceneDelegate.swift
    │   │   │   ├── soccer.png
    │   │   │   ├── Sportsium_Skeleton-Bridging-Header.h
    │   │   │   ├── Team.swift
    │   │   │   ├── TeamInfo.storyboard
    │   │   │   ├── TeamInfo.swift
    │   │   │   ├── TeamInfoViewController.swift
    │   │   │   ├── ViewController.swift
    ├── Starter App
    │   ├── ios-project-sample-f17-master
    │   ├── mysite
    │   ├── README.md
    ├── django_project
    │   ├── django_project
    │   │   ├── __init__.py
    │   │   ├── settings.py
    │   │   ├── settings.py.orig
    │   │   ├── urls.py
    │   │   ├── wsgi.py
    │   ├── nwsl_app
    │   │   ├── migrations
    │   │   ├── __init__.py
    │   │   ├── admin.py
    │   │   ├── adv_populate.py
    │   │   ├── apps.py
    │   │   ├── models.py
    │   │   ├── populate.py
    │   │   ├── tests.py
    │   │   ├── urls.py
    │   │   ├── views.py
    │   ├── manage.py
    ├── img
    ├── .gitignore
    ├── README.md
    ├── simple_sftp_file.json
```

## Digital Ocean Droplet

### LOGIN
* Droplet Name: django-sportsium
* IP Address: 159.89.139.18
* Username: root
* Password: [Contact sportsium@umich.edu for password]

So type this in the terminal
```
ssh root@159.89.139.18
```

Then you are prompted with a password. Note: The password will not be visible
```
[Enter password]
```
and you are in!

### Deployment 
The following is link is the DigitalOcean droplet that we used: 
https://cloud.digitalocean.com/marketplace/5ba19751c472e4189b34e03e?i=2c9b94

Once logged into the DigitalOcean droplet, configure the postgres user 'django'.
To do this, follow the following steps: 
```
sudo -u postgres psql (use PSQL as user postgres)
\connect django (connect to the database) 
ALTER USER django WITH PASSWORD '48b07bd6b3afee61be52cf5cf0c1b0e3'
\dt (list tables) 
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO django;
\q or Control+D to exit
```

Once this is completed, navigate to '/home/django'. Here you will see a folder named 'django_project'. Delete this folder and replace it with the 'django_project' folder that is provided in this git repo. 

### Development
The following actions should take place in the django_project folder since we will be using mange.py as our CLI.
```
├── django_project
    ├── django_project (folder)
    ├── nwsl_app (folder)
    ├── manage.py
```

#### Changing the Database Schema
Any changes done to the database schema should be made in django_project/nwsl_app/models.py

Then run the following to apply the changes
```
python manage.py makemigrations
python manage.py migrate
```

#### Changing the API
Any changes to the API are done in django_project/nwsl_app/views.py

Apply these changes by running 
```
service gunicorn restart
```

#### Populating the Database
To populate the database, one must run Django's python shell and then import our populate.py script

```
python manage.py shell
```
This will trigger an interactive python shell. Type in the following to be able to call 

```
>>> from nwsl_app.adv_populate import delete_all, populate, populate1
>>> (call delete_all() or populate() or populate1() depending on need)
# populate() is for NWSL data while populate1() is for WNBA data
# populate and populate1 should each be called only once
# Make sure to call delete_all() before trying to populate a second time
```

## Getting Started with our IOS application

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Installing

First clone the root directory by clicking on the "Clone" button and copying the https link

```
git clone https://github.com/ajdrebin/Sportsium.git
```

### Building

Make sure your xcode version is at least version 11 or above 

Navigate to the /Sportsium/Sportsium_Skeleton/Sportsium_Skeleton.xcodeproj and open it. 

Once in the xcode environment, choose the simulated device to be an iPhone 11 Pro or an iPhone X. After this just click the play button to build and run. 


## Deployment

The ios app will be uploaded to ios store in December 2019. 

## Built With
* [Xcode](https://apps.apple.com/us/app/xcode/id497799835?mt=12) - IOS Development tool
* [Digital Ocean](https://www.digitalocean.com/) - Cloud computing company
* [Django](https://docs.djangoproject.com/en/1.11/) - The web framework used
* [PostgreSQL](https://www.postgresql.org/docs/) - Free and open-source relational database management system 

## Authors
Sportsium Development Team

* Alfonzo Acosta,         aaram@umich.edu
* Chia Chen,              chiahche@umich.edu
* Jessica Cheng,          jesca@umich.edu
* Alina Drebin,           ajdrebin@umich.edu
* Claire Drebin,          cdrebin@umich.edu
* Mashfy Rahman,          rmashfy@umich.edu
* Gustavo Ramirez,        grami@umich.edu

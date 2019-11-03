# NWSL_app

Get to know the faces of the National Women’s Soccer League using computer vision and motion tracking for real-time player identification with access to bios, stats and more.

## NOTE ON CONTRIBUTIONS
* Jessica (jesscheng) had email issues so not all of her commits count as contributions. Please see commit log for her work. 
* Alina (ajdrebin, adrebin) shows up as two contributors due to using two different accounts as a consequence of updating readmes online versus pushing code. Consider them the same person for all intents and purposes. (She will be using @adrebin to push code)


## File Structure
<<<<<<< HEAD
* **Backend Tests:** test scripts and apps to play around with OpenCV and other frameworks for computer vision and machine learning
* **Sportsium:** UI development apps to work on front-end UI/UX *(not in use for skeletal app)*
* **Sportsium_Skeleton/Sportsium_Skeleton:** UI development apps to work on front-end UI/UX - includes all storyboards and swift files **(*IN USE for skeletal app*)**
* **Starter App:** starter app assignment
* **django_project:** backend server for database
  * *nwsl_app:* API specific to NWSL version of app - includes population of database
  * *django_project:* configuration of backend server
* **img:** directory of images to be used in app

## Folder Structure
```
    .
    ├── Backend Tests
    │   ├── CV Test
    │   ├── ML Test
    │   ├── opencv-swift-examples-master
    │   ├── README.md
    ├── Sportsium 
    │   ├── DerivedData
    │   ├── Sportsium.xcodeproj
    │   ├── Sportsium
    │   ├── SportsiumTests
    │   ├── SporotsiumUITests
    │   ├── CheckIn.storyboard
    ├── Sportsium_Skeleton/Sportsium_Skeleton
    │   ├── DerviedData
    │   ├── Sporstium_Skeleton.xcodeproj
    │   ├── Sportsium_Skeleton
    │   │   ├── Assets.xcassets
    │   │   ├── Base.lproj
    │   │   ├── opencv2.framework
    │   │   ├── AppDelegate.swift
    │   │   ├── Camera.storyboard
    │   │   ├── CameraViewController.swift
    │   │   ├── CheckIn.storyboard
    │   │   ├── CheckIn.swift
    │   │   ├── CVVideoCameraWrapper.h
    │   │   ├── CVVideoCameraWrapper.mm
    │   │   ├── GameInfo.storyboard
    │   │   ├── GameInfoViewController.swift
    │   │   ├── info.plist
    │   │   ├── ListTeams.storyboard
    │   │   ├── ListTeamsViewController.swift
    │   │   ├── PlayerInfo.storyboard
    │   │   ├── PlayerInfoViewController.swift
    │   │   ├── SceneDelegate.swift
    │   │   ├── Sportsium_Skeleton-Bridging-Header.h
    │   │   ├── TeamInfo.storyboard
    │   │   ├── TeamInfoViewController.swift
    │   │   ├── ViewController.swift
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
=======
* Backend Tests: test scripts and apps to play around with OpenCV and other frameworks for computer vision and machine learning
* django_project: backend server for database
  * nwsl_app: API specific to NWSL version of app
* img: directory of images to be used in app
* Sportsium: UI development apps to work on front-end UI/UX
* Sportsium_Skeletal: Skeletal App for code demo
* Starter App: starter app assignment
>>>>>>> a00e1d6d6dc83fe0dd0d877a3ee7220c692c3062

## LOG INTO Digital Ocean droplet
* Droplet Name: django-sportsium
* IP Address: 159.89.234.82
* Username: root
* Password: MasYNoSport0

So type this in the terminal
```
ssh root@159.89.234.82
```

Then you are prompted with a password
```
[Enter password]
```
and you are in!





## TODO LIST 
* Complete IOS development - CV part
* Need to implement scrubber to populate the databases
* IOS frontend development




## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Installing

First clone the root directory by clicking on the "Clone" button and copying the https link

```
git clone https://github.com/ajdrebin/Sportsium.git
```

### Building

Make sure your xcode version is at least version 11 or above 

Navigate to the /Sporotsium/Sportsium_Skeleton/Sportsium_Skeleton.xcodeproj and open it. 

Once in the xcode environment, choose the simulated device to be an iPhone 11 Pro or an iPhone X. After this just click the play button to build and run. 


## Deployment

The backend web server is fully functioning at 159.89.234.82. Server will be uploaded to ios store in December 2019. 

## Built With

* [Digital Ocean](https://www.digitalocean.com/) - Cloud computing company
* [Django](https://docs.djangoproject.com/en/1.11/) - The web framework used
* [PostgreSQL](https://www.postgresql.org/docs/) - Free and open-source relational database management system 

## Authors
Sportsium Development Team

* Alfonzo Acosta,         aaram
* Chia Chen,              chiahche
* Jessica Cheng,          jesca
* Alina Drebin,           ajdrebin
* Claire Drebin,          cdrebin
* Mashfy Rahman,          rmashfy
* Gustavo Ramirez,        grami

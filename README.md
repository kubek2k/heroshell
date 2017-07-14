# HeroShell

Heroku shell that allows you to work in context of given heroku application

## Installation
 * Make sure you have [heroku cli](https://devcenter.heroku.com/articles/heroku-cli#download-and-install) installed
 * Invoke `gem install heroshell`

## Usage

Simply choose application to invoke command in context with and you are ready to go:
```
$ heroshell plan3-sample-app1
(plan3-sample-app1)> config
=== plan3-sample-app1 Config Vars
NEWSROOMS_NO: ap,bt,vg

(plan3-sample-app1)> releases
=== plan3-sample-app1 Releases - Current: v8
v3  Set NEWSROOMS_NO config vars   jakub.janczak@schibsted.com   2017/07/03 15:22:29 +0200
v2  Enable Logplex                 jakub.janczak@schibsted.com   2017/07/03 14:16:27 +0200
v1  Initial release                plan3-labs@herokumanager.com  2017/07/03 14:16:27 +0200

...
```

to switch to other application, use `switch` command:
```
(plan3-sample-app1)> switch plan3-sample-app2
(plan3-sample-app2)> 
```

## How it works?
 * Its a wrapper on heroku CLI - simple as that
 * Autocompletion of commands is done by shamlessly parsing `heroku help` command

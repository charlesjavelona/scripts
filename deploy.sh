#!/bin/bash

clear

echo "Hi, $USER!"

echo "This script will take you to deploying a test app in heroku, this script assumes that you have created your test repo, sit back and enjoy the automation"
echo 
echo "-----------------------------------------------------------------------"
echo "-----------------------INITIALIZING TEST SERVER------------------------"
echo "-----------------------------------------------------------------------"
echo 

echo "What is the name of the test server?"
read urlName

heroku create $urlName --stack cedar --region us --buildpack https://github.com/AdmitHub/meteor-buildpack-horse.git

heroku git:remote -a $urlName
heroku config:set ROOT_URL=http://$urlName.herokuapp.com
heroku config:set NODE_MODULES_CACHE=false
heroku config:set BUILDPACK_CLEAR_CACHE=1
heroku addons:create mongolab


echo 
echo "***NOTE: Before committing, JS minifiers must be switched for short-term fix"
echo "***Please see https://forums.meteor.com/t/deployment-to-galaxy-fails-because-of-js-standard-minifiers/31005"

echo
echo "Removing JS minifier"
meteor remove standard-minifier-js
echo
echo "Replacing with abernix:standard-minifier-js@1.2.2"
meteor add abernix:standard-minifier-js@1.2.2
echo 

git add .
echo "What is the commit description?"
git commit -am "Testing"
echo "Pushing to heroku for testing"
git push heroku master

echo "Opening app now online"
heroku open



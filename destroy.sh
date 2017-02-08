#!/bin/bash

clear

echo "Hi, $USER!"
echo

echo "This script will take you to all the test app in heroku, this script assumes that you have created your test repo, sit back and enjoy the automation"
echo 
echo "-----------------------------------------------------------------------"
echo "-----------------------DELETING TEST SERVER----------------------------"
echo "-----------------------------------------------------------------------"
echo 

heroku apps
echo
echo "What is the name of the app?"
read appName

heroku apps:destroy --app $appName 
echo "Destroyed.."
echo "Done!"

echo
echo "Removing Quick fix JS minifier"
meteor remove abernix:standard-minifier
echo
echo "Replacing with standard-minifier-js"
meteor add standard-minifier-js


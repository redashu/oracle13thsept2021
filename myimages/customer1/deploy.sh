#!/bin/bash

if  [  "$customer1" ==  "app1"  ]
then
    cp -rf  /allapps/app1/*  /var/www/html/
     httpd -DFOREGROUND 

elif  [  "$customer1" ==  "app2"  ]
then
    cp -rf  /allapps/app2/*  /var/www/html/
     httpd -DFOREGROUND 
    
elif  [  "$customer1" ==  "app3"  ]
then
    cp -rf  /allapps/app3/*  /var/www/html/
     httpd -DFOREGROUND 
else 
    echo "THis is Not right page "  >/var/www/html/index.html
    httpd -DFOREGROUND

fi 
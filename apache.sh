#!/bin/bash

echo '------------------ APACHE ------------------'

echo Install apache and utils
apt install apache2 apache2-utils

echo Enable and Start apache
systemctl enable apache2
systemctl start apache2

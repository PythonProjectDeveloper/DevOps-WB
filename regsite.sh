#!/bin/bash

# Вместо su писать su -
# в противном случаем многие команды не сможет найти например: a2enmod, a2ensite

# example:
# sh regsite.sh -site wp.com
#
# default: 
# sh regsite.sh -site site.com

siteName=site.com

while [ -n "$1" ]
do
        case "$1" in
                -site)
                        siteName=$2
                        shift
                        ;;

                --)
                        shift
                        break
                        ;;

                *) echo "$1 is not an option";;
        esac

        shift
done


echo '------------------ REGISTER SITE ------------------'

ext="conf"
confPath="/etc/apache2/sites-available"
defaultConfPath="${confPath}/000-default.${ext}"
siteConfPath="${confPath}/${siteName}.${ext}"
siteFolder="/var/www/${siteName}"


echo Preparing site config
cp $defaultConfPath $siteConfPath
sed -i "s|#ServerName www.example.com|ServerName $siteName|" $siteConfPath
sed -i "s|DocumentRoot \/var\/www\/html|DocumentRoot $siteFolder|" $siteConfPath
sed -i "s|error.log|$siteName.error.log|" $siteConfPath
sed -i "s|access.log|$siteName.access.log|" $siteConfPath


echo Enable site
cd $confPath
a2ensite "${siteName}.${ext}"
systemctl reload apache2

echo Change apache mod and reboot
a2enmod rewrite
systemctl restart apache2

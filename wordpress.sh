#!/bin/bash

# example:
# sh wordpress.sh -site wp.com -owner username
#
# default: 
# sh wordpress.sh -site site.com -owner www-data

siteName=site.com
owner='www-data'

while [ -n "$1" ]
do
	case "$1" in
		-site)
			siteName=$2
			shift
			;;

		-owner)
			owner=$2
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


echo '------------------ WORDPRESS ------------------'

ext="conf"
confPath="/etc/apache/sites-available"
defaultConfPath="${confPath}/000-default.${ext}"
siteConfPath="${confPath}/${siteName}.${ext}"
siteFolder="/var/www/${siteName}"

echo Load wordpress
wget -c http://wordpress.org/latest.tar.gz 
tar -xzf latest.tar.gz
rm -rf ./latest.tar.gz
mv ./wordpress $siteFolder
chown $owner:$owner -R $siteFolder
chmod -R 700 $siteFolder

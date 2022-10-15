#!/bin/bash

# Вместо su писать su -
# в противном случаем многие команды не сможет найти например: a2enmod, a2ensite

# example:
# sh script.sh -phpVersion 5.6 -siteName wp.com -dbname wp -dbuser wp_user -dbpass wp_pass
#
# default: 
# sh script.sh -phpVersion 7.4 -siteName site.com -dbname db -dbuser username -dbpass password

siteName=site.com
phpVersion=7.4
dbName=db
dbUser=username
dbPass=password

while [ -n "$1" ]
do
	case "$1" in
		-site)
			siteName=$2
			shift
			;;

		-php)
			phpVersion=$2
			shift 
			;;
			
		-dbname)
			dbName=$2
			shift 
			;;

		-dbuser)
			dbUser=$2
			shift 
			;;

		-dbpass)
			dbPass=$2
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

sh ./apache.sh
sh ./php.sh -version $phpVersion
sh ./wordpress.sh -site $siteName
sh ./regsite.sh -site $siteName
# don't work - sql query
/bin/bash ./mysql.sh -dbname $dbName -dbuser $dbUser -dbpass $dbPass
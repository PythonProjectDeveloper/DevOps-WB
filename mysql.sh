#!/bin/bash

# example:
# sh mysql.sh -dbname wp -dbuser wp_user -dbpass wp_pass
#
# default: 
# sh mysql.sh -dbname db -dbuser username -dbpass password

dbName=db
dbUser=username
dbPass=password

while [ -n "$1" ]
do
	case "$1" in
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

echo '------------------ MYSQL ------------------'

function package_exists() {
    return apt-cache pkgnames | grep -x "$1" | wc -l
}

if [ package_exists mysql-server == 1 ]
then
    apt install -y mysql-client mysql-server
else
	apt install -y mariadb-client mariadb-server
fi

# mysql_secure_installation


mysql -u root -p << eof
CREATE DATABASE $dbName;
CREATE USER '$dbUser'@'localhost' IDENTIFIED BY '$dbPass';
GRANT ALL PRIVILEGES ON $dbName.* TO '$dbUser'@'localhost';
FLUSH PRIVILEGES;
eof

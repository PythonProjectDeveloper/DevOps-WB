#!/bin/bash

# example:
# sh php.sh -version 6.5
#
# default: 
# sh php.sh -version 7.4

version=7.4

while [ -n "$1" ]
do
	case "$1" in
		-version)
			version=$2
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

echo '------------------ PHP ------------------'

echo Install php and utils
apt install -y "php${version}" \
			"php${version}-mysql" \
			"libapache2-mod-php${version}" \
			"php${version}-cli" \
			"php${version}-cgi" \
			"php${version}-gd"
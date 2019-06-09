#!/bin/bash
#lftp mirror [mget] file alone, by specifing absolute paths in a file.

#usage
function usage {
	echo
	echo "USAGE: For MAN page use -m [help command]"
	echo "$0 -u Username,'Password' -h Host -d Domain.com -f path_to_remotefile.txt"
}

#"${PROT}://${USER}:${PASSWORD}@${HOST}:${PORT}"
#Passing Arguments
while getopts "u:h:d:f:m" opt; do
	case "$opt" in
		u )
			USERPASS=$OPTARG
			;;
		h) 
			HOST=$OPTARG
			;;
		d) 
			DOMAIN=$OPTARG
			;;
		f)
			REMOTE_FILE=$OPTARG
			;;
		m | *)
		 usage
		 exit
		 ;;
	esac
done

#working area
cat "$REMOTE_FILE" 2> /dev/null | while read line
do
      dir=$(dirname $line)
      mkdir -p ~/Desktop/${DOMAIN}/${dir}

lftp -u $USERPASS ${HOST} -e "set net:timeout 10; set ssl:verify-certificate false; set ftp:ssl-allow no; mirror -c -f ${line} -O ~/Desktop/${DOMAIN}/${dir}; bye"
done
echo "Mirroring Completed, Successfully!"

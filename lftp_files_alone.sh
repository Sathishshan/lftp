#!/bin/bash
#lftp mirror [mget] file alone, by specifing absolute paths in a file.

USER=""
PASSWORD=""
HOST=""
REMOTE_FILE="$1"
DOMAIN=""
PORT="21"


cat "$1" | while read line
do
     dir=$(dirname $line)
     mkdir -p /opt/cww/${DOMAIN}/${dir}

lftp ftp://${USER}:${PASSWORD}@${HOST}:${PORT} -e "set net:timeout 10; set ftp:ssl-allow no; mirror -f ${line} -O /opt/cww/${DOMAIN}/${dir}; bye"
#if your are using sftp, please comment above line and un comment the below line.
#lftp sftp://${USER}:${PASSWORD}@${HOST}:${PORT} -e "set net:timeout 10; set ftp:ssl-allow no; mirror -f ${line} -O /opt/cww/${DOMAIN}/${dir}; bye"

done

# lftp -u ${USER},${PASSWORD} ${HOST} <<EOF
# set ftp:ssl-allow no
# set net:timeout 10
# mirror -P10 -f "$line" -O ./ && bye

# EOF


#ftp://${USER}:${PASSWORD}@${HOST}:${PORT} -e "set net:timeout 10; set ftp:ssl-allow no; mget -c $line; bye"
#if your are using sftp, please comment above line and un comment the below line.
#lftp sftp://${USER}:${PASSWORD}@${HOST}:${PORT} -e "set net:timeout 10; set ftp:ssl-allow no; mget -c $line; bye"```

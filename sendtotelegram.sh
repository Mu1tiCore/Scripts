#!/bin/bash
apikey=''
gchatid=''

text="$1"
curl -X GET "https://api.telegram.org/bot$apikey/sendMessage?chat_id=$gchatid&text=$text"
echo Sent message: "$text"

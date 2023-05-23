#!/bin/bash

# token - модификатор доступа, от кого будут идти сообщения, посмотреть можно в Riot: settings accaunt/Help & about/Access Token, в самом низу страницы
# room - идентификатор комнаты, в которую отсылается сообщение, посмотреть можно в Riot: settings room/Advanced/Internal room ID, копируем все, включая домен, "!" следует заменить на "%21"
# text - текст сообщения, передается скрипту как параметр при запуске


token="MDAxZGxvY2F0aW9uIHJpb3RpbS5vbGVnYi5ydQowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMmVjaWQgdXNlcl9pZCA9IEBkcG9uYW1hcmV2OnJpb3RpbS5vbGVnYi5ydQowMDyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyclPXCWQuRS36dOjhj88aQo"
room="%21oyyyyyyyDSX:riotim.olaa.ru"
text={\"msgtype\":\"m.text\",\"body\":\"$1\"}

curl -XPOST -d $text "https://riotim.olaa.ru/_matrix/client/r0/rooms/$room/send/m.room.message?access_token=$token"
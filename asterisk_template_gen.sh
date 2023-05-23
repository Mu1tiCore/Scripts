#! /bin/bash

if [ $domain=msk ]; then
	asterisk="127.0.0.1"
elif [ $domain=spb ]; then
	asterisk="127.0.0.1"
elif [ $domain=vladimir ]; then
	asterisk="127.0.0.1"
else
	exit 1
fi

ssh root@$asterisk cat <<EOF> #/etc/asterisk/pjsip.d/office-phones.d/{$siptel}-peer.conf
[{$siptel}0](aor_office_phones)
[{$siptel}0](auth_office_phones)
username={$siptel}0
password={$sippass}
[{$siptel}0](office_phones)
auth={$siptel}0
aors={$siptel}0
callerid="$fullname" <{$siptel}>

[{$siptel}1](aor_office_phones)
[{$siptel}1](auth_office_phones)
username={$siptel}1
password={$sippass}
[{$siptel}1](office_phones)
auth={$siptel}1
aors={$siptel}1
callerid="$fullname" <{$siptel}>

[{$siptel}2](aor_office_phones)
[{$siptel}2](auth_office_phones)
username={$siptel}2
[{$siptel}2](office_phones)
auth={$siptel}2
aors={$siptel}2
callerid="$fullname" <{$siptel}>

[{$siptel}3](aor_office_phones)
[{$siptel}3](auth_office_phones)
username={$siptel}3
[{$siptel}3](office_phones)
auth={$siptel}3
aors={$siptel}3
callerid="$fullname" <{$siptel}>
EOF

ssh root@$asterisk cat <<EOF> #/etc/asterisk/pjsip.d/office-phones.d/{$siptel}-queue.conf
[phone_{$siptel}](single-user)
member => PJSIP/{$siptel},1
member => PJSIP/{$siptel}0,1
member => PJSIP/{$siptel}1,1
member => PJSIP/{$siptel}2,1
member => PJSIP/{$siptel}3,1
EOF

#доделать эту переменную
#sippass=
# переменная mobile=личный сотовый в формате 89XXXXXXXXX

ssh root@$asterisk /bin/bash <<EOF
asterisk -rx "database put mobiles $siptel $mobile"
asterisk -rx "database put names $siptel $login"
asterisk -rx "database put devices $siptel SIP/$siptel"
asterisk -rx "database put phonetype $siptel mf"
asterisk -rx "pjsip reload"
asterisk -rx "database showkey $siptel"
EOF

#!/bin/sh
set -ue

FROM=no-reply@lkiesow.de
SUBJECT='Update Notification'
TO=lkiesow@uos.de

[ -f update.log ] || exit 0

echo 'Updates available. Sending email…'

payload='{
	"personalizations": [
		{
			"to": [
				{"email": null}
			]
		}],
	"from": {"email": null},
	"subject": null,
	"content": [
		{
			"type": "text/plain",
			"value": null
		}]
	}'

payload="$(echo "$payload" |
	jq --arg key "$FROM" ".from.email = \$key" |
	jq --arg key "$TO" ".personalizations[].to[].email = \$key" |
	jq --arg key "$SUBJECT" ".subject = \$key" |
	jq --arg key "$(cat update.log)" ".content[].value = \$key"
	)"

curl -s -f --request POST \
	--url https://api.sendgrid.com/v3/mail/send \
	--header "Authorization: Bearer $SENDGRID_API_KEY" \
	--header 'Content-Type: application/json' \
	--data "${payload}"

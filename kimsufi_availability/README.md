#Check kimsufi availability

Sample launch:
`docker container run -d --restart --name kimsufi_availability simbelmas/kimsufi_availability \
   -e KIM_EMAIL_FROM='{sender email}' \
   -e KIM_EMAIL_TO='{recipient}' \
   -e KIM_SMTP_SERVER='127.0.0.1' \
   -e KIM_SEARCH_MODEL='1801sk14'
`
This works with an unauthenticated smtp server.

you can also pass these additional vars to tune it:

* KIM_SMTP_SERVER_PORT=25 : smtp port
* KIM_CHECK_INTERVAL=10 : api check interval
* KIM_COUNTRY=fr : your country

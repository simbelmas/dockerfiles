#!/bin/ash

if [ -n "$KIM_EMAIL_FROM" ] ; then
  email_from=${KIM_EMAIL_FROM}
fi

if [ -n "$KIM_EMAIL_TO" ] ; then
  email_to=${KIM_EMAIL_TO}
fi

if [ -n "${KIM_SMTP_SERVER}" ] ; then
  smtp_server=${KIM_SMTP_SERVER}
fi

if [ -n "$KIM_SMTP_SERVER_PORT" ] ; then
  smtp_port=${KIM_SMTP_SERVER_PORT}
else
  smtp_port=25
fi

if [ -n "$KIM_COUNTRY" ] ; then
  country=${KIM_COUNTRY}
else
  country=fr
fi

if [ -n "$KIM_SEARCH_MODEL" ] ; then
  search_model=${KIM_SEARCH_MODEL}
fi

if [ -n "${KIM_CHECK_INTERVAL}" ] ; then
  check_interval=${KIM_CHECK_INTERVAL}
else
  check_interval=10
fi

#internal vars
region=europe
api_url=https://www.ovh.com/engine/api/dedicated/server/availabilities?country=${region:0:2}
cart_url=https://www.kimsufi.com/${country}/commande/kimsufi.xml?reference=${search_model}

if [ -z "${email_from}" -o -z "${email_to}" -o -z "${smtp_server}" ] ; then
	echo "please provides all parameters."
        cat README.md
	exit 2
fi

#grab data
data=$(curl -s "${api_url}")
if [ $? -ne 0 ] ; then
  echo "cannot fetch data, exiting" >&2
  exit 1
fi

# search hardware availability
number_of_available_dc=$(echo "${data}" | jq -r '.[] | select(.hardware=="'${search_model}'" and .region=="'${region}'") | .datacenters | map(select(.availability != "unavailable")) | length')
if [ $? -ne 0 ] ; then
  echo "Error in searching availability, exiting" >&2
  exit 3
fi

#Launching loop
while true ; do
  if [ "${number_of_available_dc}" -gt 0 ] ; then
    echo "$(date) ${search_model} kimsufi server is available"
    email -H "From: ${email_from}" \
     -s "Kimsufi ${search_model} server is available" \
     -r ${smtp_server} -p ${smtp_port} \
     "${email_to}" <<EOF
hey !
${search_model} kimsufi server is available now.
Hurry up and make your order ${cart_url}
EOF
  else
    echo "$(date) ${search_model} kimsufi server is not available"
  fi
  sleep ${check_interval}
done

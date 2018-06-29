#caldav wifi control container
Provides alpine container with python modules to read caldav event in webdav calendar (eg. nextcloud) and control livvebox wifi state. When an event is created, the wifi is disabled, else it's enabled.


To use it, pass all parameters on docker run command line:
 * calendar-url: http webdav calendar url with credetials
 * calendar-name: name of the calendar to search on
 * event-name: name of the event
 * livebox-url: admin url of the livebox interface
 * livebox-user: admin user of the livebox
 * livebox-pass: admin user pass of the livebox

Be careful, the process checks on launch if an event il present the current day. If it's the case, he process sleeep unti the sart of event and ends when the event is finished.
You have to launch this container each day to ensure its works.

```
docker container run caldav_livebox_wificontrol \
  --calendar-url 'https://wifimgr:wifimgr@nextcloud.mydomain.com/remote.php/dav/calendars' \
  --calendar-name wifidiable \
  --event-name 'stop wifi' \
  --livebox-url https://mylvb.dtdns.net:4242 \
  --livebox-user remoteuser \
  --livebox-pass 'pass'
```

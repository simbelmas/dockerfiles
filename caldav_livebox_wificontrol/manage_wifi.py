#!/bin/env python3
import argparse
from datetime import datetime,timedelta
import caldav
from icalendar import Calendar,Event,vDatetime
from lvwifi import Lvwifi
from wificontrol import Wificontrol
import pytz


# Parse options
parser = argparse.ArgumentParser(description='manage wifi')
#parser.add_argument('--enable',dest='action',help='enable wifi')
#parser.add_argument('--disable',dest='action',help='disable wifi')
#parser.add_argument('--status',dest='status',help='wifi status')
parser.add_argument('--calendar-url',dest='caldav_url',required=True,help='webdav calendar url')
parser.add_argument('--calendar-name',dest='wifi_calendar_name',required=True,help='calendar name')
parser.add_argument('--event-name',dest='wifi_event_name',required=True,help='event name')
parser.add_argument('--livebox-url',dest='livebox_url',required=True,help='Livebox web admin url')
parser.add_argument('--livebox-user',dest='livebox_user',required=True,help='Livebox admin user')
parser.add_argument('--livebox-pass',dest='livebox_pass',required=True,help='Livebox admin pass')
args = parser.parse_args()

if __name__ == "__main__":
  print('Connect to caldav server')
  client = caldav.DAVClient(args.caldav_url)
  print('grab calendars')
  calendars = client.principal().calendars()
  wifi_calendar_filtered_list= list(filter(lambda cal: str(cal).find(args.wifi_calendar_name) != -1,calendars))

  if not wifi_calendar_filtered_list:
    raise LookupError('the wifi calendar "%s", could not be found in provided calendars(%s)',args.wifi_calendar_name,calendars)

  #Prepare dates to search event
  today = datetime.now().date()
  tomorrow = today + timedelta(days=1)
  search_start_date=datetime(today.year,today.month,today.day)
  search_stop_date=datetime(tomorrow.year,tomorrow.month,tomorrow.day)

  events = wifi_calendar_filtered_list[0].date_search(search_start_date, search_stop_date)

  if events:
    #prepare wifi management class
    livebox_wifi = Lvwifi(args.livebox_url, args.livebox_user, args.livebox_pass)
    wifi_mgmt_threads = []
    matching_events=0
    for event in events:
      gcal = Calendar.from_ical(event.data)
      for component in gcal.walk():
        if component.name == "VEVENT" and args.wifi_event_name in component.get('summary'):
            matching_events=+1
            start_date = component.get('dtstart').dt
            end_date = component.get('dtend').dt
            eventid = component['UID']
            thread = Wificontrol(eventid,start_date,end_date,livebox_wifi,False,10)
            thread.start()
            wifi_mgmt_threads.append(thread)
    if matching_events == 0:
      print('The event "' + args.wifi_event_name + '"was not found in calendar "' + args.wifi_calendar_name +'" between "'+ str(today) +'" and "' + str(tomorrow) +'"')
    #Waiting for all threads to finish
    for t in wifi_mgmt_threads:
      t.join()
  else:
    print('no event found at all')

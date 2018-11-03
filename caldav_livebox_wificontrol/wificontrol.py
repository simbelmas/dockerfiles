#!/bin/env python3

import threading
from lvwifi import Lvwifi
from datetime import datetime,timedelta
import time
import pytz

class Wificontrol (threading.Thread):
  def __init__(self,thread_id,start_date,stop_date,livebox_wifi,wanted_status = False,enforce_interval_seconds = (10*60),toggle_at_end=True):
    threading.Thread.__init__(self)
    self.thread_id = thread_id
    self.start_date = start_date
    self.stop_date = stop_date
    self.__livebox_wifi = livebox_wifi
    self.wanted_status = wanted_status
    self.enforce_interval = enforce_interval_seconds
    self.restore_state=True
  def run(self):
    now = datetime.now(tz=pytz.timezone('Europe/Paris'))
    while self.start_date <= now and self.stop_date >= now:
      print('set status to ',str(self.wanted_status))
      self.__livebox_wifi.switchto(self.wanted_status)
      time.sleep(self.enforce_interval)
    if self.toggle_at_end:
      print('Restore wifi state before stopping')
      self.__livebox_wifi.toggle_status()
    print('Period end reatched, stopping')

#!/bin/env python3
import requests
import urllib3
urllib3.disable_warnings()
import json

try:
    import http.client as http_client
except ImportError:
    # Python 2
    import httplib as http_client

class Lvwifi:

  def connect(self):
    r = self.__session.post(self.__livebox_url + '/authenticate',params={'username': self.__livebox_user, 'password': self.__livebox_pass})
    if r.status_code != 200:
      raise ValueError('Cannot login : '+ r.text )
    self.__session.headers.update ({'X-Context': r.json()['data']['contextID']})

  def logout(self):
    r = self.__session.post(self.__livebox_url + '/logout', params='', verify=False)
    if r.status_code != 200:
      raise ValueError('Log out returnerd code other than 200 ' + r.status_code)

  def status(self):
    jsonparameters={"parameters":{"mibs":"base wlanvap","flag":"wlanvap","traverse":"down"}}
    r = self.__session.post(self.__livebox_url + '/sysbus/NeMo/Intf/lan:getMIBs', params=jsonparameters)
    return(r.json()['result']['status']['base']['wifi0_ath']['Enable'])

  def switchto(self,newstatus: bool):
    jsonparams={"parameters":{"mibs":{"penable":{"wifi0_ath":{"PersistentEnable": newstatus,"Enable": newstatus}}}}}
    r = self.__session.post(self.__livebox_url + '/sysbus/NeMo/Intf/wl0:setWLANConfig', data=json.dumps(jsonparams))
    if r.status_code != 200:
      raise ValueError('cannot set wifi status : wrong http status code (' + str(r.status_code) + '): ' + r.text)
    if 'error' in r.text:
      raise ValueError('cannot set wifi status : errors in operation \n' + r.text)
    if self.status() != newstatus:
        raise EnvironmentError('the wifi status after operation is not the wanted one')

  def __init__(self,livebox_url,livebox_user,livebox_pass):
    self.__livebox_url = livebox_url
    self.__livebox_user = livebox_user
    self.__livebox_pass = livebox_pass
    self.__session = requests.Session()
    self.__session.headers.update({'content-type': 'application/x-sah-ws-1-call+json; charset=UTF-8'})
    self.__session.headers.update({'Accept':'text/javascript'})
    self.__session.headers.update({'X-Prototype-Version': '1.7'})
    self.__session.headers.update({'X-Requested-With': 'XMLHttpRequest'})
    self.__session.headers.update({'DNT': '1'})
    self.__session.headers.update({'Connection': 'keep-alive'})
    self.__session.verify=False
    self.connect()

  def __del__(self):
    self.logout()

  def up(self):
    self.switchto(True)

  def down(self):
    self.switchto(False)

  def toggle_status(self):
    self.switchto((not self.status()))

--apply rules when mail is comming
repeat
		dofile ("/imapfilter/config/rules.lua")
until not account.inbox:enter_idle()
os.exit(0);

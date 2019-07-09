options.timeout=120
options.subscribe=true
options.expunge=true
options.starttls=false
options.certificates=false

account  = IMAP {
  server = 'my.server.fqdn.tld',
  username = 'my.mail@provider.tld',
  password = 'my_password',
  ssl = 'tls1.2',
  port=993
}

-- move all incoming messages from amazon to trash
autoTrashMessages = account.inbox:select_all()
trash = autoTrashMessages:contain_from('amazon.com')
trash:move_messages(account["Trash"])


-- move all incoming messages from amazon to trash
autoTrashMessages = account.inbox:select_all()
trash = autoTrashMessages:contain_from('amazon.com')
trash:move_messages(account["Trash"])

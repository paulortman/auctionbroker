from channels import Group

def websocket_receive(message):
    text = message.content.get('text')
    if text:
        message.reply_channel.send('ohi my')

def ws_add(message):
    message.reply_channel.send({"accept": True})
    Group("sales_events").add(message.reply_channel)

def ws_disconnect(message):
    Group("sales_events").discard(message.reply_channel)

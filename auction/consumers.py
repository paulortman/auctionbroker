from channels.generic.websocket import WebsocketConsumer
from asgiref.sync import async_to_sync

#
# class SalesConsumer(WebsocketConsumer):
#
#     # def websocket_connect(self, event):
#     #     self.send({
#     #         'type': "websocket.accept",
#     #     })
#     #
#     # def websocket_receive(self, event):
#     #     self.send({
#     #         'type': "websocket.send",
#     #         'text': event['text'],
#     #     })
#
#     # def websocket_receive(message):
#     #     text = message.content.get('text')
#     #     if text:
#     #         message.reply_channel.send('ohi my')
#     #
#     # def ws_add(message):
#     #     message.reply_channel.send({"accept": True})
#     #     Group("sales_events").add(message.reply_channel)
#     #
#     # def ws_disconnect(message):
#     #     Group("sales_events").discard(message.reply_channel)
#
#     def connect(self):
#         async_to_sync(self.channel_layer.group_add)("sales", self.channel_name)
#
#     def disconnect(self, close_code):
#         async_to_sync(self.channel_layer.group_discard)("sales", self.channel_name)
#
#     def receive(self, text_data=None, bytes_data=None):
#         async_to_sync(self.channel_layer.group_send)(
#             "sales",
#             {
#                 "type": "sales.message",
#                 "text": text_data,
#             },
#         )
#
#     def ws_add(self, event):
#         async_to_sync(self.channel_layer.group_send)(
#             "sales",
#             {
#                 "type": "sales.message",
#                 "text": event,
#             },
#         )



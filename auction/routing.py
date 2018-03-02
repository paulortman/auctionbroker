from channels.routing import ProtocolTypeRouter

application = ProtocolTypeRouter({
    # route("websocket.connect", ws_add),
    # route("websocket.disconnect", ws_disconnect)
    # Empty for now (http->django views is added by default)
})
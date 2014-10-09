@require "server" start Response
@require "favicon" favicon

downstream(req) = Response(404)

start(favicon("favicon.ico")(downstream), 8000)

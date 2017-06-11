@require "github.com/coiljl/server" serve
@require ".." favicon

server = serve(favicon("favicon.ico"), 8000)

println("server listening on http://localhost:8000")
wait(server)


@require "github.com/jkroso/HTTP.jl/server" serve Response
@require ".." favicon

server = serve(favicon("favicon.ico", r->Response(404)), 8000)

println("server listening on http://localhost:8000")
wait(server)

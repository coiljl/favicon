@require "github.com/jkroso/HTTP.jl/server" Response Request

"""
Generates a Function which produces responses to favicon requests
"""
function favicon(path::String; maxage=86400000)
  maxage = round(Int, min(maxage/1000, 31556926))
  OK = Response(200, Dict("Cache-Control" => "public, max-age=$maxage",
                          "Content-Type" => "image/x-icon"), read(path))
  serve(::Request{:GET}) = OK
  serve(::Request{:HEAD}) = Response(OK.status, OK.meta)
  serve(::Request{:OPTIONS}) = Response(204, Dict("Allow"=>"GET, HEAD, OPTIONS"))
  serve(::Request) = Response(405, Dict("Allow"=>"GET, HEAD, OPTIONS"))
end

"""
Generate a Function that delegates to `next` if it doesn't receive a favicon.ico Request
"""
function favicon(path::String, next::Function; kwargs...)
  serve = favicon(path; kwargs...)
  (r::Request) -> r.uri.path == "/favicon.ico" ? serve(r) : next(r)
end

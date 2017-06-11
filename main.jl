@require "github.com/coiljl/server" Response Request

"""
Generates a Function which produces responses to favicon requests
"""
function favicon(path::String; maxage=86400000)
  maxage = round(Int, min(maxage/1000, 31556926))
  OK = Response(200, Dict("Cache-Control" => "public, max-age=$maxage", 
                          "Content-Type" => "image/x-icon"), read(path))
  serve(::Request{:GET}) = OK
  serve(::Request{:HEAD}) = Response(OK.status, OK.meta)
  serve(::Request{:OPTIONS}) = Response(204, ["Allow"=>"GET, HEAD, OPTIONS"])
  serve(::Request) = Response(405, ["Allow"=>"GET, HEAD, OPTIONS"])
  serve(next::Function) = r -> r.uri.path == "/favicon.ico" ? serve(r) : next(r)
end

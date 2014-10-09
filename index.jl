@require "Response" Response
@require "Request" Request

##
# Generates a Function which serves `path` as a favicon
#
function favicon(path::String; maxage=86400000)
  maxage = int(min(maxage/1000, 31556926))
  OK = Response(200, [
    "Cache-Control" => "public, max-age=$maxage",
    "Content-Type" => "image/x-icon"
  ], open(readbytes, path))

  serve(::Request{:GET}) = OK
  serve(::Request{:HEAD}) = Response(OK.status, OK.meta)
  serve(::Request{:OPTIONS}) = Response(204, ["Allow"=>"GET, HEAD, OPTIONS"])
  serve(::Request) = Response(405, ["Allow"=>"GET, HEAD, OPTIONS"])
  serve(next::Function) = r -> r.uri.path == "/favicon.ico" ? serve(r) : next(r)
end

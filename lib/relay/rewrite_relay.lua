-- Copyright (C) by Kwanhur Huang



local relayShdict = ngx.shared.relay
local relayWriteURI = 'relay:write:uri'
local backend_uri = relayShdict:get(relayWriteURI) or '/write'

ngx.req.set_uri(backend_uri)
ngx.req.set_uri_args(ngx.var.backend_uri_args)


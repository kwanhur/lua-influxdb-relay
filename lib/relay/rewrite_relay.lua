--
-- Created by IntelliJ IDEA.
-- User: kwanhur
-- Date: 2016/11/13
-- Time: 上午11:01
-- To change this template use File | Settings | File Templates.
--
local relayShdict = ngx.shared.relay
local relayWriteURI = 'relay:write:uri'
local backend_uri = relayShdict:get(relayWriteURI) or '/write'
ngx.req.set_uri(backend_uri)
ngx.req.set_uri_args(ngx.var.backend_uri_args)


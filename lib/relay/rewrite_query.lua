-- Copyright (C) by Kwanhur Huang



local wrap_log = require('relay.utils.utils').wrap_log
local handler = require('relay.error.handler').handler
local stringUtil = require("relay.utils.strings")

local relayShdict = ngx.shared.relay
local relayURIKey = 'relay:uri'
local relayURI = relayShdict:get(relayURIKey)
if not relayURI then
    return
end

local relayURITbl = stringUtil.splitString(relayURI, ',')
if not relayURITbl or table.maxn(relayURITbl) == 0 then
    return
end

if ngx.var.args == "" then
    return
end

ngx.var.backend_uri_args = ngx.var.args

local relay = false
local args = ngx.var.args
local relayActionKey = 'relay:action'
local relayAction = relayShdict:get(relayActionKey)
local relayActionPrefix = 'q='
local relayActionTbl = stringUtil.splitString(relayAction, ',')
for _, action in ipairs(relayActionTbl) do
    if stringUtil.startswith(args, relayActionPrefix .. action) then
        relay = true
    end
end
if not relay then
    return
end


local pfunc = function()
    local reqs = {}
    local method = ngx.HTTP_POST
    for _, uri in ipairs(relayURITbl) do
        table.insert(reqs, { uri, { method = method, always_forward_body = true, copy_all_vars = true } })
    end

    local resps = { ngx.location.capture_multi(reqs) }
    local status
    local header
    local body
    for _, resp in ipairs(resps) do
        local respStatus = resp.status
        if not status then
            status = respStatus
        end
        if not header then
            header = resp.header
        end
        if not body then
            body = resp.body
        end
        if respStatus >= ngx.HTTP_SPECIAL_RESPONSE then
            ngx.log(ngx.WARN, 'server response code -------->>>> ' .. tostring(respStatus))
        end
    end

    ngx.status = status
    ngx.header.HEADER = header
    ngx.say(body)
end

local status, info = xpcall(pfunc, handler)
if not status then
    local errinfo = info[1]
    local errstack = info[2]
    local err, desc = errinfo[1], errinfo[2]
    ngx.log(ngx.ERR, wrap_log(err, desc, nil, errstack))
end
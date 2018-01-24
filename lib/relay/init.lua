-- Copyright (C) by Kwanhur Huang



local ini = require("resty.ini")
local stringUtil = require("relay.utils.strings")

local configPath = '/tmp/lua-influxdb-relay.ini'

local relayURIKey = 'relay:uri'
local relayWriteURIKey = 'relay:write:uri'
local relayActionKey = 'relay:action'
local relayShdict = ngx.shared.relay

local config = ini.parse_file(configPath)
local relayConfig = config.relay
local relayURI = relayConfig.relayURI
local relayWriteURI = relayConfig.relayWriteURI

if not relayURI or not relayWriteURI then
    ngx.log(ngx.ERR, 'relay uri could not be empty')
    ngx.exit()
end

local relayURITbl = stringUtil.splitString(relayURI, ',')
if not relayURITbl or table.maxn(relayURITbl) == 0 then
    ngx.log(ngx.ERR, 'relay uri could not be empty')
    ngx.exit()
end

local relayAction = relayConfig.relayAction
local relayActionTbl = stringUtil.splitString(relayAction, ',')

if not relayActionTbl or table.maxn(relayActionTbl) == 0 then
    ngx.log(ngx.ERR, 'relay action could not be empty')
    ngx.exit()
end

if not relayShdict then
    ngx.log(ngx.ERR, 'must specify lua shared dict for relay,just like:lua_shared_dict relay 1m;')
    ngx.exit()
end

relayShdict:set(relayURIKey, relayURI)
relayShdict:set(relayWriteURIKey, relayWriteURI)
relayShdict:set(relayActionKey, relayAction)

ngx.log(ngx.NOTICE, '--------> relay config inilize to end <------------')

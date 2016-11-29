--
-- Created by IntelliJ IDEA.
-- User: kwanhur
-- Date: 2016/11/11
-- Time: 下午7:35
-- To change this template use File | Settings | File Templates.
--
require "resty.core"
local ini = require("resty.ini")
local stringUtil = require("relay.utils.strings")

local configPath = '/path/to/lua-resty-influxdb-relay/lib/relay/conf.ini'
local relayURIKey = 'relay:uri'
local relayWriteURIKey = 'relay:write:uri'
local relayActionKey = 'relay:action'
local relayShdict = ngx.shared.apus_relay

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
relayShdict:set(relayURIKey, relayURI)
relayShdict:set(relayWriteURIKey, relayWriteURI)
relayShdict:set(relayActionKey, relayAction)
ngx.log(ngx.NOTICE, '--------> relay config inilize to end <------------')

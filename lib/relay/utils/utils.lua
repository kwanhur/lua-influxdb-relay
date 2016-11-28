local modulename = "apusUtilUtils"
local _M = {}
_M._VERSION = '0.0.1'

local cjson = require('cjson.safe')
--将doresp和dolog，与handler统一起来。handler将返回一个table，结构为：
--[[
handler———errinfo————errcode————code
    |           |               |
    |           |               |————info
    |           |
    |           |————errdesc
    |
    |
    |
    |———errstack				 
]] --

local getlog = function(info, desc, data, errstack)
    local errlog = ''
    local code, err = info[1], info[2]
    local errcode = code
    local errinfo = desc and err .. desc or err

    errlog = errlog .. ' errcode : ' .. errcode
    errlog = errlog .. ', errinfo : ' .. errinfo
    if data and type(data) ~= 'table' then
        errlog = errlog .. ', extrainfo : ' .. data
    end
    if errstack then
        errlog = errlog .. ', errstack : ' .. errstack
    end
    return errlog
end

_M.dolog = function(info, desc, data, errstack)
    local errlog = getlog(info, desc, data, errstack)
    ngx.log(ngx.ERR, errlog)
end

_M.dowarnlog = function(info, desc, data, errstack)
    local errlog = getlog(info, desc, data, errstack)
    ngx.log(ngx.WARN, errlog)
end

_M.donoticelog = function(info, desc, data)
    local errlog = getlog(info, desc, data)
    ngx.log(ngx.NOTICE, errlog)
end

_M.doresp = function(info, desc, data)
    local response = {}

    local code = info[1]
    local err = info[2]
    response.code = code
    response.success = code == 200
    response.message = desc and err .. desc or err
    if data then
        response.object = data
    end

    return cjson.encode(response)
end

return _M

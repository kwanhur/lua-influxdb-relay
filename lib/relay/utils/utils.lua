-- Copyright (C) by Kwanhur Huang


local modulename = "utilUtils"
local _M = {}
_M._VERSION = '0.0.1'
_M._NAME = modulename

local wrap_log = function(info, desc, data, errstack)
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

return _M

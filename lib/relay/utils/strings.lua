-- Copyright (C) by Kwanhur Huang



local modulename = "utilStrings"
local _M = {}
_M._VERSION = '0.0.1'
_M._NAME = modulename

_M.splitString = function(content, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {};
    local i = 1
    for str in string.gmatch(content, "([^" .. sep .. "]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

_M.startswith = function(content, startStr)
    return string.sub(content, 1, string.len(startStr)) == startStr
end

return _M
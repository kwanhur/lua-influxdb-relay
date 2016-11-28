--
-- Created by IntelliJ IDEA.
-- User: kwanhur
-- Date: 16/4/13
-- Time: 上午1:24
-- To change this template use File | Settings | File Templates.
--

local modulename = "apusUtilStrings"
local _M = {}
_M._VERSION = '0.0.1'

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

_M.endswith = function(content, endStr)
    return endStr == '' or string.sub(content, -string.len(endStr)) == endStr
end


return _M
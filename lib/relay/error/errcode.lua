-- Copyright (C) by Kwanhur Huang



local modulename = 'errorInfo'
local _M = {}

_M._VERSION = '0.0.1'

_M.info = {
    --	index			    code    desc
    --	SUCCESS
    ["SUCCESS"]			= { 200,   'success '},
    ["URI_NOT_FOUND_ERROR"] = { 404 , 'uri not found error for '},
    ["MODULE_NOT_FOUND"] = { 600, 'module not found for '},

    --	System Level ERROR
    ['LUA_RUNTIME_ERROR']	= { 40201, 'lua runtime error '},
    ['BLANK_INFO_ERROR']	= { 40202, 'errinfo blank in handler '},
    --  unknown reason
    ['UNKNOWN_ERROR']		= { 50501, 'unknown reason '},

    -- http error
    ['HTTP_CONNECT_ERROR']  = { 50601, 'http conect error for '},
    ['HTTP_RESPONSE_STATUS_ERROR'] = { 50602, 'http response status for '},

    ['SHDICT_SET_ERROR']    = { 50801, 'share dict set error for '},
    ['SHDICT_DEL_ERROR']    = { 50802, 'share dict del error for '},
    ['SHDICT_INCR_ERROR']   = { 50803, 'share dict incr error for '}
}

return _M

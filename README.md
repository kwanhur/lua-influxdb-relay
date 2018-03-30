# lua-influxdb-relay
A Lua resty service to replicate InfluxDB data for high availability

Table of Contents
=================

* [Name](#name)
* [Status](#status)
* [Synopsis](#synopsis)
* [Installation](#installation)
* [Authors](#authors)
* [Copyright and License](#copyright-and-license)

Status
======
This library is still under early development and experimental.

Synopsis
========
```lua
    # --------- copy relay configuration file -----------
    cp -av /path/to/lua-influxdb-relay/lib/relay/lua-influxdb-relay.ini.demo /tmp/lua-influxdb-relay.ini

    # --------- relay config begin --------------
    	lua_code_cache on;
    	lua_package_path "/path/to/openresty/lualib/?.lua;/path/to/lua-influxdb-relay/lib/?.lua;;";
    	lua_package_cpath "/path/to/openresty/lualib/?.so;;";
    	lua_shared_dict relay 1m;
    	init_by_lua_file '/path/to/lua-influxdb-relay/lib/relay/init.lua';
    # --------- relay config end ----------------

    upstream backend_query {
      server 127.0.0.1:8086;
      server 127.0.0.1:8087;
    }
    
    server {
    
      log_subrequest on;
    
      location = /write {
        set $backend_uri_args '';
        rewrite_by_lua_file '/path/to/lua-influxdb-relay/lib/relay/rewrite.lua';
      }
    
      location = /query {
        proxy_pass http://backend_query;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $http_host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Connection "";
        proxy_http_version 1.1;
        
        rewrite_by_lua_file '/path/to/lua-influxdb-relay/lib/relay/rewrite_query.lua';
      }
    
      location = /relay1 {
        internal;
        
        proxy_pass http://127.0.0.1:8086;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $http_host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Connection "";
        proxy_http_version 1.1;
        
        rewrite_by_lua_file '/path/to/lua-influxdb-relay/lib/relay/rewrite_relay.lua';
      }
    
      location = /relay2 {
        internal;
      
        proxy_pass http://127.0.0.1:8087;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $http_host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Connection "";
        proxy_http_version 1.1;
        
        rewrite_by_lua_file '/path/to/lua-influxdb-relay/lib/relay/rewrite_relay.lua';
      }
    
    }
```

[Back to TOC](#table-of-contents)

Installation
============

lua-influxdb-relay use [lua-resty-ini](https://github.com/doujiang24/lua-resty-ini) to parse the ini configuration.
And you should install it with [opm](https://github.com/openresty/opm#readme) just like that: opm install doujiang24/lua-resty-ini

[Back to TOC](#table-of-contents)

Authors
=======

kwanhur <huang_hua2012@163.com>, VIPS Inc.

[Back to TOC](#table-of-contents)

Copyright and License
=====================

This module is licensed under the Apache License Version 2.0 .

Copyright (C) 2018, by kwanhur <huang_hua2012@163.com>, VIPS Inc.

All rights reserved.

Unless required by applicable law or agreed to in writing, software distributed under the License is 
distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
See the License for the specific language governing permissions and limitations under the License.

[Back to TOC](#table-of-contents)
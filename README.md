# lua analysis html
English | [简体中文](README-zh_CN.md)

lua analysis html xss detection

Based on [lua-htmlparser](https://github.com/msva/lua-htmlparser)

### Main purpose
1.Xss semantic analysis
2.Help discover xss attacks

## Examples
```lua

package.path = "./src/?.lua;" .. package.path

local xss_engine = require("xss_engine")


local text =[[
<img src=x onerror=alert(1)>
]]

if xss_engine.is_xss(text) then
    print("this is info xss")
else
    print("this is info not xss")
end


```
```bash
[root@localhost lua-htmlparser]# luajit test2.lua 
this is info xss

```

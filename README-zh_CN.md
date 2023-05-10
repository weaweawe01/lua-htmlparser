# lua 解析 html

基于  [lua-htmlparser](https://github.com/msva/lua-htmlparser)

### 有什么作用？
1.xss 的语法检测
2.解析 html 标签

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

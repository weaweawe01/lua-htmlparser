# lua ���� html

����  [lua-htmlparser](https://github.com/msva/lua-htmlparser)

### ��ʲô���ã�
1.xss ���﷨���
2.���� html ��ǩ

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

# lua ���� html

����  [lua-htmlparser](https://github.com/msva/lua-htmlparser)

### ��ʲô���ã�
1.xss ���﷨��� ��δʵ��
2.���� html ��ǩ

## Examples
```lua
package.path = "../src/?.lua;" .. package.path
pcall(require, "luacov")
print("------------------------------------")
print("Lua version: " .. (jit and jit.version or _VERSION))
print("------------------------------------")
print("")

local json=require("cjson")
local htmlparser = require("htmlparser")
function test_void()

	local text =[[
	<image/src/onerror=prompt(8)>
<img/src/onerror=prompt(8)>
<image src/onerror=prompt(8)>
<img src/onerror=prompt(8)>
<script>javascript:alert(1)</script>
]]

	local root = htmlparser.parse(text)

	local elements = root:select("*")
	for i,e in ipairs(elements) do
		--print("i :"..i)
		print("name: "..e.name)
		--print("attributes: "..e.attributes)
		print("getcontent: "..e:getcontent())

		if e.attributes["src"] then
			print("src: "..e.attributes["src"])
		end
		print("attributes: "..json.encode(e.attributes))
	end
end
test_void()

```
```lua

[root@localhost tst]# luajit init.lua 
------------------------------------
Lua version: LuaJIT 2.0.4
------------------------------------

name: image
getcontent: 
src: 
attributes: {"onerror":"prompt(8)","src":""}
name: img
getcontent: 
src: 
attributes: {"onerror":"prompt(8)","src":""}
name: image
getcontent: 
src: 
attributes: {"onerror":"prompt(8)","src":""}
name: img
getcontent: 
src: 
attributes: {"onerror":"prompt(8)","src":""}
name: script
getcontent: javascript:alert(1)
attributes: {}

```

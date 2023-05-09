-- vim: ft=lua ts=2 sw=2
-- Omit next line in actual module clients; it's only to support development of the module itself
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
		--print(e.nodes)
		--print("nodes: "..json.encode(e.nodes))
		--print(e.parent)
		--print(".deepernodes: "..json.encode(e.deepernodes))
		--print(".deeperelements: "..json.encode(e.deeperelements))
		--print(".deeperattributes: "..json.encode(e.deeperattributes))
		--print(".deeperids:.. "..json.encode(e.deeperids))
		--print(".deeperclasses: "..json.encode(e.deeperclasses))
		--print("gettext: "..e:gettext())


	end

	--for _,n in ipairs(tree.nodes) do
	--		print(n.name)
	--
	--		print(n.attributes)
	--		print(json.encode(n.attributes))
	--		--
	--		--print(n.id)
	--		--print(n.classes)
	--		--print("get"..n:getcontent())
	--	    --print()
	--	for i,v in pairs(n.parent) do
	--		local ok,_ = pcall(function()
	--			print(json.encode(v))
	--			return
	--		end)
	--
	--
	--	end
	--
	--end
end
test_void()
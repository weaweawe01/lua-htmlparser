
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

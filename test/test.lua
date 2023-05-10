


local tagst =[[
<input name="name" value=""onmouseover=prompt('xss') bad="">
]]

local start, k, eq, quote, v, zsp
print(tagst)

while true do
    local apos=1
    start, apos, k, zsp, eq, zsp, quote = tagst:find(
        "[%s+|/]" ..         -- some uncaptured space
        "([^%s=/>]+)" .. -- k = an unspaced string up to an optional "=" or the "/" or ">"
        "([%s]-)"..      -- zero or more spaces
        "(=?)" ..        -- eq = the optional; "=", else ""
        "([%s]-)"..      -- zero or more spaces
        [=[(['"]?)]=],      -- quote = an optional "'" or '"' following the "=", or ""
    apos)

    datas=tagst:find("[%s+|/|>]")
    print("datas "..datas)

    print("start "..start)
    print("apos "..apos)
    print("k "..k)
    print("zsp "..zsp)
    print("eq "..eq)
    print("quote "..quote)
end
local htmlparser = require("htmlparser")
local xss_engine = {}
local BLACKATTREVENT = {}
BLACKATTREVENT["onbeforeunload"] = true
BLACKATTREVENT["onblur"] = true
BLACKATTREVENT["onerror"] = true
BLACKATTREVENT["onfocus"] = true
BLACKATTREVENT["onhashchange"] = true
BLACKATTREVENT["onload"] = true
BLACKATTREVENT["onmessage"] = true
BLACKATTREVENT["onpageshow"] = true
BLACKATTREVENT["onresize"] = true
BLACKATTREVENT["onchange"] = true
BLACKATTREVENT["onforminput"] = true
BLACKATTREVENT["onselect"] = true
BLACKATTREVENT["onsubmit"] = true
BLACKATTREVENT["onkeydown"] = true
BLACKATTREVENT["onkeypress"] = true
BLACKATTREVENT["onkeyup"] = true
BLACKATTREVENT["onclick"] = true
BLACKATTREVENT["ondblclick"] = true
BLACKATTREVENT["onmousedown"] = true
BLACKATTREVENT["onmousemove"] = true
BLACKATTREVENT["onmouseout"] = true
BLACKATTREVENT["onmouseover"] = true
BLACKATTREVENT["onmouseup"] = true
BLACKATTREVENT["ontoggle"] = true

local function is_xss(text)
    local root = htmlparser.parse(text)
    local elements = root:select("*")
    local count =0
    for i,e in ipairs(elements) do
        count=count+1
        -- all tag check
        --print("tag: "..e.name)
        if e:length()>=1 then
            -- back attributes
            for k,v in pairs(e.attributes) do
                if BLACKATTREVENT[k] then
                    if e.attributes[k] ~="" then
                        return true
                    end
                end
            end
        end
        -- all tag src check
        if e.attributes["src"]  then
            if string.find(e.attributes["src"],"javascript") then
                return true
            end
        end

        -- all tag href check
        if e.attributes["href"]  then
            if string.find(e.attributes["href"],"javascript") then
                return true
            end
        end

        -- all tag href check
        if e.attributes["action"]  then
            if string.find(e.attributes["action"],"javascript") then
                return true
            end
        end

        -- script tag check
        if e.name=="script" then
            if e.attributes["src"] then
                --this is src script
                return true
            end
        end
            if e:getcontent()~="" then
                 return true
            end
        end

        if e.name=="iframe" then
            if e.attributes["srcdoc"] then
                return true
            end
        end

    local limit=100
    local apos=0
    local loop=0
    local result={}
    if count==0 then
        while true do -- TagLoop {{{
            if count == limit then -- {{{
                break
            end -- }}}
            -- Attrs {{{
            local start, k, eq, quote, v, zsp
            start, apos, k, zsp, eq, zsp, quote = text:find(
                    "[%s+|/|\"|']" ..         -- some uncaptured space
                            "([^%s=/>]+)" .. -- k = an unspaced string up to an optional "=" or the "/" or ">"
                            "([%s]-)"..      -- zero or more spaces
                            "(=?)" ..        -- eq = the optional; "=", else ""
                            "([%s]-)"..      -- zero or more spaces
                            [=[(['"]?)]=],      -- quote = an optional "'" or '"' following the "=", or ""
                    apos)
            if not k or k == "/>" or k == ">" then break end
            print("k="..k)

            -- 防止死循环
            if start>=1 then
                if (loop>start) then
                    break
                end
                loop=start
            end
            if eq == "=" then
                local pattern = "=([^%s>]*)"
                if quote ~= "" then
                    pattern = quote .. "([^" .. quote .. "]*)" .. quote
                end
                start, apos, v = text:find(pattern, apos)
            end
            -- }}}
            v=v or ""
            if tpl then -- {{{
                for rk,rv in pairs(tpr) do
                    v = v:gsub(rv,rk)
                end
            end
            if result[k:lower()] then
                result[k:lower()]=result[k:lower()]..","..v:lower()
            else
                result[k:lower()]=v:lower()
            end
            count = count + 1
        end
        for i2,_ in  pairs(result) do
            if BLACKATTREVENT[i2] then
                return true
            end
        end
       end
    return false
    end

xss_engine.is_xss = is_xss
return xss_engine
-- ^_^
string.dump = "builtin"

--hooking username4return username
client.get_username = function()
    return "hikkikamori"
end

--create log func
local log = function(txt)
    print(tostring(txt))
end

--saving original ffi.cast function
local o_ffi_cast = ffi.cast

ffi.cast = function (type, value)
    -- спасибо за юз спащеной хуйни :DD
    if type == "get_file_time_t" then
        return function() return "1234567890" end
    end
    -- getting httplink
    if type == "struct http_ISteamHTTPVtbl**" then
        local orig = o_ffi_cast(type, value)
        return {
            [0] = setmetatable({}, {
                __index = function(s, k)
                    local val = orig[0][k]
                if k == "CreateHTTPRequest" then 
                    return function (ptr, method, url)
                        if url:find("pastebin.com/raw/7rKEsC3C") then
                            client.notify("hooked shit")
                            return val(ptr, method, "https://pastebin.com/raw/3Aeg9vZw")
                        else
                            return val(ptr, method, url)
                        end
                    end
                end
                 return val
            end
        })
    } 
    end
    return o_ffi_cast(type, value)
end

client.notify("cracked lol")

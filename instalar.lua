local MAX_FFLAG_SIZE = 100 * 1024

local function safeReadFile(path)
    if not isfile(path) then
        return nil
    end

    local data = readfile(path)
    if type(data) ~= "string" then
        return nil
    end

    if #data > MAX_FFLAG_SIZE then
        return nil
    end

    return data
end

local function safeDecode(json)
    local ok, result = pcall(function()
        return game:GetService("HttpService"):JSONDecode(json)
    end)

    if not ok or type(result) ~= "table" then
        return {}
    end

    return result
end

getgenv().autosetup = {
    path = 'Bloxstrap',
    setup = true
}

loadstring(game:HttpGet(
    'https://raw.githubusercontent.com/0kenyah/bloxstrap-/refs/heads/main/instalar.lua,
    true
))()

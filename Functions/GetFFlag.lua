local HttpService = game:GetService("HttpService")

local MAX_FFLAG_SIZE = 230 * 1024

return function(path, key)
    if not isfile(path) then
        return nil
    end

    local data = readfile(path)
    if type(data) ~= "string" or #data > MAX_FFLAG_SIZE then
        return nil
    end

    local ok, decoded = pcall(function()
        return HttpService:JSONDecode(data)
    end)

    if not ok or type(decoded) ~= "table" then
        return nil
    end

    return decoded[key]
end

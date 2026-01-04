local HttpService = game:GetService("HttpService")

local MAX_FFLAG_SIZE = 230 * 1024

local function clamp(n, min, max)
    if n < min then return min end
    if n > max then return max end
    return n
end

return function(path, key, value)
    local data = "{}"

    if isfile(path) then
        local raw = readfile(path)
        if type(raw) == "string" and #raw <= MAX_FFLAG_SIZE then
            data = raw
        end
    end

    local ok, decoded = pcall(function()
        return HttpService:JSONDecode(data)
    end)

    if not ok or type(decoded) ~= "table" then
        decoded = {}
    end

    if type(value) == "number" then
        value = clamp(value, 0, 240)
    end

    decoded[key] = value

    writefile(path, HttpService:JSONEncode(decoded))
end

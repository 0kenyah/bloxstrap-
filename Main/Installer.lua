local HttpService = game:GetService("HttpService")

local basePath = autosetup and autosetup.path or "Bloxstrap"

if not isfolder(basePath) then
    makefolder(basePath)
end

local clientSettings = basePath .. "/ClientSettings"
if not isfolder(clientSettings) then
    makefolder(clientSettings)
end

local settingsPath = clientSettings .. "/ClientAppSettings.json"

local MAX_FFLAG_SIZE = 100 * 1024

local function safeRead(path)
    if not isfile(path) then return nil end
    local data = readfile(path)
    if type(data) ~= "string" then return nil end
    if #data > MAX_FFLAG_SIZE then return nil end
    return data
end

local function safeDecode(json)
    local ok, data = pcall(function()
        return HttpService:JSONDecode(json)
    end)
    if not ok or type(data) ~= "table" then
        return {}
    end
    return data
end

local function clamp(n, min, max)
    if n < min then return min end
    if n > max then return max end
    return n
end

local BLACKLIST = {
    DFIntRakNetLoopMs = true,
    DFIntMaxProcessPacketsJobScaling = true,
    FFlagTaskSchedulerLimitTargetFpsTo2402 = true
}

local function sanitize(flags)
    local out = {}

    for k, v in pairs(flags) do
        if not BLACKLIST[k] then
            if type(v) == "number" and k:sub(1,5) == "DFInt" then
                out[k] = clamp(v, 0, 240)
            else
                out[k] = v
            end
        end
    end

    return out
end

local raw = safeRead(settingsPath)
local decoded = raw and safeDecode(raw) or {}
local final = sanitize(decoded)

writefile(settingsPath, HttpService:JSONEncode(final))

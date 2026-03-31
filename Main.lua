local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer

-- executor request fallback (covers most executors)
local req = request or syn and syn.request or http_request or fluxus and fluxus.request
if not req then
    warn("Executor does not support HTTP requests")
    return
end

-- get avatar (retry until we actually get something usable)
local thumbType = Enum.ThumbnailType.HeadShot
local thumbSize = Enum.ThumbnailSize.Size420x420

local avatarUrl
for i = 1, 5 do
    local url = Players:GetUserThumbnailAsync(player.UserId, thumbType, thumbSize)
    if url and url ~= "" then
        avatarUrl = url
        break
    end
    task.wait(0.2)
end

avatarUrl = avatarUrl or ""

-- 🔴 PUT YOUR *NEW* WEBHOOK HERE
local webhook = "https://discord.com/api/webhooks/1488030355251269674/fH5_1gMDaO2ELehYGtC78ID1NYNE0Gu-9TxolsBZsB0pZZYYVbzktaxNMQngEpDXErar"

local data = {
    ["username"] = player.Name,
    ["avatar_url"] = avatarUrl,
    ["embeds"] = {{
        ["title"] = "Smurf HB Executed",
        ["color"] = 65280,

        ["fields"] = {
            {
                ["name"] = "User",
                ["value"] = player.Name .. " (" .. player.DisplayName .. ")",
                ["inline"] = true
            },
            {
                ["name"] = "User ID",
                ["value"] = tostring(player.UserId),
                ["inline"] = true
            }
        },

        ["thumbnail"] = {
            ["url"] = avatarUrl
        },

        ["footer"] = {
            ["text"] = "Time: " .. os.date("%Y-%m-%d %H:%M:%S")
        }
    }}
}

local response = req({
    Url = webhook,
    Method = "POST",
    Headers = {
        ["Content-Type"] = "application/json"
    },
    Body = HttpService:JSONEncode(data)
})

-- debug output so you’re not guessing
if response then
    print("Webhook status:", response.StatusCode or "unknown")
else
    warn("No response from request")
end

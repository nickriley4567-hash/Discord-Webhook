local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer

-- request fallback (works with most executors including Xeno)
local req = request or (syn and syn.request) or http_request or (fluxus and fluxus.request)
if not req then
    warn("Executor does not support HTTP requests")
    return
end

-- get avatar safely
local thumbType = Enum.ThumbnailType.HeadShot
local thumbSize = Enum.ThumbnailSize.Size420x420

local avatarUrl = ""
pcall(function()
    local url = Players:GetUserThumbnailAsync(player.UserId, thumbType, thumbSize)
    if url and url ~= "" then
        avatarUrl = url
    end
end)

-- 🔴 PUT YOUR WEBHOOK HERE (regenerate it if needed)
local webhook = "https://discord.com/api/webhooks/1488030355251269674/fH5_1gMDaO2ELehYGtC78ID1NYNE0Gu-9TxolsBZsB0pZZYYVbzktaxNMQngEpDXErar"

-- build payload (SAFE: no avatar_url field to avoid 400)
local data = {
    username = player.Name,
    embeds = {{
        title = "Smurf HB Executed",
        color = 65280,

        fields = {
            {
                name = "User",
                value = player.Name .. " (" .. player.DisplayName .. ")",
                inline = true
            },
            {
                name = "User ID",
                value = tostring(player.UserId),
                inline = true
            }
        },

        -- only include thumbnail if valid
        thumbnail = avatarUrl ~= "" and { url = avatarUrl } or nil,

        footer = {
            text = "Time: " .. os.date("%Y-%m-%d %H:%M:%S")
        }
    }}
}

-- send request
local response = req({
    Url = webhook,
    Method = "POST",
    Headers = {
        ["Content-Type"] = "application/json"
    },
    Body = HttpService:JSONEncode(data)
})

-- debug output
if response then
    print("Webhook status:", response.StatusCode or "unknown")
    if response.Body then
        print("Response:", response.Body)
    end
else
    warn("No response from request")
end

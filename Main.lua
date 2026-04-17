local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

local webhook = "https://discord.com/api/webhooks/1488030355251269674/fH5_1gMDaO2ELehYGtC78ID1NYNE0Gu-9TxolsBZsB0pZZYYVbzktaxNMQngEpDXErar"

-- executor request support (works on most)
local req = (syn and syn.request)
    or (http and http.request)
    or http_request
    or request

if not req then
    warn("")
    return
end

-- SAFE thumbnail fetch
local thumbnailUrl = ""

local success, result = pcall(function()
    return Players:GetUserThumbnailAsync(
        player.UserId,
        Enum.ThumbnailType.HeadShot,
        Enum.ThumbnailSize.Size420x420
    )
end)

if success and result and result ~= "" then
    thumbnailUrl = result
else
    thumbnailUrl = "https://cdn.discordapp.com/embed/avatars/0.png"
end

-- webhook data
local data = {
    ["username"] = "Smurf HB",
    ["embeds"] = {{
        ["title"] = "Smurf HB Executed",
        ["description"] =
            "Script executed.\n\n" ..
            "Username: " .. player.Name .. "\n" ..
            "Display Name: " .. player.DisplayName .. "\n" ..
            "UserID: " .. player.UserId .. "\n" ..
            "ServerID: " .. game.JobId,

        ["type"] = "rich",
        ["color"] = 65280,

        ["thumbnail"] = {
            ["url"] = thumbnailUrl
        },

        ["footer"] = {
            ["text"] = os.date("%Y-%m-%d %H:%M:%S")
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

-- debug print
print("Webhook response:", response and response.StatusCode)

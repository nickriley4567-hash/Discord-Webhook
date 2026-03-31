local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer

-- Get avatar
local thumbType = Enum.ThumbnailType.HeadShot
local thumbSize = Enum.ThumbnailSize.Size420x420
local avatarUrl = Players:GetUserThumbnailAsync(player.UserId, thumbType, thumbSize)

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
            ["text"] = os.date("%Y-%m-%d %H:%M:%S")
        }
    }}
}

request({
    Url = webhook,
    Method = "POST",
    Headers = {
        ["Content-Type"] = "application/json"
    },
    Body = HttpService:JSONEncode(data)
})

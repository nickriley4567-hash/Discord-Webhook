local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

local webhook = "https://discord.com/api/webhooks/1488030355251269674/fH5_1gMDaO2ELehYGtC78ID1NYNE0Gu-9TxolsBZsB0pZZYYVbzktaxNMQngEpDXErar"

-- Get player avatar (headshot)
local thumbnailUrl = Players:GetUserThumbnailAsync(
    player.UserId,
    Enum.ThumbnailType.HeadShot,
    Enum.ThumbnailSize.Size420x420
)

local data = {
    ["username"] = "Smurf HB",
    ["content"] = "",
    ["embeds"] = {{
        ["title"] = "Smurf HB Executed",
        ["description"] =
            "Script was executed successfully.\n\n" ..
            "Username: " .. player.Name .. "\n" ..
            "Display Name: " .. player.DisplayName .. "\n" ..
            "UserID: " .. player.UserId .. "\n" ..
            "ServerID (JobId): " .. game.JobId,

        ["type"] = "rich",
        ["color"] = tonumber(0x00ff00),

        -- Small avatar on the right side
        ["thumbnail"] = {
            ["url"] = thumbnailUrl
        },

        -- Optional big image (uncomment if you want larger avatar display)
        -- ["image"] = {
        --     ["url"] = thumbnailUrl
        -- },

        ["footer"] = {
            ["text"] = "Time: " .. os.date("%Y-%m-%d %H:%M:%S")
        }
    }}
}

local headers = {
    ["Content-Type"] = "application/json"
}

local body = HttpService:JSONEncode(data)

request({
    Url = webhook,
    Method = "POST",
    Headers = headers,
    Body = body
})

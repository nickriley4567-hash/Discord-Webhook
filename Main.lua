local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer

local req = request or (syn and syn.request) or http_request
if not req then
    warn("No HTTP request function")
    return
end

local avatarUrl = ""
pcall(function()
    avatarUrl = Players:GetUserThumbnailAsync(
        player.UserId,
        Enum.ThumbnailType.HeadShot,
        Enum.ThumbnailSize.Size420x420
    )
end)

local webhook = "PUT_WEBHOOK_HERE"

local data = {
    username = "Smurf HB",
    embeds = {
        {
            title = "Smurf HB Executed",
            color = 65280,

            fields = {
                { name = "User", value = player.Name .. " (" .. player.DisplayName .. ")", inline = true },
                { name = "User ID", value = tostring(player.UserId), inline = true }
            },

            thumbnail = {
                url = avatarUrl ~= "" and avatarUrl or "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=420&height=420&format=png"
            },

            footer = {
                text = "Time: " .. os.date("%Y-%m-%d %H:%M:%S")
            }
        }
    }
}

local response = req({
    Url = webhook,
    Method = "POST",
    Headers = { ["Content-Type"] = "application/json" },
    Body = HttpService:JSONEncode(data)
})

print("Status:", response and response.StatusCode)
if response and response.Body then
    print("Response:", response.Body)
end

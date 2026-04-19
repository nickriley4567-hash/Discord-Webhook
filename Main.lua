local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

local webhook = "https://discord.com/api/webhooks/1495263853490208948/CwcFE-YBrulj2gk5BESEQHdf1l5O3O6PoVQo4Bzw7VifZH1nHqwrNqRL_4ceFhJwi637"

local data = {
    ["username"] = "Smurf HB",
    ["content"] = "",
    ["embeds"] = {{
        ["title"] = "Smurf HB Executed",
        ["description"] = "Script was executed successfully.\n\n" ..
            "Username: " .. player.Name .. "\n" ..
            "Display Name: " .. player.DisplayName .. "\n" ..
            "UserID: " .. player.UserId .. "\n" ..
            "ServerID (JobId): " .. game.JobId,
        ["type"] = "rich",
        ["color"] = tonumber(0x00ff00),
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

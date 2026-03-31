local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

local webhook = "https://discord.com/api/webhooks/1488030355251269674/fH5_1gMDaO2ELehYGtC78ID1NYNE0Gu-9TxolsBZsB0pZZYYVbzktaxNMQngEpDXErar"

local data = {
    ["username"] = "Smurf HB",
    ["content"] = "",
    ["embeds"] = {{
        ["title"] = "Smurf HB Executed",
        ["description"] = "Script was executed successfully.\n\n" ..
            "Username: " .. player.Name .. "\n" ..
            "Display Name: " .. player.DisplayName .. "\n" ..
            "UserID: " .. player.UserId,
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

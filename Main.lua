local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

local webhook = "https://discord.com/api/webhooks/1488030355251269674/fH5_1gMDaO2ELehYGtC78ID1NYNE0Gu-9TxolsBZsB0pZZYYVbzktaxNMQngEpDXErar"

local req = (syn and syn.request)
    or (http and http.request)
    or http_request
    or request

local data = {
    username = "Smurf HB",
    embeds = {{
        title = "Executed",
        description =
            "Username: " .. player.Name .. "\n" ..
            "Display Name: " .. player.DisplayName .. "\n" ..
            "UserID: " .. player.UserId .. "\n" ..
            "JobId: " .. game.JobId,
        color = 65280
    }}
}

req({
    Url = webhook,
    Method = "POST",
    Headers = {
        ["Content-Type"] = "application/json"
    },
    Body = HttpService:JSONEncode(data)
})

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

local webhook = "https://discord.com/api/webhooks/1488030355251269674/fH5_1gMDaO2ELehYGtC78ID1NYNE0Gu-9TxolsBZsB0pZZYYVbzktaxNMQngEpDXErar"

local req = (syn and syn.request)
    or (http and http.request)
    or http_request
    or request

local jobId = game.JobId
local attempts = 0

while jobId == "" and attempts < 10 do
    task.wait(0.5)
    jobId = game.JobId
    attempts += 1
end

local data = {
    username = "Smurf HB",
    embeds = {{
        title = "Executed",
        description =
            "Username: " .. player.Name .. "\n" ..
            "Display Name: " .. player.DisplayName .. "\n" ..
            "UserID: " .. player.UserId .. "\n" ..
            "JobId: " .. (jobId ~= "" and jobId or "Unavailable"),
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

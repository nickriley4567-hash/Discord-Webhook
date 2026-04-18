local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait() and Players.LocalPlayer

local webhook = "https://discord.com/api/webhooks/1488030355251269674/fH5_1gMDaO2ELehYGtC78ID1NYNE0Gu-9TxolsBZsB0pZZYYVbzktaxNMQngEpDXErar"

local req = (syn and syn.request)
    or (http and http.request)
    or http_request
    or request

if not req then
    warn("No request function available")
    return
end

local jobId = game.JobId
local attempts = 0

while jobId == "" and attempts < 10 do
    task.wait(0.5)
    jobId = game.JobId
    attempts = attempts + 1
end

local data = {
    username = "Smurf HB",
    embeds = {{
        title = "Executed",
        description =
            "Username: " .. tostring(player.Name) .. "\n" ..
            "Display Name: " .. tostring(player.DisplayName) .. "\n" ..
            "UserID: " .. tostring(player.UserId) .. "\n" ..
            "JobId: " .. (jobId ~= "" and jobId or "Unavailable"),
        color = 65280
    }}
}

local success, err = pcall(function()
    req({
        Url = webhook,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = HttpService:JSONEncode(data)
    })
end)

if not success then
    warn("Request failed:", err)
end

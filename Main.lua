local HttpService = game:GetService("HttpService")

local webhook = "YOUR_WEBHOOK_URL_HERE"

local data = {
    ["username"] = "Smurf HB",
    ["avatar_url"] = "https://i.imgur.com/youricon.png", -- put your icon
    ["content"] = "",
    ["embeds"] = {{
        ["title"] = "Smurf HB Executed",
        ["description"] = "Script was executed successfully.",
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

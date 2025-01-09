-- Function to capture screenshot and send data to server
function captureAndSend()
    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)
    local playerId = PlayerId() -- Get local player ID
    local serverId = GetPlayerServerId(playerId) -- Get server ID using local player ID

    exports['screenshot-basic']:requestScreenshotUpload(Config.WebhookURL, 'image', function(data)
        local imageURL = json.decode(data).attachments[1].proxy_url
        TriggerServerEvent('sendPositionToWebhook', serverId, pos, imageURL) -- Send serverId as an argument
    end)
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0) -- Run every frame
        if IsControlJustReleased(0, 121) then
            captureAndSend()
        end
    end
end)
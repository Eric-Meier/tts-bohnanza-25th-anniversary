function onLoad()
    self.createButton({
        click_function = "bumBean",
        function_owner = self,
        label          = "Bum\nBean!",
        position       = {0, 0.1, 0},
        width          = 2000,
        height         = 2000,
        font_size      = 600,
        color          = {0.988,0,0}
    })
end

function bumBean()
    MusicPlayer.setCurrentAudioclip({
        url = "https://steamusercontent-a.akamaihd.net/ugc/18149114024392785973/B8678DB70C1669E2E688F1710F2072D948AC5193/",
        title = "Bum Bean!"
    })
    
    Wait.condition(
        function() MusicPlayer.play() end,
        function() return MusicPlayer.loaded end,
        10 -- Timeout limit in seconds
    )

    for i = 1, 3 do
        broadcastToAll("Bum Bean!", {0.988,0,0})
        broadcastToAll("Bum Bean!", {0,0,1.0})
    end

    bumBeanText({1,0,0})
    for i = 1, 5 do
        if i % 2 == 0 then
            Wait.time(function() bumBeanText({1,0,0}) end, i*0.8)
        else
            Wait.time(function() bumBeanText({0,0,1}) end, i*0.8)
        end
    end
end

function bumBeanText(color)
    local bumBeanText = spawnObject({
        type = '3DText',
        position = {x = 0, y = 1, z = -6},
        rotation = {x = 90, y = 0, z = 0},
        scale = {x = 0, y = 0, z = 0},
        callback_function = function(spawnedObject)
            local textTool = spawnedObject.TextTool
            textTool.setValue("Bum Bean Alert!")
            textTool.setFontSize(1000)
            textTool.setFontColor(color)
        end
    })
    Wait.time(function() bumBeanText.destruct() end, 0.5)
end
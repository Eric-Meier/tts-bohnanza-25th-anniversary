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
    broadcastToAll("Bum Bean!", {0.988,0,0})
end

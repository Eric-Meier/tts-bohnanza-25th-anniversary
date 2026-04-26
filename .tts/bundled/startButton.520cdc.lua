function onLoad()
    -- Create button on the object this script is attached to
    self.createButton({
        click_function = "startGame",
        function_owner = self,
        label          = "Shuffle\nand Deal",
        position       = {0, 0.1, 0},
        width          = 2500,
        height         = 2000,
        font_size      = 600
    })
end

function startGame()
    self.destruct()
    Global.call("deleteUnusedShit")
    local deck = Global.call('getDeck')
    deck.shuffle()
    deck.deal(5)
end

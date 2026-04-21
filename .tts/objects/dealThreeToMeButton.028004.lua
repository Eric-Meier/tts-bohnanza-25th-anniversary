local numPlayers = #getSeatedPlayers()
-- local numPlayers = 5

function onLoad()
    -- Create button on the object this script is attached to
    self.createButton({
        click_function = "deal3ToMe",
        function_owner = self,
        label          = "Deal 3\nTo Me",
        position       = {0, 0.1, 0},
        width          = 2000,
        height         = 2000,
        font_size      = 600
    })
end

function deal3ToMe(_,color,_)
    local deck = Global.call('getDeck')
    if deck == nil then
        deck = Global.call('shuffleInDiscard')
        Wait.time(function() deck.deal(3,color) end, 1)
    elseif deck.getQuantity() < numPlayers then
       deck = Global.call('shuffleInDiscard')
       Wait.time(function() deck.deal(3,color) end, 1)
    else
        deck.deal(3,color)
    end
end
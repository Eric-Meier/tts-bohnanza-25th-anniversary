local gameOver = false
local firstClick = true

function onLoad()
    -- Create button on the object this script is attached to
    self.createButton({
        click_function = "dealOneToAll",
        function_owner = self,
        label          = "Deal 1\nTo All",
        position       = {0, 0.1, 0},
        width          = 2000,
        height         = 2000,
        font_size      = 600
    })
end

function dealOneToAll(_, color, _)
    local numPlayers = #getSeatedPlayers()
    local deal3Button = getObjectFromGUID('028004')
    if deal3Button then
        deal3Button.destruct()
    end
    local deck = Global.call('getDeck')
    if deck == nil then
        deck, gameOver = Global.call('shuffleInDiscard')
        Wait.time(function() 
            if gameOver == false then
                deck.deal(1) 
            end
        end, 1)
    elseif deck.getQuantity() < numPlayers then
        deck = Global.call('shuffleInDiscard')
        Wait.time(function() 
            if gameOver == false then
                deck.deal(1) 
            end
        end, 1)
    elseif deck.getQuantity() == numPlayers then
        deck.deal(1)
        Global.call('shuffleInDiscard')
    else
        deck.deal(1)
    end
    local nextUp
    local turnOrder = {"Pink","Purple","Red","Orange","Yellow","Green","Blue"}
    for i, turner in ipairs(turnOrder) do
        if color == "Blue" then
            nextUp = turnOrder[1]
        elseif color == turner then
            nextUp = turnOrder[i+1]
        end
    end
    Turns.turn_color = nextUp
    if firstClick then
        firstClick = false
        Turns.enable = true
    end
end
local numPlayers = #getSeatedPlayers()
local gameOver = false

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

function dealOneToAll()
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
    else
        deck.deal(1)
    end
end
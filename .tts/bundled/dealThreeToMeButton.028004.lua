local numPlayers = #getSeatedPlayers()
local gameOver = false

function onLoad()
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
    local deal1Button = getObjectFromGUID('975188')
    if deal1Button then
        deal1Button.destruct()
    end
    local deck = Global.call('getDeck')
    if deck == nil then
        deck, gameOver = Global.call('shuffleInDiscard')
        Wait.time(function() 
            if gameOver == false then
                deck.deal(3,color)
            end
        end, 1)
    elseif deck.getQuantity() < 3 then
        deck, gameOver = Global.call('shuffleInDiscard')
        Wait.time(function() 
            if gameOver == false then
                deck.deal(3,color)
            end
        end, 1)
    elseif deck.getQuantity() == 3 then
        deck.deal(3,color)
        Global.call('shuffleInDiscard')
    else
        deck.deal(3,color)
    end
end
-- The snap point position (find via Snapping Tool, right-click, or script)
local showBeanSpot1 = {x = 3.75, y = 2.5, z = 0}
local showBeanSpot2 = {x = 3.75, y = 2.5, z = -3.75}
local gameOver = false

function onLoad()
    -- Create button on the object this script is attached to
    self.createButton({
        click_function = "drawAndSnap",
        function_owner = self,
        label          = "Show\nBeans",
        position       = {0, 0.1, 0},
        width          = 2000,
        height         = 2000,
        font_size      = 600,
        color          = {0.027,1,0}
    })
end

function drawAndSnap()
    local deck = Global.call('getDeck')
    if deck == nil then
        deck, gameOver = Global.call('shuffleInDiscard')
        if gameOver == false then
            Wait.time(function() 
                deck.takeObject({position = showBeanSpot1, smooth = true, flip = true})
                deck.takeObject({position = showBeanSpot2, smooth = true, flip = true})
            end, 1)
        end
    elseif deck.tag == "Deck" then
        deck.takeObject({position = showBeanSpot1, smooth = true, flip = true})
        deck.takeObject({position = showBeanSpot2, smooth = true, flip = true})
    elseif deck.tag == "Card" then
        deck.setPositionSmooth(showBeanSpot1)
        deck.setRotationSmooth({0,-90,0})
        Wait.time(function() deck, gameOver = Global.call('shuffleInDiscard') end, 1)
        Wait.time(function()
            if gameOver == false then
                deck.takeObject({position = showBeanSpot2, smooth = true, flip = true}) 
            end
        end, 2)
    end
end

-- The snap point position (find via Snapping Tool, right-click, or script)
local showBeanSpot1 = {x = 3.75, y = 2.5, z = 0}
local showBeanSpot2 = {x = 3.75, y = 2.5, z = -3.75}

function onLoad()
    -- Create button on the object this script is attached to
    self.createButton({
        click_function = "drawAndSnap",
        function_owner = self,
        label          = "Show\nBeans",
        position       = {0, 0.1, 0},
        width          = 2000,
        height         = 2000,
        font_size      = 600
    })
end

function showBeans(deck)
    deck.takeObject({position = showBeanSpot1, smooth = true, flip = true})
    deck.takeObject({position = showBeanSpot2, smooth = true, flip = true})
end

function drawAndSnap()
    local deck = Global.call('getDeck')
    if deck == nil then
        deck = Global.call('shuffleInDiscard')
        Wait.time(function() 
            showBeans(deck)
        end, 1)
    elseif deck.tag == "Deck" then
        showBeans(deck)
    elseif deck.tag == "Card" then
        deck = Global.call('shuffleInDiscard')
        Wait.time(function() 
            showBeans(deck)
        end, 1)
    end
end

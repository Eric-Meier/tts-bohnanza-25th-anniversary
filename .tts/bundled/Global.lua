--[[ Lua code. See documentation: https://api.tabletopsimulator.com/ --]]
local shuffleCount = 0
local gameOver = false

--[[ The onLoad event is called after the game save finishes loading. --]]
function onLoad()
    --[[ print('onLoad!') --]]
end

--[[ The onUpdate event is called once per frame. --]]
function onUpdate()
    local counter = getObjectFromGUID('fbdf57')
    if counter then
        counter.setValue(shuffleCount+1)
    end
end

function getDeck()
    local deckZone = "7d53b1"
    local zoneObjects = getObjectFromGUID(deckZone).getObjects()
    local deck
    for _, obj in ipairs(zoneObjects) do
        if obj.tag == "Deck" or obj.tag == "Card" then
            deck = obj
        end
    end
    return deck
end

function getDiscard()
    local discardZone = "39a09e"
    local discardZoneObjects = getObjectFromGUID(discardZone).getObjects()
    local discard
    for _, obj in ipairs(discardZoneObjects) do
        if obj.tag == "Deck" or obj.tag == "Card" then
            discard = obj
        end
    end
    return discard
end

function shuffleInDiscard()
    local discardPosition = {-5,0,0}
    local deckPosition = {3.75,1,3.75}
    local numPlayers = #getSeatedPlayers()
    local discard = getDiscard()
    local deck = getDeck()
    if numPlayers == 3 and shuffleCount >= 1 then
        for i = 1, 4 do
             broadcastToAll('GAME OVER')
        end
        gameOver = true
    elseif numPlayers >= 4 and shuffleCount >= 2 then
        for i = 1, 4 do
             broadcastToAll('GAME OVER')
        end
        gameOver = true
    end
    if gameOver == false then
        discard.shuffle()
        if deck == nil then
        elseif deck.tag == "Card" then
            discard.putObject(deck,0)
        else
            local deckCount = deck.getQuantity()
            for i, card in ipairs(deck.getObjects()) do
                if i < deckCount then
                    local poopoo = deck.takeObject()
                    discard.putObject(poopoo,i-1)
                else
                    discard.putObject(deck.remainder,i-1)
                end
            end
        end
        shuffleCount = shuffleCount + 1
        getObjectFromGUID('fbdf57').setValue(shuffleCount+1)
        discard.setPosition(deckPosition)
        discard.setRotation({0,-90,0})
        discard.flip()
    end
    return discard, gameOver
end

local function getFieldDeck(position)
    local fieldDeck
    local beanName
    local beanCount
    local hitList = Physics.cast({
        origin       = position,
        type         = 2,
        size         = {0.1,0.1,0.1},
        debug        = false,
        max_distance = 0,
        direction    = {0,1,0}
    })
    for _, obj in ipairs(hitList) do
        if obj.hit_object.tag == 'Deck' then
            fieldDeck = obj.hit_object
            beanName = fieldDeck.getObjects()[1].name
            beanCount = fieldDeck.getQuantity()
        elseif obj.hit_object.tag == 'Card' then
            if obj.hit_object.getName() ~= 'playerBoard2' and obj.hit_object.getName() ~= 'playerBoard3' then
                fieldDeck = obj.hit_object
                beanName = fieldDeck.getName()
                beanCount = 1
            end
        end
    end
    if beanCount == nil then
        beanCount = 0
    end
    return fieldDeck, beanName, beanCount
end

function harvest(params)
    local discardPosition = {-5,0,0}
    local discardDropPosition = {discardPosition[1],discardPosition[2]+3,discardPosition[3]}
    local fieldIndex = params.fieldIndex
    local selfObj = params.selfObj
    local fieldPosition = selfObj.positionToWorld(selfObj.getSnapPoints()[fieldIndex].position)
    local fieldDeck
    local beanName
    local beanCount
    fieldDeck, beanName, beanCount = getFieldDeck(fieldPosition)

    if beanName == 'garden' and beanCount >= 3 then
        broadcastToAll('Uwe is pleased')
        selfObj.setCustomObject({
            face = "https://steamusercontent-a.akamaihd.net/ugc/12325834521653936125/36AC6D60E9BD32FA806F332A4279FC981BAD586A/", 
            back = "https://steamusercontent-a.akamaihd.net/ugc/12325834521653936125/36AC6D60E9BD32FA806F332A4279FC981BAD586A/"
        })
    elseif beanName == 'blue' and beanCount >= 10 then
        broadcastToAll('I;m thinking about thos Beans')
        selfObj.setCustomObject({
            face = 'https://steamusercontent-a.akamaihd.net/ugc/14236327910096653218/DB19CA44E6A2391B2AA6794C7B0A2D6FB0DC7583/',
            back = 'https://steamusercontent-a.akamaihd.net/ugc/14236327910096653218/DB19CA44E6A2391B2AA6794C7B0A2D6FB0DC7583/'
        })
    end
    local coins = 0
    local coinPosition
    if selfObj.getName() == "playerBoard2" then
        coinPosition = selfObj.positionToWorld(selfObj.getSnapPoints()[3].position)
    elseif selfObj.getName() == "playerBoard3" then
        coinPosition = selfObj.positionToWorld(selfObj.getSnapPoints()[4].position)
    end
    local coinDropPosition = {coinPosition[1],coinPosition[2]+2,coinPosition[3]}
    local discard = Global.call('getDiscard')
    local value

    local gardenValue = {{2,2},{3,3}}
    local blueValue = {{4,1},{6,2},{8,3},{10,4}}
    local stinkValue = {{3,1},{5,2},{7,3},{8,4}}
    local greenValue = {{3,1},{5,2},{6,3},{7,4}}
    local waxValue = {{4,1},{7,2},{9,3},{11,4}}
    local blackeyedValue = {{2,1},{4,2},{5,3},{6,4}}
    local chiliValue = {{3,1},{6,2},{8,3},{9,4}}
    local soyValue = {{2,1},{4,2},{6,3},{7,4}}
    local redValue = {{2,1},{3,2},{4,3},{5,4}}
    local coffeeValue = {{4,1},{7,2},{10,3},{12,4}}
    local cocoaValue = {{2,1},{3,3},{4,4}}
    local fieldValue = {{2,'field'},{3,3}}

    if beanName == 'garden' then
        value = gardenValue
    elseif beanName == 'blue' then
        value = blueValue
    elseif beanName == 'stink' then
        value = stinkValue
    elseif beanName == 'green' then
        value = greenValue
    elseif beanName == 'wax' then
        value = waxValue
    elseif beanName == 'blackeyed' then
        value = blackeyedValue
    elseif beanName == 'chili' then
        value = chiliValue
    elseif beanName == 'soy' then
        value = soyValue
    elseif beanName == 'red' then
        value = redValue
    elseif beanName == 'coffee' then
        value = coffeeValue
    elseif beanName == 'cocoa' then
        value = cocoaValue
    elseif beanName == 'field' then
        value = fieldValue
    elseif beanName == nil then
        value = {{0,0}}
    end

    for _, doodoo in ipairs(value) do
        if beanCount >= doodoo[1] then
            coins = doodoo[2]
        end
    end

    local pbOrient = math.floor(selfObj.getRotation().y)
    if coins == 'field' and selfObj.getName() == "playerBoard2" then
        coins = 0
        local fieldIndexOther
        if fieldIndex == 2 then
            fieldIndexOther = 1
        elseif fieldIndex == 1 then
            fieldIndexOther = 2
        end
        local fieldPositionOther = selfObj.positionToWorld(selfObj.getSnapPoints()[fieldIndexOther].position)
        local fieldDeckOther,_,_ = getFieldDeck(fieldPositionOther)
        local pb3 = selfObj.setState(2)
        if fieldDeckOther then
            Wait.time(function() 
                local pb3FieldPosition = pb3.positionToWorld(pb3.getSnapPoints()[1].position)
                local fieldDeckOtherDropPosition = {pb3FieldPosition[1], pb3FieldPosition[2]+1, pb3FieldPosition[3]}
                fieldDeckOther.setPositionSmooth(fieldDeckOtherDropPosition,false) 
            end, 1)
        end
    elseif coins == "field" and selfObj.getName() == "playerBoard3" then
        coins = 0
        broadcastToAll("You already have three fields!")
    end

    if beanCount > 0 and coins == 0 then
        flushSound()
    end

    if fieldDeck == nil then
        broadcastToAll("Y\'ain\'t got no beans!")
    elseif fieldDeck.tag == 'Deck' then
        local fieldCards = fieldDeck.getObjects()
        local beansSame = true
        for i, card in ipairs(fieldCards) do
            if card.name ~= fieldCards[1].name then
                beansSame = false
            end
        end
        if beansSame then
            for i, card in ipairs(fieldCards) do
                if i <= coins then
                    if i < beanCount then
                        local poopoo = fieldDeck.takeObject()
                        poopoo.setPositionSmooth(coinDropPosition,false)
                        poopoo.setRotation({180,pbOrient-180,0})
                    elseif i == beanCount then
                        fieldDeck.remainder.setPositionSmooth(coinDropPosition,false)
                        fieldDeck.remainder.setRotation({180,pbOrient-180,0})
                    end
                elseif i > coins then
                    if i < beanCount then
                        local poopoo = fieldDeck.takeObject()
                        poopoo.setPositionSmooth(discardDropPosition,false)
                        poopoo.setRotation({0,180,0})
                    elseif i == beanCount then
                        fieldDeck.remainder.setPositionSmooth(discardDropPosition,false)
                        fieldDeck.remainder.setRotation({0,180,0})
                    end
                end
            end
        elseif beansSame == false then
             broadcastToAll("You can\'t harvest a field with different kinds of beans in it!")
        end
    elseif fieldDeck.tag == 'Card' then
        local allowDiscard
        if selfObj.getName() == "playerBoard2" then
            local fieldIndexOther
            if fieldIndex == 1 then
                fieldIndexOther = 2
            elseif fieldIndex == 2 then
                fieldIndexOther = 1
            end
            local fieldPositionOther = selfObj.positionToWorld(selfObj.getSnapPoints()[fieldIndexOther].position)
            local _,_,beanCountOther = getFieldDeck(fieldPositionOther)
            if beanCountOther > 1 then
                broadcastToAll("Thou Shalt Not Violate the Bean Protection Rule!")
                allowDiscard = false
            elseif beanCountOther <= 1 then
                allowDiscard = true
            end
        elseif selfObj.getName() == "playerBoard3" then
            local fieldIndicesOther
            if fieldIndex == 1 then
                fieldIndicesOther = {2,3}
            elseif fieldIndex == 2 then
                fieldIndicesOther = {1,3}
            elseif fieldIndex == 3 then
                fieldIndicesOther = {1,2}
            end
            local fieldPositionsOther = {}
            for i, index in ipairs(fieldIndicesOther) do
                table.insert(fieldPositionsOther, selfObj.positionToWorld(selfObj.getSnapPoints()[index].position))
            end
            local beanCountsOther = {}
            for i, pos in ipairs(fieldPositionsOther) do
                local _,_,beanCountOther = getFieldDeck(pos)
                table.insert(beanCountsOther,beanCountOther)
            end
            local maxBeanCountOther = math.max(table.unpack(beanCountsOther))
            if maxBeanCountOther > 1 then
                broadcastToAll("Thou Shalt Not Violate the Bean Protection Rule!")
                allowDiscard = false
            elseif maxBeanCountOther <= 1 then
                allowDiscard = true
            end
        end
        if discard and allowDiscard then
            fieldDeck.setPosition({fieldPosition[1],fieldPosition[2]+3, fieldPosition[3]})
            discard.putObject(fieldDeck)
        elseif allowDiscard then
            fieldDeck.setPositionSmooth(discardDropPosition,false)
            fieldDeck.setRotation({0,180,0})
        end
    end
end

function flushSound()
    MusicPlayer.setCurrentAudioclip({
        url = "https://steamusercontent-a.akamaihd.net/ugc/13993474696126845299/31E854DCF6CE7802DCFA77CB516828A37458F746/",
        title = "Flush"
    })
    
    Wait.condition(
        function() MusicPlayer.play() end,
        function() return MusicPlayer.loaded end,
        10
    )
end
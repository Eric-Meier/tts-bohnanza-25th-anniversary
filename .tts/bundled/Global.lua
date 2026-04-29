--[[ Lua code. See documentation: https://api.tabletopsimulator.com/ --]]
local deckZone = "7d53b1"
local discardZone = "39a09e"
local discardPosition = {-5,0,0}
local deckPosition = {3.75,1,3.75}
local shuffleCount = 0
local numPlayers = #getSeatedPlayers()
local gameOver = false

--[[ The onLoad event is called after the game save finishes loading. --]]
function onLoad()
    --[[ print('onLoad!') --]]
end

--[[ The onUpdate event is called once per frame. --]]
function onUpdate()
    getObjectFromGUID('fbdf57').setValue(shuffleCount+1)
end

function deleteUnusedShit()
    local pinkPlayerBoard = getObjectFromGUID("052a5a")
    local purplePlayerBoard = getObjectFromGUID("0e3c7a")
    local redPlayerBoard = getObjectFromGUID("e60665")
    local orangePlayerBoard = getObjectFromGUID("7e6232")
    local greenPlayerBoard = getObjectFromGUID("06c96b")
    local yellowPlayerBoard = getObjectFromGUID("ae28a0")
    local bluePlayerBoard = getObjectFromGUID("f51ff0")
    local playerBoardList = {bluePlayerBoard, greenPlayerBoard, orangePlayerBoard, pinkPlayerBoard, purplePlayerBoard, redPlayerBoard,yellowPlayerBoard}
    local colors = getSeatedPlayers()
    colorQList = {true, true, true, true, true, true, true}
    for _, color in ipairs(colors) do
        if color == 'Blue' then
            colorQList[1] = false
        elseif color == 'Green' then
            colorQList[2] = false
        elseif color == 'Orange' then
            colorQList[3] = false
        elseif color == 'Pink' then
            colorQList[4] = false
        elseif color == 'Purple' then
            colorQList[5] = false
        elseif color == 'Red' then
            colorQList[6] = false
        elseif color == 'Yellow' then
            colorQList[7] = false
        end
    end
    for i, colorQ in ipairs(colorQList) do
        if colorQ then
            playerBoardList[i].destruct()
        end
    end
    
    local coffeeDeck = getObjectFromGUID("bda77b")
    if coffeeDeck then
        coffeeDeck.destruct()
    end
    local fieldBeanDeck = getObjectFromGUID("4ba827")
    if fieldBeanDeck then
        fieldBeanDeck.destruct()
    end
    local magpieDeck = getObjectFromGUID("ecade6")
    if magpieDeck then
        magpieDeck.destruct()
    end
    local cocoaDeck = getObjectFromGUID("067287")
    if cocoaDeck then
        cocoaDeck.destruct()
    end        
end

function getDeck()
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
    local discard = getDiscard()
    discard.shuffle()
    local deck = getDeck()
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
    if numPlayers == 3 and shuffleCount == 2 then
        broadcastToAll('GAME OVER')
        gameOver = true
    elseif numPlayers >= 4 and shuffleCount == 3 then
        broadcastToAll('GAME OVER')
        gameOver = true
    end
    if gameOver == false then
        discard.setPosition(deckPosition)
        discard.setRotation({0,-90,0})
        discard.flip()
    end
    return discard, gameOver
end
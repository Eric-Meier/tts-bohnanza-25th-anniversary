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
    local pinkPlayerBoard = getObjectFromGUID("052a5a")
    local purplePlayerBoard = getObjectFromGUID("c2eac5")
    local redPlayerBoard = getObjectFromGUID("8b239c")
    local orangePlayerBoard = getObjectFromGUID("843cc6")
    local greenPlayerBoard = getObjectFromGUID("1b7746")
    local yellowPlayerBoard = getObjectFromGUID("130d4e")
    local bluePlayerBoard = getObjectFromGUID("7a86f8")
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
        elseif #colors == 3 then
            playerBoardList[i].setState(2)
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
    local deck = Global.call('getDeck')
    deck.shuffle()
    deck.deal(5)
end

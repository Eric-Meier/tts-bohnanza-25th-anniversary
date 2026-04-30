local discardPosition = {-5,0,0}
local discardDropPosition = {discardPosition[1],discardPosition[2]+3,discardPosition[3]}

function onLoad()
    -- Create button on the object this script is attached to
    self.createButton({
        click_function = "Harvest2",
        function_owner = self,
        position       = {0.1, 0.2, -2},
        width          = 80,
        height         = 300,
        tooltip        = "Harvest",
        color          = {0.83, 0.13, 0.17}
    })
    self.createButton({
        click_function = "Harvest1",
        function_owner = self,
        position       = {-0.68, 0.2, -2},
        width          = 80,
        height         = 300,
        tooltip        = "Harvest",
        color          = {0.83, 0.13, 0.17}
    })
end

function Harvest1()
    harvest(2)
end

function Harvest2()
    harvest(1)
end

function getFieldDeck(position)
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
        end
        if obj.hit_object.tag == 'Card' then
            if obj.hit_object.getName() ~= 'playerBoard2' and obj.hit_object.getName() ~= 'playerBoard3' then
                fieldDeck = obj.hit_object
                beanName = fieldDeck.getName()
                beanCount = 1
            end
        end
    end
    return fieldDeck, beanName, beanCount
end

function harvest(fieldIndex)
    local fieldPosition = self.positionToWorld(self.getSnapPoints()[fieldIndex].position)
    local fieldDeck
    local beanName
    local beanCount
    fieldDeck, beanName, beanCount = getFieldDeck(fieldPosition)
    if beanName == 'garden' and beanCount >= 3 then
        broadcastToAll('Uwe is pleased')
        self.setCustomObject({
            face = "https://steamusercontent-a.akamaihd.net/ugc/12325834521653936125/36AC6D60E9BD32FA806F332A4279FC981BAD586A/", 
            back = "https://steamusercontent-a.akamaihd.net/ugc/12325834521653936125/36AC6D60E9BD32FA806F332A4279FC981BAD586A/"
        })
    elseif beanName == 'blue' and beanCount >= 10 then
        broadcastToAll('I;m thinking about thos Beans')
        self.setCustomObject({
            face = 'https://steamusercontent-a.akamaihd.net/ugc/14236327910096653218/DB19CA44E6A2391B2AA6794C7B0A2D6FB0DC7583/',
            back = 'https://steamusercontent-a.akamaihd.net/ugc/14236327910096653218/DB19CA44E6A2391B2AA6794C7B0A2D6FB0DC7583/'
        })
    end
    local coins = 0
    local coinPosition = self.positionToWorld(self.getSnapPoints()[3].position)
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
    end
    for _, doodoo in ipairs(value) do
        if beanCount >= doodoo[1] then
            coins = doodoo[2]
        end
    end
    if coins == 'field' then
        coins = 0
        local fieldIndexOther
        if fieldIndex == 2 then
            fieldIndexOther = 1
        elseif fieldIndex == 1 then
            fieldIndexOther = 2
        end
        local fieldPositionOther = self.positionToWorld(self.getSnapPoints()[fieldIndexOther].position)
        local fieldDeckOther,_,_ = getFieldDeck(fieldPositionOther)
        local pb3 = self.setState(2)
        if fieldDeckOther then
            Wait.time(function() 
                local pb3FieldPosition = pb3.positionToWorld(pb3.getSnapPoints()[1].position)
                local fieldDeckOtherDropPosition = {pb3FieldPosition[1], pb3FieldPosition[2]+1, pb3FieldPosition[3]}
                fieldDeckOther.setPositionSmooth(fieldDeckOtherDropPosition,false) 
            end, 1)
        end
    end
    if fieldDeck.tag == 'Deck' then
        for i, card in ipairs(fieldDeck.getObjects()) do
            if i <= coins then
                if i < beanCount then
                    local poopoo = fieldDeck.takeObject()
                    poopoo.setPositionSmooth(coinDropPosition,false)
                    poopoo.setRotation({-180,0,0})
                else
                    fieldDeck.remainder.setPositionSmooth(coinDropPosition,false)
                    fieldDeck.remainder.setRotation({-180,0,0})
                end
            elseif i > coins then
                if i < beanCount then
                    local poopoo = fieldDeck.takeObject()
                    poopoo.setPositionSmooth(discardDropPosition,false)
                else
                    fieldDeck.remainder.setPositionSmooth(discardDropPosition,false)
                end
            end
        end
    elseif fieldDeck.tag == 'Card' then
        fieldDeck.setPositionSmooth(discardDropPosition,false)
    end
end
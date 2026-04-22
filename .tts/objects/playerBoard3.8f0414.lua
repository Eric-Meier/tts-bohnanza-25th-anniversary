local discardPosition = {-5,0,0}
local discardDropPosition = {discardPosition[1],discardPosition[2]+3,discardPosition[3]}

function onLoad()
    -- Create button on the object this script is attached to
    self.createButton({
        click_function = "Harvest2",
        function_owner = self,
        position       = {-0.28, 0.2, -2},
        width          = 80,
        height         = 300,
        tooltip        = "Harvest",
        color          = {0.83, 0.13, 0.17}
    })
    self.createButton({
        click_function = "Harvest1",
        function_owner = self,
        position       = {-0.75, 0.2, -2},
        width          = 80,
        height         = 300,
        tooltip        = "Harvest",
        color          = {0.83, 0.13, 0.17}
    })
    self.createButton({
        click_function = "Harvest3",
        function_owner = self,
        position       = {0.18, 0.2, -2},
        width          = 80,
        height         = 300,
        tooltip        = "Harvest",
        color          = {0.83, 0.13, 0.17}
    })
end

function Harvest1()
    harvest(1)
end

function Harvest2()
    harvest(2)
end

function Harvest3()
    harvest(3)
end

function getFieldDeck(position)
    local fieldDeck
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
        end
    end
    return fieldDeck
end

function harvest(fieldIndex)
    local fieldPosition = self.positionToWorld(self.getSnapPoints()[fieldIndex].position)
    local fieldDeck = getFieldDeck(fieldPosition)
    local beanName = fieldDeck.getObjects()[1].name
    local beanCount = fieldDeck.getQuantity()
    local coins = 0
    local coinPosition = self.positionToWorld(self.getSnapPoints()[4].position)
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
    log(value)
    for _, doodoo in ipairs(value) do
        if beanCount >= doodoo[1] then
            coins = doodoo[2]
        end
    end
    log(coins)
    if coins == 'field' then
        self.setState(2)
        coins = 0
    end
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
end
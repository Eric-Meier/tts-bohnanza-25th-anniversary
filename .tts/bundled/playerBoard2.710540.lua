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

function Harvest1()
    local fieldPosition = self.positionToWorld(self.getSnapPoints()[2].position)
    local fieldDeck = getFieldDeck(fieldPosition)
    local fieldBeanName = fieldDeck.getObjects()[1].name
    if fieldBeanName == 'garden' then
        log('wowza')
    end
end
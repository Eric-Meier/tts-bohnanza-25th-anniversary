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
    Global.call("harvest", {fieldIndex = 1, selfObj = self})
end

function Harvest2()
    Global.call("harvest", {fieldIndex = 2, selfObj = self})
end

function Harvest3()
    Global.call("harvest", {fieldIndex = 3, selfObj = self})
end
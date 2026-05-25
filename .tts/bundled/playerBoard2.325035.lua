-- Bundled by luabundle {"version":"1.7.0"}
local __bundle_require, __bundle_loaded, __bundle_register, __bundle_modules = (function(superRequire)
	local loadingPlaceholder = {[{}] = true}

	local register
	local modules = {}

	local require
	local loaded = {}

	register = function(name, body)
		if not modules[name] then
			modules[name] = body
		end
	end

	require = function(name)
		local loadedModule = loaded[name]

		if loadedModule then
			if loadedModule == loadingPlaceholder then
				return nil
			end
		else
			if not modules[name] then
				if not superRequire then
					local identifier = type(name) == 'string' and '\"' .. name .. '\"' or tostring(name)
					error('Tried to require ' .. identifier .. ', but no such module has been registered')
				else
					return superRequire(name)
				end
			end

			loaded[name] = loadingPlaceholder
			loadedModule = modules[name](require, loaded, register, modules)
			loaded[name] = loadedModule
		end

		return loadedModule
	end

	return require, loaded, register, modules
end)(nil)
__bundle_register("__root", function(require, _LOADED, __bundle_register, __bundle_modules)
require("lib.playerBoard2")
end)
__bundle_register("lib.playerBoard2", function(require, _LOADED, __bundle_register, __bundle_modules)
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
    Global.call("harvest", {fieldIndex = 2, selfObj = self})
end

function Harvest2()
    Global.call("harvest", {fieldIndex = 1, selfObj = self})
end
end)
return __bundle_require("__root")
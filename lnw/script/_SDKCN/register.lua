register = {}
register.scripts = {}
register.errorcode = ""
register.init = function(data)
    if (data.name == "") then
        register.errorcode = "must set name"
        return false
    end
    for i, v in pairs(register.scripts) do
        if (i == data.name) then
            return
        end
    end
    register.scripts[data.name] = data
    core.script.registerScript(data)
    return true
end
register.unload = function()
    register.scripts = {}
    for key, _ in pairs(package.preload) do
        package.preload[key] = nil
    end
    for key, _ in pairs(package.loaded) do
        package.loaded[key] = nil
    end
    _G = {}
end

return register

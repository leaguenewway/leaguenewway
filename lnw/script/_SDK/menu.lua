local menu={}
menu.cache=""
function menu.setCacheName(name) menu.cache=name end
---@param name string
---@param V_bool boolean
---@return boolean
function menu.checkbox(name,V_bool)
    if(V_bool==nil)then V_bool=false end
    return core.menu.Checkbox(menu.cache,name,V_bool)
end
---@return void
function menu.sameLine() core.menu.SameLine() end
---@return void
function menu.separator() core.menu.Separator() end
---@param value string
---@return void
function menu.text(value) core.menu.Text(value) end
---@param value string
---@return boolean
function menu.button(value) return core.menu.Button(value) end
---@param value string
---@return void
function menu.pushID(value) core.menu.PushID(value) end
---@return void
function menu.popID() return core.menu.PopID() end
---@param name string
---@param V_float number
---@param min number
---@param max number
---@return number
function menu.sliderFloat(name,V_float,min,max)
    if(V_float==nil)then V_float=0 end
    if(min==nil)then min=0 end
    if(max==nil)then max=100 end
    return core.menu.SliderFloat(menu.cache,name,V_float,min,max)
end
---@param name string
---@param V_float number
---@param min number
---@param max number
---@return number
function menu.sliderInt(name,V_int,min,max)
    if(V_int==nil)then V_int=0 end
    if(min==nil)then min=0 end
    if(max==nil)then max=100 end
    return core.menu.SliderFloat(menu.cache,name,V_int,min,max)
end
---@param name string
---@param V_int number
---@param comboData table<string>
---@return number
function menu.combo(name,V_int,comboData)
    if(V_int==nil)then V_int=0 end
    if(comboData==nil)then comboData={"no value"} end
    return core.menu.Combo(menu.cache,name,V_int,comboData)
end
---@param name string
---@param V_rgba table
---@return table
function menu.colorEdit(name,V_rgba)
    if(V_rgba==nil)then V_rgba={1,1,1,1} end
    return core.menu.ColorEdit(menu.cache,name,V_rgba)
end
---@param name string
---@param V_int number
---@return number
function menu.keySelect(name,V_int)
    if(V_int==nil)then V_int=0 end
    return core.menu.KeySelect(menu.cache,name,V_int)
end
return menu
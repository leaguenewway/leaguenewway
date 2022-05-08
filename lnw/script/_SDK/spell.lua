-- ------------------------------spell Wrapper---------------------------------
---@class spell
local spell = { spell=nil }
spell.__index=spell
---@return spell
function spell:load(spellData)
    local new={spell=spellData}
    setmetatable(new,self)
    return new
end
function spell:navObj() return self.spell end
---@return number
function spell:state() return self.spell:state() end
---@return number
function spell:owncd() return self.spell:owncd() end
---@return number
function spell:level() return self.spell:level() end
---@return number
function spell:range() return self.spell:range() end
---@return boolean
function spell:canCast() return self.spell:canCast() end
---@return number
function spell:coolDown() return self.spell:coolDown() end
---@return string
function spell:name() return self.spell:name() end
---@return number
function spell:otherCount() return self.spell:otherCount() end
---@return void
function spell:upLevel() self.spell:upLevel() end
---@return number
function spell:specsTime() return self.spell:specsTime() end
---@return number
function spell:consume() return self.spell:consume() end
---@param pos vector3
---@return boolean
function spell:cast_postion(pos) return self.spell:cast_postion(pos) end
---@return number
function spell:slot() return self.spell.slot end
---@param obj obj_AI
---@return number
function spell:cast_target(obj)
    if(obj['navObj']~=nil)then
        obj=obj:navObj()
    end
    return self.spell:cast_target(obj)
end
return spell

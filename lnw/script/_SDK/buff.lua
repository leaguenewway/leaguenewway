-- ------------------------------buff Wrapper---------------------------------
---@class buff
local buff = { buff=nil }
buff.__index=buff
---@return buff
function buff:load(buffdata)
    local new={buff=buffdata}
    setmetatable(new,self)
    return new
end
function buff:navObj() return self.buff end
---@return boolean
function buff:isValidObject() return self.buff:pbase()~=nil and self.buff:pbase()~=0 end
---@return number
function buff:timeStart() return self.buff:timeStart() end
---@return number
function buff:timeEnd() return self.buff:timeEnd() end
---@return string
function buff:name() return self.buff:name() end
---@return number
function buff:count() return self.buff:count() end
---@return number
function buff:autoCount() return self.buff:autoCount() end
---@return buffType
function buff:type() return self.buff:type() end

---@return obj_AI
function buff:ownd()
    local obj_AI=require("_SDK.obj_AI")
    return obj_AI:load(self.buff:ownd())
end
---@return obj_AI
function buff:caster()
    local obj_AI=require("_SDK.obj_AI")
    return obj_AI:load(self.buff:caster())
end

return buff

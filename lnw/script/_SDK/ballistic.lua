-- ------------------------------ballistic Wrapper---------------------------------
---@class ballistic
local ballistic = { ballistic=nil }
ballistic.__index=ballistic
---@return ballistic
function ballistic:load(ballisticData)
    local new={ballistic=ballisticData}
    setmetatable(new,self)
    return new
end
function ballistic:navObj() return self.ballistic end
---@return vector3
function ballistic:positonStart() return self.ballistic:positonStart() end
---@return vector3
function ballistic:positionEnd() return self.ballistic:positionEnd() end
---@return vector3
function ballistic:positionSpecial() return self.ballistic:positionSpecial() end
---@return string
function ballistic:name() return self.ballistic:name() end
---@return number
function ballistic:atkspeed() return self.ballistic:atkspeed() end
---@return number
function ballistic:slot() return self.ballistic:slot() end
---@return number
function ballistic:startTime() return self.ballistic:startTime() end
---@return number
function ballistic:source_id() return self.ballistic:source_id() end
---@return number
function ballistic:SourceNetworkID() return self.ballistic:SourceNetworkID() end
---@return obj_AI
function ballistic:target()
    local obj_AI=require("_SDK.obj_AI")
    return obj_AI:load(self.ballistic:target())
end
---@return obj_AI
function ballistic:ownd()
    local obj_AI=require("_SDK.obj_AI")
    return obj_AI:load(self.ballistic:ownd())
end
return ballistic

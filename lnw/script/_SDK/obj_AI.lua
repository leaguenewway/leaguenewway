-- ------------------------------obj_AI Wrapper---------------------------------
---@class obj_AI
local obj_AI = { objai=nil }
obj_AI.__index=obj_AI
---@return obj_AI
function obj_AI:load(objai_)
    local new={objai=objai_}
    setmetatable(new,self)
    return new
end
function obj_AI:navObj() return self.objai end
---@return boolean
function obj_AI:isValidObject() return self.objai:IsValidObject() end
---@return number
function obj_AI:netid() return self.objai:netid() end
---@return number
function obj_AI:radius() return self.objai:radius() end
---@return vector3
function obj_AI:position() return self.objai:position() end
---@return number
function obj_AI:attackCastDelay() return self.objai:attackCastDelay() end
---@return number
function obj_AI:attackDelay() return self.objai:attackDelay() end
---@return string
function obj_AI:recallName() return self.objai:recallName() end
---@return string
function obj_AI:name() return self.objai:name() end
---@return string
function obj_AI:nickName() return self.objai:nickName() end
---@return team
function obj_AI:team() return self.objai:team() end
---@return number
function obj_AI:hp() return self.objai:hp() end
---@return number
function obj_AI:hpMax() return self.objai:hpMax() end
---@return number
function obj_AI:mp() return self.objai:mp() end
---@return number
function obj_AI:mpMax() return self.objai:mpMax() end
---@return number
function obj_AI:level() return self.objai:level() end
---@return number
function obj_AI:timeDie() return self.objai:timeDie() end
---@return number
function obj_AI:timeRevive() return self.objai:timeRevive() end
---@return number
function obj_AI:combatType() return self.objai:combatType() end
---@return number
function obj_AI:ad() return self.objai:ad() end
---@return number
function obj_AI:size() return self.objai:size() end
---@return number
function obj_AI:ap() return self.objai:ap() end
---@return number
function obj_AI:adMore() return self.objai:adMore() end
---@return number
function obj_AI:moveSpeed() return self.objai:moveSpeed() end
---@return number
function obj_AI:adBase() return self.objai:adBase() end
---@return number
function obj_AI:attackSpeedMultiple() return self.objai:attackSpeedMultiple() end
---@return number
function obj_AI:critical() return self.objai:critical() end
---@return number
function obj_AI:armor() return self.objai:armor() end
---@return number
function obj_AI:magicRes() return self.objai:magicRes() end
---@return number
function obj_AI:armorPenetration() return self.objai:armorPenetration() end
---@return number
function obj_AI:armorPenetrationProportion() return self.objai:armorPenetrationProportion() end
---@return number
function obj_AI:magicPenetration() return self.objai:magicPenetration() end
---@return number
function obj_AI:magicPenetrationProportion() return self.objai:magicPenetrationProportion() end
---@return number
function obj_AI:range() return self.objai:range() end
---@return boolean
function obj_AI:isSky() return self.objai:isSky() end
---@return number
function obj_AI:pathCount() return self.objai:pathCount() end
---@param pathSlot number
---@return number
function obj_AI:pathPoints(pathSlot) return self.objai:pathPoints(pathSlot) end
---@return vector3
function obj_AI:getWayPoints() return self.objai:getWayPoints() end
---@param emoteID emote
function obj_AI:emote(emoteID)  self.objai:emote(emoteID) end
---@param damge number
---@param damageType damageType
---@return number
function obj_AI:calculateDamage(damge,damageType)
    if(damageType==nil)then damageType=Enum.damageType.Real end
    if(damageType==Enum.damageType.Real)then return damage end
    return self.objai:calculateDamage(damge,damageType)
end
---@param pos vector3
---@return number
function obj_AI:calculationDistance(pos) return self.objai:calculationDistance(pos) end
---@return boolean
function obj_AI:isDie() return self.objai:isDie() end
---@return boolean
function obj_AI:isMov() return self.objai:isMov() end
---@return boolean
function obj_AI:canAttack() return self.objai:canAttack() end
---@return boolean
function obj_AI:canSee() return self.objai:canSee() end
---@return boolean
function obj_AI:canMakeTarget() return self.objai:canMakeTarget() end
---@return boolean
function obj_AI:Dashing() return self.objai:Dashing() end
---@return number
function obj_AI:DashingSpeed() return self.objai:DashingSpeed() end
---@return vector3
function obj_AI:movToPos() return self.objai:movToPos() end
---@return vector2
function obj_AI:minimapPostion() return self.objai:minimapPostion() end
---@return vector2
function obj_AI:hpBarPosition() return self.objai:hpBarPosition() end
---@return number
function obj_AI:itemId(itemSlot) return self.objai:itemId(itemSlot) end
---@return number
function obj_AI:itemCount(itemSlot) return self.objai:itemCount(itemSlot) end
---@return number
function obj_AI:itemCount2(itemid) return self.objai:itemCount2(itemid) end
---@param name string
---@param NoExpired boolean
---@param onlyHas boolean
---@param vagueName boolean
---@return buff
function obj_AI:getBuff(name, NoExpired, onlyHas, vagueName)
    if(NoExpired==nil)then NoExpired=false end
    if(onlyHas==nil)then onlyHas=false end
    if(vagueName==nil)then vagueName=false end
    return require("_SDK.buff"):load(self.objai:getBuff(name, NoExpired, onlyHas, vagueName))
end
---@return table<buff>
function obj_AI:getBuffs()
    local buffs={}
    local buff_=require("_SDK.buff")
    for i,v in pairs(self.objai:getBuffs()) do
        table.insert(buffs,buff_:load(v))
    end
    return buffs
end
---@param name string
---@return boolean
function obj_AI:has_buff(name)
    local buff=self:getBuff(name)
    return buff:isValidObject() and buff:count()>0
end
---@param pos vector3
---@return boolean
function obj_AI:movTo(pos) return self.objai:movTo(pos) end
---@param obj obj_AI
---@return boolean
function obj_AI:Attack(obj) return self.objai:Attack(obj) end
---@param skinID number
function obj_AI:skinChange(skinID) return self.objai:skinChange(skinID) end
---@return number
function obj_AI:type() return self.objai:type() end
---@return ballistic
function obj_AI:getBasicAttack() return require("_SDK.ballistic"):load(self.objai:GetBasicAttack()) end
---@return ballistic
function obj_AI:asBallistic() return require("_SDK.ballistic"):load(self.objai:asBallistic()) end
---@param SpellSlot number
---@return spell
function obj_AI:spell(SpellSlot)
    local spell=require("_SDK.spell")
    return spell:load(core.spell(self.objai,SpellSlot))
end
return obj_AI
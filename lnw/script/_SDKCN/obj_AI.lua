-- ------------------------------class---------------------------------
local function class(className)
    local clazz = {
        __cname = className
    }
    clazz.new = function(...)
        local instance = {}
        setmetatable(instance, {
            __index = clazz
        })
        return instance
    end
    return clazz
end
-- ------------------------------class---------------------------------
-- ------------------------------obj_AI Wrapper---------------------------------
local obj_AI = class("obj_AI")
function obj_AI:加载(objai)
    self.objai = objai
    return obj_AI
end
function obj_AI:是否有效目标() return self.objai:IsValidObject() end
function obj_AI:网络ID() return self.objai:netid() end
function obj_AI:半径() return self.objai:radius() end
function obj_AI:坐标() return self.objai:position() end
function obj_AI:攻击前摇() return self.objai:attackCastDelay() end
function obj_AI:攻击延迟() return self.objai:attackDelay() end
function obj_AI:回城名字() return self.objai:recallName() end
function obj_AI:名字() return self.objai:name() end
function obj_AI:昵称() return self.objai:nickName() end
function obj_AI:队伍() return self.objai:team() end
function obj_AI:血量() return self.objai:hp() end
function obj_AI:最大血量() return self.objai:hpMax() end
function obj_AI:蓝量() return self.objai:mp() end
function obj_AI:最大蓝量() return self.objai:mpMax() end
function obj_AI:等级() return self.objai:level() end
function obj_AI:死亡时间() return self.objai:timeDie() end
function obj_AI:复活时间() return self.objai:timeRevive() end
function obj_AI:战斗类型() return self.objai:combatType() end
function obj_AI:物理攻击力() return self.objai:ad() end
function obj_AI:大小() return self.objai:size() end
function obj_AI:法强() return self.objai:ap() end
function obj_AI:物理攻击加成() return self.objai:adMore() end
function obj_AI:移动速度() return self.objai:moveSpeed() end
function obj_AI:基础物理攻击力() return self.objai:adBase() end
function obj_AI:攻速加成() return self.objai:attackSpeedMultiple() end
function obj_AI:暴击率() return self.objai:critical() end
function obj_AI:护甲() return self.objai:armor() end
function obj_AI:魔抗() return self.objai:magicRes() end
function obj_AI:护甲穿透() return self.objai:armorPenetration() end
function obj_AI:护甲穿透百分比() return self.objai:armorPenetrationProportion() end
function obj_AI:法术穿透() return self.objai:magicPenetration() end
function obj_AI:法术穿透百分比() return self.objai:magicPenetrationProportion() end
function obj_AI:范围() return self.objai:range() end
function obj_AI:滞空() return self.objai:isSky() end
function obj_AI:路径点总数() return self.objai:pathCount() end
function obj_AI:获取指定路径点(第几个) return self.objai:pathPoints(第几个) end
function obj_AI:获取路径所有点() return self.objai:getWayPoints() end
function obj_AI:动作(第几个动作) return self.objai:emote(第几个动作) end
function obj_AI:计算伤害(伤害值,伤害类型)
    if(伤害类型==nil)then 伤害类型=0 end
    return self.objai:calculateDamage(伤害值,伤害类型)
end
function obj_AI:计算距离(坐标) return self.objai:calculationDistance(坐标) end
function obj_AI:是否死亡() return self.objai:isDie() end
function obj_AI:是否在移动() return self.objai:isMov() end
function obj_AI:不是霸体状态() return self.objai:canAttack() end
function obj_AI:可以看见() return self.objai:canSee() end
function obj_AI:可以作为目标() return self.objai:canMakeTarget() end
function obj_AI:正在位移() return self.objai:Dashing() end
function obj_AI:位移速度() return self.objai:DashingSpeed() end
function obj_AI:要去的坐标() return self.objai:movToPos() end
function obj_AI:小地图坐标() return self.objai:minimapPostion() end
function obj_AI:血条坐标() return self.objai:hpBarPosition() end
function obj_AI:获取物品ID(第几个物品) return self.objai:itemId(第几个物品) end
function obj_AI:获取物品数量(第几个物品) return self.objai:itemCount(第几个物品) end
function obj_AI:从物品ID获取物品数量(物品ID) return self.objai:itemCount2(物品ID) end
function obj_AI:查找Buff(名字, 没有过期, 只判断存在, 精确的名字查找)
    if(没有过期==nil)then 没有过期=false end
    if(只判断存在==nil)then 只判断存在=false end
    if(精确的名字查找==nil)then 精确的名字查找=false end
    return self.objai:getBuff(名字, 没有过期, 只判断存在, 精确的名字查找)
end
function obj_AI:获取全部Buff() return self.objai:getBuffs() end
function obj_AI:移动到(坐标) return self.objai:movTo(坐标) end
function obj_AI:攻击(对象) return self.objai:Attack(对象) end
function obj_AI:修改皮肤(皮肤ID) return self.objai:skinChange(皮肤ID) end
function obj_AI:类型() return self.objai:type() end
function obj_AI:获取普通攻击弹道对象() return self.objai:GetBasicAttack() end
function obj_AI:视为弹道对象() return self.objai:asBallistic() end
return obj_AI

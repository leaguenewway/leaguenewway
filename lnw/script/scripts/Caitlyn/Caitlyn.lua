local obj_AI = require("_SDK.obj_AI")
local buff = require("_SDK.buff")
local enum = require("_SDK.Enum")
local _g = require("_SDK.G")
local register = require("_SDK.register")
local menu = require("_SDK.menu")
local targetSelct = require("scripts.targetSelect.targetSelect")
local prediction = require("scripts.Prediction.Prediction")

local myhero = _g.myself
if (myhero:name() ~= "Caitlyn") then
    return nil
end

local Caitlyn = {}
Caitlyn.b={
    cq=boolean,
    cw=boolean,
    ce=boolean,
    cr=boolean,
    qt=0,
    et=0,
    hq=boolean,
    ar=boolean,
    rt=0,

}
Caitlyn.menu=function()
    menu.setCacheName(myhero:name())
    menu.text("连招设置")
    Caitlyn.b.cq=menu.checkbox("连招使用Q",Caitlyn.b.cq)
    menu.sameLine()
    Caitlyn.b.cw=menu.checkbox("连招使用W",Caitlyn.b.cw)
    menu.sameLine()
    Caitlyn.b.ce=menu.checkbox("连招使用E",Caitlyn.b.ce)
    menu.sameLine()
    Caitlyn.b.cr=menu.checkbox("连招使用R",Caitlyn.b.cr)
    menu.separator()
    menu.text("骚扰设置")
    Caitlyn.b.hq=menu.checkbox("骚扰使用Q",Caitlyn.b.hq)
    menu.separator()
    menu.text("Q设置")
    Caitlyn.b.qt=menu.combo("Q模式",Caitlyn.b.qt,{"总是使用","攻击范围内有敌人不使用Q"})
    menu.separator()
    menu.text("E设置")
    Caitlyn.b.et=menu.combo("E模式",Caitlyn.b.et,{"总是使用","仅近身使用"})
    menu.separator()
    menu.text("R设置")
    Caitlyn.b.ar=menu.checkbox("自动R",Caitlyn.b.ar)
    menu.sameLine()
    Caitlyn.b.rt=menu.combo("R模式",Caitlyn.b.rt,{"总是使用","攻击范围内有敌人不使用R"})
end
Caitlyn.tick = function()
    if (_g.fitMode == enum.fitMode.combo) then
        local _q = myhero:spell(enum.spellSlot.q)
        local _e = myhero:spell(enum.spellSlot.e)

        if (_q:canCast()) then
            local target = targetSelct.Target(_q:range())
            if (target:canMakeTarget() and myhero:calculationDistance(target:position()) > myhero:range()+target:radius()) then
                _q:cast_postion(prediction.PredictionPos(target, _q:range(), 1800, 75, 0.5))
            end
        end
        if (_e:canCast()) then
            local target = targetSelct.Target(300)
            if (target:canMakeTarget()) then
                local castpos = prediction.PredictionPos(target, _e:range(), 2200, 75, 0.15)
                if (not prediction.check_Obstruct(castpos)) then
                    _e:cast_postion(castpos)
                end
            end
        end
    end
end
register.init({
    name = " 皮城女警",
    tick = Caitlyn.tick,
    menu = Caitlyn.menu,
    -- draw = Caitlyn.draw,
    -- message = Caitlyn.message
})
return Caitlyn

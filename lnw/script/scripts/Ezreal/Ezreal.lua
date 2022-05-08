local register = require("_SDK.register")
local targetSelect = require("scripts.targetSelect.targetSelect")
local Prediction = require("scripts.Prediction.Prediction")

local Ezreal = {}

Ezreal.b = {}
Ezreal.b.cq = false
Ezreal.b.cw = false
Ezreal.b.autor = false
Ezreal.b.autorn = 0
Ezreal.b.autorr = 0
Ezreal.b.autorh = 0
Ezreal.b.autorc = false
Ezreal.b.hq = false
Ezreal.b.hw = false
Ezreal.b.hmp = 0
Ezreal.b.hp = 0
Ezreal.b.hauto = false
Ezreal.b.hautok = 73
Ezreal.b.hautod = false
Ezreal.b.lnc = false
Ezreal.b.lq = false
Ezreal.b.lmp = 0
Ezreal.b.bq = false
Ezreal.menu = function()
    core.menu.Text("连招设置")
    core.menu.PushID("combo")
    Ezreal.b.cq = core.menu.Checkbox("Ezreal", "连招使用Q", Ezreal.b.cq)
    core.menu.SameLine()
    Ezreal.b.cw = core.menu.Checkbox("Ezreal", "连招使用W", Ezreal.b.cw)

    if (Ezreal.b.autor == true) then
        core.menu.Separator()
        core.menu.Text("自动R设置")
        Ezreal.b.autor = core.menu.Checkbox("Ezreal", "自动R", Ezreal.b.autor)
        core.menu.SameLine()
        Ezreal.b.autorh = core.menu.KeySelect("Ezreal", "预判R热键", Ezreal.b.autorh)
        core.menu.SameLine()
        Ezreal.b.autorc = core.menu.Checkbox("Ezreal", "连招时不使用", Ezreal.b.autorc)
        Ezreal.b.autorr = core.menu.SliderFloat("Ezreal", "R判定范围,超出不使用自动R", Ezreal.b.autorr, 0,
            3500)
        Ezreal.b.autorn = core.menu.SliderFloat("Ezreal", "AOER,当可命中x人,0为不启用该项", Ezreal.b.autorn,
            0, 5)
        Ezreal.b.autorn = math.floor(Ezreal.b.autorn)
    else
        Ezreal.b.autor = core.menu.Checkbox("Ezreal", "自动R", Ezreal.b.autor)
    end

    core.menu.PopID()
    core.menu.Separator()

    core.menu.Text("骚扰设置")
    core.menu.PushID("harass")
    Ezreal.b.hq = core.menu.Checkbox("Ezreal", "骚扰使用Q", Ezreal.b.hq)
    core.menu.SameLine()
    Ezreal.b.hw = core.menu.Checkbox("Ezreal", "骚扰使用W", Ezreal.b.hw)

    Ezreal.b.hp = core.menu.Combo("Ezreal", "骚扰命中精度", Ezreal.b.hp, {"普通", "高"})
    Ezreal.b.hmp = core.menu.SliderFloat("Ezreal", "骚扰蓝量控制", Ezreal.b.hmp, 0, 100)

    Ezreal.b.hauto = core.menu.Checkbox("Ezreal", "自动骚扰", Ezreal.b.hauto)
    core.menu.SameLine()
    Ezreal.b.hautok = core.menu.KeySelect("Ezreal", "开关热键", Ezreal.b.hautok)
    core.menu.SameLine()
    Ezreal.b.hautod = core.menu.Checkbox("Ezreal", "绘制开关", Ezreal.b.hautod)

    core.menu.PopID()

    core.menu.Separator()
    core.menu.PushID("clear")
    core.menu.Text("清线补刀设置")
    Ezreal.b.lnc = core.menu.Checkbox("Ezreal", "仅非对线时启用清线", Ezreal.b.lnc)
    core.menu.SameLine()
    Ezreal.b.lq = core.menu.Checkbox("Ezreal", "清线使用Q", Ezreal.b.lq)
    if (Ezreal.b.lnc == false) then
        Ezreal.b.lmp = core.menu.SliderFloat("Ezreal", "清线蓝量控制", Ezreal.b.lmp, 0, 100)
    end
    Ezreal.b.bq = core.menu.Checkbox("Ezreal", "尾刀使用Q", Ezreal.b.bq)
    core.menu.PopID()
end

Ezreal.castSpell = function(spell, speed, width, delay, range, checkObstruct, probability)
    local myhero = core.G.myself
    if (range == nil) then
        range = spell:range()
    end
    if (width == nil) then
        width = 75
    end
    if (delay == nil) then
        delay = 0.25
    end
    if (probability == nil) then
        probability = 0
    end
    if (spell:canCast()) then
        target = targetSelect.Target(range)
        if (target:canMakeTarget() == true) then
            castpos, p = Prediction.PredictionPos(target, range, speed, width, delay)
            if (p < probability) then
                return false
            end
            if (myhero:calculationDistance(castpos) > range) then
                return false
            end
            if (checkObstruct == true and Prediction.check_Obstruct(castpos, nil, width, true)) then
                return false
            end
            return spell:cast_postion(castpos)
        end
    end
    return false
end

Ezreal.canSeckill = function(target)
    myhero = core.G.myself
    _r = core.spell(myhero, 3)
    damage = 200 + 150 * _r:level() + myhero:adMore() + myhero:ap() * 0.9
    return target:calculateDamage(damage, 1) > target:hp()
end

Ezreal.tick = function()
    local myhero = core.G.myself
    local _q = core.spell(myhero, 0)
    local _w = core.spell(myhero, 1)
    -- --------------------连招----------------------
    if (core.script.fitMode() == Enum.fitMode.combo) then
        if (Ezreal.b.cw and Ezreal.castSpell(_w, 2000, 75, 0.25, nil, false)) then
            return
        end
        if (Ezreal.b.cq and Ezreal.castSpell(_q, 2000, 75, 0.25, nil, true)) then
            return
        end
    end
    -- --------------------连招----------------------
    -- --------------------骚扰----------------------
    if (Ezreal.b.hauto or core.script.fitMode() == Enum.fitMode.harass) then
        if (myhero:mp() / myhero:mpMax() > Ezreal.b.hmp / 100) then
            if (Ezreal.b.hw and Ezreal.castSpell(_w, 2000, 75, 0.25, nil, false, Ezreal.b.hp)) then
                return
            end
            if (Ezreal.b.hq and Ezreal.castSpell(_q, 2000, 75, 0.25, nil, true, Ezreal.b.hp)) then
                return
            end
        end
    end
    -- --------------------骚扰----------------------
    -- --------------------自动R----------------------
    if (Ezreal.b.autor and Ezreal.b.autorn ~= 0) then
        if (Ezreal.b.autorc and core.script.fitMode() == Enum.fitMode.combo) then
            goto rend
        end
        local _r = core.spell(core.G.myself, 3)
        if (_r:canCast()) then
            EnemyHeros = targetSelect.EnemyHeros()
            for i1, v1 in pairs(EnemyHeros) do
                if (not v1:canMakeTarget() or v1:calculationDistance(myhero:position()) > Ezreal.b.autorr) then
                    goto v1n
                end
                count = 0
                for i2, v2 in pairs(EnemyHeros) do
                    if (v2:canMakeTarget() and v2:calculationDistance(v1:position()) < 175) then
                        count = count + 1
                    end
                end
                if (count >= Ezreal.b.autorn or Ezreal.canSeckill(v1)) then
                    castpos, p = Prediction.PredictionPos(v1, Ezreal.b.autorr, 2000, 175, 1)
                    if (p >= 0.75) then
                        _r:cast_postion(castpos)
                        goto rend
                    end
                end
                ::v1n::
            end
        end
        ::rend::
    end
    -- --------------------自动R----------------------
    -- --------------------自动清线补刀----------------------
    if ((Ezreal.b.lq or Ezreal.b.bq) and _q:canCast()) then
        if (core.script.fitMode() ~= Enum.fitMode.harass and core.script.fitMode() ~= Enum.fitMode.laneclear) then
            goto bqe
        end
        qdamage = 25 * _q:level() - 5 + myhero:ad() * 1.3 + myhero:ap() * 0.15
        qxq = Ezreal.b.lnc and (not targetSelect.Target(2000):canMakeTarget() and true or false) or
                  (myhero:mp() / myhero:mpMax() > Ezreal.b.lmp and true or false)
        if (Ezreal.b.lnc) then
            qxq = (not targetSelect.Target(2000):canMakeTarget() and true or false)
        else
            qxq = (myhero:mp() / myhero:mpMax() > Ezreal.b.lmp / 100 and true or false)
        end
        print(qxq)
        for i, v in pairs(core.game:AIMinionClient()) do
            if (not v:canMakeTarget() or v:team() == core.G.team_mine or v:calculationDistance(myhero:position()) > 1150) then
                goto me
            end
            if (v:hpMax() < 50) then
                goto me
            end
            if (v:hp() < qdamage and Ezreal.b.bq and not Prediction.check_Obstruct(v:position())) then
                _q:cast_postion(v:position())
                goto bqe
            end
            if (qxq) then
                _q:cast_postion(v:position())
                goto bqe
            end
            ::me::
        end
        ::bqe::
    end
    -- --------------------自动清线补刀----------------------
end

Ezreal.draw = function()
    local myhero = core.G.myself
    if (Ezreal.b.hautod) then
        pos = core.game.Vector3T2(myhero:position())
        pos[1] = pos[1] - 37
        pos[2] = pos[2] + 20
        fvalue = "自动骚扰:" .. (Ezreal.b.hauto == true and "开启" or "关闭")
        fcolor = Ezreal.b.hauto == true and {0, 1, 0, 1} or {1, 0, 0, 1}
        core.draw.drawfont2d(pos, fvalue, fcolor, 18)
    end
end

Ezreal.message = function(msg, wParam, lParam)
    if (msg == 256) then
        if (wParam == Ezreal.b.hautok) then
            Ezreal.b.hauto = not Ezreal.b.hauto
        end
        -- 预判r
        local _r = core.spell(core.G.myself, 3)
        if (Ezreal.b.autor and _r:canCast() and wParam == Ezreal.b.autorh) then
            target = targetSelect.Target(Ezreal.b.autorr, 0, true)
            if (target:canMakeTarget()) then
                Ezreal.castSpell(_r, 2000, 175, 1, Ezreal.b.autorr, true, 1)
            end
        end
    end
end

if (core.G.myself:name() ~= "Ezreal") then
    return nil
end

register.init({
    name = " 伊泽瑞尔",
    tick = Ezreal.tick,
    menu = Ezreal.menu,
    draw = Ezreal.draw,
    message = Ezreal.message
})
return Ezreal

local Vayne = {}
local targetSelect = require("scripts.targetSelect.targetSelect")
local Enum = require("_SDK.Enum")
local evade = require("scripts.Evade.Evade")
Vayne.b = {}
Vayne.b.qmode = 0
Vayne.b.afr = false
Vayne.b.qaks = false
Vayne.b.bit = false
Vayne.b.aue = false
Vayne.b.ei = false
Vayne.b.emh = 0
Vayne.b.eaas = false
Vayne.b.efh = 0
Vayne.b.qas3 = false
Vayne.b.qnd = false
Vayne.b.qd = false
Vayne.b.ed = false
Vayne.b.cr = false
Vayne.b.crna = false
Vayne.b.crc = 0
Vayne.b.crh = 0
Vayne.b.crd = false
Vayne.b.cq = false
Vayne.b.ce = false
Vayne.b.hq = false
Vayne.b.he = false
Vayne.b.lq = false
Vayne.b.le = false
Vayne.b.lmp = 0
Vayne.b.lnc = false
Vayne.mindTurret = function()
    local myhero = core.G.myself
    local min = nil
    for i, v in pairs(core.game.AITurretClient()) do
        if (not v:canMakeTarget() or v:team() == core.G.team_mine) then
            goto tfe
        end
        if (min == nil) then
            min = v
        end
        if (min:calculationDistance(myhero:position()) > v:calculationDistance(myhero:position())) then
            min = v
        end
        ::tfe::
    end
    return min
end

Vayne.FaceToTarget = function(target)
    local a1 = core.math.LineVector(core.G.myself:position(), target:position())
    local a2 = core.math.LineVector(core.G.myself:position(), core.game.mousePosition())
    return math.abs(a1 - a2) < 30
end

Vayne.calcQpos = function()
    local myhero = core.G.myself
    local pos = core.math.LineVectorTo(myhero:position(), core.game.mousePosition(), 0, 300, 0)
    if (Vayne.b.qmode == 1) then
        return true, pos
    end
    local t = nil
    local itt = nil
    local qat = nil
    for i, v in pairs(core.game.AIHeroClient()) do
        if (not v:canMakeTarget() or v:team() == core.G.team_mine or v:calculationDistance(myhero:position()) > 1500) then
            goto forend
        end
        if (core.math.calculationDistance(v:position(), pos) < 300) then
            pos = core.math.LineVectorTo(v:position(), pos, 0, 300, 0)
            pos = core.math.LineVectorTo(myhero:position(), pos, 0, 300, 0)
            pos = core.math.LineVectorTo(v:position(), pos, 0, 300, 0)
        end
        if (v:calculationDistance(pos) < myhero:range() + v:radius()) then
            t = v
        end
        if (v:calculationDistance(myhero:position()) < myhero:range() + myhero:radius() + v:radius()) then
            itt = v
        end
        if (v:calculationDistance(myhero:position()) < myhero:range() + myhero:radius() + v:radius() +
            core.spell(myhero, 0):range()) then
            qat = v
        end
        ::forend::
    end
    if (t == nil and itt ~= nil) then
        local d = myhero:calculationDistance(itt:position()) - 10
        pos = core.math.LineVectorTo(itt:position(), core.game.mousePosition(), 0, d, 0)
        pos = core.math.LineVectorTo(myhero:position(), pos, 0, 300, 0)
        if (itt:calculationDistance(pos) < 300) then
            itt = nil
        end
    end
    if (itt == nil) then
        if (qat == nil or not Vayne.b.qazj) then
            return false, pos
        end
        if (Vayne.FaceToTarget(qat)) then
            itt = qat
            pos = core.math.LineVectorTo(itt:position(), core.game.mousePosition(), 0, myhero:range(), 0)
            pos = core.math.LineVectorTo(myhero:position(), pos, 0, 300, 0)
        else
            return false, pos
        end
    end
    if (Vayne.b.bit) then
        local mt = Vayne.mindTurret()
        if (mt ~= nil and mt:canMakeTarget() and mt:calculationDistance(myhero:position()) > 850) then
            if (mt:calculationDistance(pos) <= 900) then
                pos = core.math.LineVectorTo(mt:position(), pos, 0, 900, 0)
                pos = core.math.LineVectorTo(myhero:position(), pos, 0, 300, 0)
                pos = core.math.LineVectorTo(mt:position(), pos, 0, 900, 0)
            end
        end
        if (itt:calculationDistance(pos) > myhero:range() + itt:radius()) then
            return false, pos
        end
    end
    local d = myhero:calculationDistance(pos)
    if (d < 290 or d > 310) then
        return false, pos
    end
    return true, pos
end
Vayne.name2spell = function(name)
    for i, v in pairs({0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13}) do
        local spell = core.spell(core.G.myself, i)
        if (string.find(spell:name(), name) ~= nil) then
            return spell
        end
    end
    return nil
end
local flash = Vayne.name2spell("SummonerFlash")
local EflashPos = nil

Vayne.Eflash = function()
    local myhero = core.G.myself
    if (core.script.fitMode() == 0) then
        myhero:movTo(core.game.mousePosition())
    end
    local _E = core.spell(myhero, 2)
    if (not _E:canCast()) then
        return
    end
    local nearmouse = nil
    for i, v in pairs(core.game.AIHeroClient()) do
        if (v:canMakeTarget() and v:team() ~= core.G.team_mine and v:calculationDistance(myhero:position()) < _E:range() +
            v:radius() + myhero:radius()) then
            -- 获取最靠近鼠标
            if (nearmouse == nil) then
                nearmouse = v
            end
            if (v:calculationDistance(core.game.mousePosition()) <
                nearmouse:calculationDistance(core.game.mousePosition())) then
                nearmouse = v
            end
        end
    end
    if (nearmouse ~= nil and nearmouse:canMakeTarget()) then
        if (Vayne.calcETickWall(nearmouse)) then
            return
        end
        local radius = 0
        if (flash ~= nil and flash:canCast()) then
            while (radius < 360) do
                radius = radius + 20
                local pos = core.math.LineVectorTo(myhero:position(), {0, 0, 0}, 0, flash:range(), radius)
                if (Vayne.calcETickWall(nearmouse, pos)) then
                    EflashPos = pos
                    _E:cast_target(nearmouse)
                    break
                end
            end
        end
    end
end

Vayne.castE = function()
    local myhero = core.G.myself
    local _E = core.spell(myhero, 2)
    if (not _E:canCast()) then
        return
    end

    local jtjz = myhero:hp() / myhero:hpMax() <= Vayne.b.emh / 100
    for i, v in pairs(core.game.AIHeroClient()) do
        if (v:canMakeTarget() and v:team() ~= core.G.team_mine and v:calculationDistance(myhero:position()) < _E:range() +
            v:radius() + myhero:radius()) then
            -- 钉墙
            local t = Vayne.calcETickWall(v)
            if (t) then
                _E:cast_target(v)
                return
            end
            -- 击退
            if (jtjz and v:combatType() == Enum.combatType.Melee and v:calculationDistance(myhero:position()) <
                v:range() + v:radius() + myhero:radius()) then
                _E:cast_target(v)
                return
            end
        end
    end
end

Vayne.menu = function()
    core.menu.Text("连招设置")
    Vayne.b.cq = core.menu.Checkbox("Vayne", "连招使用Q", Vayne.b.cq)
    core.menu.SameLine()
    Vayne.b.ce = core.menu.Checkbox("Vayne", "连招使用E", Vayne.b.ce)

    if (Vayne.b.cr) then
        core.menu.Separator()
        core.menu.Text("R设置")
        Vayne.b.cr = core.menu.Checkbox("Vayne", "连招使用R", Vayne.b.cr)
        core.menu.SameLine()
        Vayne.b.crna = core.menu.Checkbox("Vayne", "隐身时禁用A", Vayne.b.crna)
        core.menu.SameLine()
        Vayne.b.crd = core.menu.Checkbox("Vayne", "显示R剩余时间", Vayne.b.crd)
        Vayne.b.crc = core.menu.SliderInt("Vayne", "R当周围敌人>x,0为关闭", Vayne.b.crc, 0, 5)
        Vayne.b.crh = core.menu.SliderFloat("Vayne", "R且当血量<x", Vayne.b.crh, 0, 100)
    else
        core.menu.SameLine()
        Vayne.b.cr = core.menu.Checkbox("Vayne", "连招使用R", Vayne.b.cr)
    end

    core.menu.Separator()
    core.menu.Text("骚扰设置")
    Vayne.b.hq = core.menu.Checkbox("Vayne", "骚扰使用Q", Vayne.b.hq)
    core.menu.SameLine()
    Vayne.b.he = core.menu.Checkbox("Vayne", "骚扰使用E", Vayne.b.he)

    core.menu.Separator()
    core.menu.Text("清线设置")
    Vayne.b.lnc = core.menu.Checkbox("Vayne", "仅非对线时启用清线", Vayne.b.lnc)
    core.menu.SameLine()
    Vayne.b.lq = core.menu.Checkbox("Vayne", "清线使用Q", Vayne.b.lq)
    core.menu.SameLine()
    Vayne.b.le = core.menu.Checkbox("Vayne", "清线使用E(仅野怪)", Vayne.b.le)
    if (Vayne.b.lnc == false) then
        Vayne.b.lmp = core.menu.SliderFloat("Vayne", "清线蓝量控制", Vayne.b.lmp, 0, 100)
    end

    core.menu.Separator()
    core.menu.Text("Q设置")
    Vayne.b.qmode = core.menu.Combo("Vayne", "Q模式", Vayne.b.qmode, {"代码托管", "鼠标位置"})
    core.menu.SameLine()
    Vayne.b.qd = core.menu.Checkbox("Vayne", "画出位置", Vayne.b.qd)

    if (Vayne.b.qmode == 0) then
        Vayne.b.qazj = core.menu.Checkbox("Vayne", "QA追击", Vayne.b.qazj)
        core.menu.SameLine()
        Vayne.b.bit = core.menu.Checkbox("Vayne", "不自动进塔", Vayne.b.bit)
        core.menu.SameLine()
        core.menu.Text("*在对非英雄目标时，仍然释放为鼠标位置")
    end

    Vayne.b.afr = core.menu.Checkbox("Vayne", "R释放后自动Q", Vayne.b.afr)
    core.menu.SameLine()
    Vayne.b.qnd = core.menu.Checkbox("Vayne", "取消Q动画", Vayne.b.qnd)
    core.menu.SameLine()
    Vayne.b.qas3 = core.menu.Checkbox("Vayne", "仅QA第三层被动", Vayne.b.qas3)

    core.menu.Separator()
    core.menu.Text("E设置")
    Vayne.b.aue = core.menu.Checkbox("Vayne", "自动使用E", Vayne.b.aue)
    -- core.menu.SameLine()
    -- Vayne.b.ei = core.menu.Checkbox("Vayne", "使用E打断技能", Vayne.b.ei)
    core.menu.SameLine()
    Vayne.b.eaas = core.menu.Checkbox("Vayne", "AAE自动击杀", Vayne.b.eaas)
    core.menu.SameLine()
    Vayne.b.ed = core.menu.Checkbox("Vayne", "画出E出位置", Vayne.b.ed)
    core.menu.SameLine()
    Vayne.b.efh = core.menu.KeySelect("Vayne", "E闪钉墙热键", Vayne.b.efh)
    Vayne.b.emh = core.menu.SliderFloat("Vayne", "击退近战当血量<x", Vayne.b.emh, 0, 100)

end

Vayne.calcETickWall = function(target, s)
    local myhero = core.G.myself
    local pos = {}
    if (s == nil) then
        s = myhero:position()
    end
    for i, d in pairs({50, 100, 200, 300, 400, 445}) do
        pos = core.math.LineVectorTo(s, target:position(), 1, d, 0)
        if (core.game.isInWall(pos)) then
            return true, pos
        end
    end
    return false, pos
end

Vayne.draw = function()
    local myhero = core.G.myself
    if (Vayne.b.qd) then
        local t, pos = Vayne.calcQpos()
        if (t) then
            core.draw.drawcircle(pos, 50, 1, 20, {0.7, 0, 0, 1})
        end
    end
    if (Vayne.b.ed) then
        local _E = core.spell(myhero, 2)
        if (_E:canCast()) then
            for i, v in pairs(core.game.AIHeroClient()) do
                if (v:canMakeTarget() and v:team() ~= core.G.team_mine and v:calculationDistance(myhero:position()) <
                    _E:range() + v:radius()) then
                    local t, pos = Vayne.calcETickWall(v)
                    local color = {1, 1, 1, 1}
                    if (t) then
                        color = {0, 1, 0, 1}
                    end
                    core.draw.drawline(v:position(), pos, 1, color)
                    core.draw.drawcircle(pos, 30, 1, 10, color)
                end
            end
        end
    end

    if (Vayne.b.crd) then
        local Rbuff = core.G.myself:getBuff("VayneInquisition", false, false, true)
        if (Rbuff:autoCount() == 1) then
            local time = Rbuff:timeEnd() - core.game.time(0)
            if (time > 0) then
                local pos = core.game.Vector3T2(myhero:position())
                local usetime = 6 + 2 * core.spell(myhero, 3):level()
                pos[1] = pos[1] + 40
                pos[2] = pos[2] - 40
                core.draw.drawline2d(pos, {pos[1] + 100, pos[2]}, 10, {0, 0, 0, 0.3})
                core.draw.drawline2d(pos, {pos[1] + 100 * (time / usetime), pos[2]}, 10, {0.03, 0.43, 0.14, 1})
                core.draw.drawVectorReact2d(pos, {pos[1] + 100, pos[2]}, 5, 1, {0.03, 0.04, 0.05, 1})
                pos[1] = pos[1] + 10
                pos[2] = pos[2] - 20
                local color = time > 2 and {1, 1, 1, 1} or {1, 0, 0, 1}
                core.draw.drawfont2d(pos, "R:" .. tostring(math.floor(time * 100) / 100), color, 15)
            end
        end
    end
end
Vayne.canLinclear = function()
    local canlaneclear = false
    if (Vayne.b.lnc) then
        canlaneclear = (not targetSelect.Target(2500):canMakeTarget() and true or false)
    else
        canlaneclear = (myhero:mp() / myhero:mpMax() > Vayne.b.lmp / 100 and true or false)
    end
    return canlaneclear
end
Vayne.tick = function()
    local myhero = core.G.myself
    -- --------------------连招----------------------
    if (core.script.fitMode() == Enum.fitMode.combo) then
        local _Q = core.spell(myhero, 0)
        if (Vayne.b.cq and _Q:canCast()) then
            local t, pos = Vayne.calcQpos()
            if (t and not targetSelect.Target(myhero:range() + myhero:radius(), 0, true, nil, true):canMakeTarget()) then
                _Q:cast_postion(evade.GetSafePos(pos))
            end
        end
        if (Vayne.b.ce and not Vayne.b.aue) then
            Vayne.castE()
        end
        local _R = core.spell(myhero, 3)
        if (Vayne.b.cr and _R:canCast()) then
            if (#targetSelect.EnemyHeros(700) >= Vayne.b.crc and myhero:hp() / myhero:hpMax() < Vayne.b.crh / 100) then
                _R:cast_target(myhero)
            end
        end
    end
    -- --------------------连招----------------------
    -- --------------------骚扰----------------------
    if (core.script.fitMode() == Enum.fitMode.harass) then
        local _Q = core.spell(myhero, 0)
        if (Vayne.b.cq and _Q:canCast()) then
            local t, pos = Vayne.calcQpos()
            if (t and not targetSelect.Target(myhero:range() + myhero:radius(), 0, true, nil, true):canMakeTarget()) then
                _Q:cast_postion(evade.GetSafePos(pos))
            end
        end
        if (Vayne.b.ce and not Vayne.b.aue) then
            Vayne.castE()
        end
    end
    -- --------------------骚扰----------------------
    -- --------------------清野----------------------
    if (core.script.fitMode() == Enum.fitMode.laneclear) then
        local _E = core.spell(myhero, 2)
        if (_E:canCast()) then
            local target = targetSelect.Soldier(_E:range())
            if (target ~= nil and target:canMakeTarget() and target:team() == 300) then
                -- 钉墙
                local t = Vayne.calcETickWall(target)
                if (t) then
                    _E:cast_target(target)
                    return
                end
            end
        end
    end
    -- --------------------清野----------------------
    -- --------------------自动E----------------------
    if (Vayne.b.aue) then
        Vayne.castE()
    end
    -- --------------------自动E----------------------
    -- --------------------E闪----------------------
    if (core.game.keyIsDown(Vayne.b.efh)) then
        if (EflashPos ~= nil) then
            if (flash:cast_postion(EflashPos)) then
                EflashPos = nil
            end
        else
            Vayne.Eflash()
        end
    end
    -- --------------------E闪----------------------
end
Vayne.QcastTime = 0
Vayne.skill2 = function(spell)
    local myhero = core.G.myself
    if (spell:ownd():pbase() ~= myhero:pbase()) then
        return
    end
    if (spell:slot() == 0) then
        if (Vayne.b.qnd) then
            myhero:emote(2)
        end
        Vayne.QcastTime = core.game.time(0)
    end
    local _Q = core.spell(myhero, 0)
    if (Vayne.b.afr and spell:slot() == 3) then
        local t, pos = Vayne.calcQpos()
        _Q:cast_postion(evade.GetSafePos(pos))
        return
    end
    if (spell:slot() == -1) then
        if (Vayne.b.qas3) then
            if (spell:target():getBuff("VayneSilveredDebuff", true, false, true):autoCount() ~= 1) then
                return
            end
        end
        local v = spell:target()
        local p_c = Vayne.b.ce and core.script.fitMode() == Enum.fitMode.combo and v:type() == 3
        local p_h = Vayne.b.he and core.script.fitMode() == Enum.fitMode.harass and v:type() == 3
        local p_l = Vayne.b.le and core.script.fitMode() == Enum.fitMode.laneclear and v:team() == 300 and
                        Vayne.canLinclear()
        -- AAE
        if ((p_c or p_h or p_l) and Vayne.b.eaas and v:getBuff("VayneSilveredDebuff", true, false, true):autoCount() ==
            1) then
            local _W = core.spell(myhero, 1)
            local _E = core.spell(myhero, 2)
            local damage = 35 + _E:level() + 15 + 0.5 * myhero:adMore()
            local damage2 = (0.015 + 0.025 * _W:level()) * v:hpMax()
            local damage3 = {50, 65, 80, 95, 110}
            damage3 = damage3[_W:level()]
            damage2 = damage2 > damage3 and damage2 or damage3
            damage = v:calculateDamage(damage, 0)
            if (v:hp() < damage + damage2) then
                _E:cast_target(v)
                return
            end
        end
    end
    -- A后接Q
    local v = spell:target()
    local p_c = Vayne.b.cq and core.script.fitMode() == Enum.fitMode.combo and v:type() == 3
    local p_h = Vayne.b.hq and core.script.fitMode() == Enum.fitMode.harass and v:type() == 3
    local p_l = Vayne.b.lq and core.script.fitMode() == Enum.fitMode.laneclear and Vayne.canLinclear()
    if ((p_c or p_h or p_l) and _Q:canCast()) then
        if (p_l and v:hp() > myhero:ad()) then
            _Q:cast_postion(evade.GetSafePos(core.game.mousePosition()))
        else
            local t, pos = Vayne.calcQpos()
            if (t) then
                _Q:cast_postion(evade.GetSafePos(pos))
            end
        end
    end
end

Vayne.attack = function(obj)
    if (Vayne.b.crna) then
        local atR = core.G.myself:getBuff("VayneInquisition", false, false, true):autoCount() ~= 0
        if (atR and core.game.time(0) - Vayne.QcastTime < 1) then  return false  end
    end
    return true
end

if (core.G.myself:name() ~= "Vayne") then
    return nil
end
local register = require("_SDK.register")
register.init({
    name = " 薇恩",
    tick = Vayne.tick,
    menu = Vayne.menu,
    draw = Vayne.draw,
    skill2 = Vayne.skill2,
    attack = Vayne.attack,
    addbuff = function(buff)
        print(buff:name())
    end
    -- message = Vayne.message
})
return Vayne


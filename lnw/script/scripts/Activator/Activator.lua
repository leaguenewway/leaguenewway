local register = require("_SDK.register")
local Enum = require("_SDK.Enum")
local Activator = {}
Activator.b = {}
Activator.b.buff = {{
    name = "禁锢",
    type = Enum.buff.Snare,
    bool = false
}, {
    name = "眩晕",
    type = Enum.buff.Stun,
    bool = false
}, {
    name = "压制",
    type = Enum.buff.Suppression,
    bool = false
}, {
    name = "嘲讽",
    type = Enum.buff.Taunt,
    bool = false
}, {
    name = "恐惧",
    type = Enum.buff.Fear,
    bool = false
}, {
    name = "魅惑",
    type = Enum.buff.Charm,
    bool = false
}, {
    name = "睡眠",
    type = Enum.buff.Asleep,
    bool = false
}, {
    name = "沉默",
    type = Enum.buff.Silence,
    bool = false
}, {
    name = "致盲",
    type = Enum.buff.Blind,
    bool = false
}, {
    name = "变形",
    type = Enum.buff.Polymorph,
    bool = false
}, {
    name = "减速",
    type = Enum.buff.Slow,
    bool = false
}}
Activator.b.wuping = {{
    name = "铁刺鞭",
    sname = "6630Active",
    bool = false
}, {
    name = "渴血战斧",
    sname = "6029Active",
    bool = false
}, {
    name = "挺进破坏者",
    sname = "6631Active",
    bool = false
}, {
    name = "永霜",
    sname = "6656Cast",
    bool = false
}}
Activator.b.jk = false
Activator.b.sy = false
Activator.b.jh = false
Activator.b.ys = false
Activator.b.yshp = 50
Activator.b.zl = false
Activator.b.zlhp = 20
Activator.b.yr = false
Activator.b.cjss = false
Activator.b.cjpt = false
Activator.b.zdwp = false
Activator.menu = function()
    core.menu.Text("物品技能设置")
    Activator.b.ys = core.menu.Checkbox("Activator", "自动药水", Activator.b.ys)
    core.menu.SameLine()
    Activator.b.yshp = core.menu.SliderFloat("Activator", "药水血量比", Activator.b.yshp, 0, 100)

    Activator.b.zl = core.menu.Checkbox("Activator", "自动治疗", Activator.b.zl)
    core.menu.SameLine()
    Activator.b.zlhp = core.menu.SliderFloat("Activator", "治疗血量比", Activator.b.zlhp, 0, 100)

    Activator.b.zdwp = core.menu.Checkbox("Activator", "自动物品", Activator.b.zdwp)
    if (Activator.b.zdwp) then
        for i, v in pairs(Activator.b.wuping) do
            core.menu.SameLine()
            v.bool = core.menu.Checkbox("Activator", v.name, v.bool)
        end
    end
    Activator.b.yr = core.menu.Checkbox("Activator", "自动引燃", Activator.b.yr)
    core.menu.SameLine()
    Activator.b.cjss = core.menu.Checkbox("Activator", "自动惩戒史诗野怪+双BUFF", Activator.b.cjss)
    core.menu.SameLine()
    Activator.b.cjpt = core.menu.Checkbox("Activator", "自动惩戒普通野怪", Activator.b.cjpt)
    core.menu.Separator()
    core.menu.Text("解控设置")
    Activator.b.jk = core.menu.Checkbox("Activator", "启用解控", Activator.b.jk)
    if (Activator.b.jk) then
        core.menu.SameLine()
        Activator.b.sy = core.menu.Checkbox("Activator", "使用水银", Activator.b.sy)
        core.menu.SameLine()
        Activator.b.jh = core.menu.Checkbox("Activator", "使用净化", Activator.b.jh)
        for i, v in pairs(Activator.b.buff) do
            v.bool = core.menu.Checkbox("Activator", v.name, v.bool)
            if (i ~= 7 and i ~= #Activator.b.buff) then
                core.menu.SameLine()
            end
        end
    end
end
Activator.name2spell = function(name)
    for i, v in pairs({0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13}) do
        local spell = core.spell(core.G.myself, i)
        if (string.find(spell:name(), name) ~= nil) then
            return spell
        end
    end
    return nil
end

Activator.Heal = Activator.name2spell("SummonerHeal")
Activator.Smite = Activator.name2spell("SummonerSmite")
Activator.Dot = Activator.name2spell("SummonerDot")
Activator.ystime = 0
Activator.tick = function()
    -- --------------------------auto health--------------------------
    if (Activator.Heal ~= nil and Activator.Heal:canCast() and Activator.b.zl) then
        if (core.G.myself:hp() / core.G.myself:hpMax() < Activator.b.zlhp / 100) then
            Activator.Heal:cast_target(core.G.myself)
        end
    end
    if (Activator.b.ys and core.game.time(0) > Activator.ystime) then
        if (core.G.myself:hp() / core.G.myself:hpMax() < Activator.b.yshp / 100) then
            local items = {{
                name = "Item2003",
                time = 15
            }, {
                name = "Item2010",
                time = 8
            }, {
                name = "ItemCrystalFlask",
                time = 12
            }, {
                name = "ItemDarkCrystalFlask",
                time = 12
            }}
            for i, v in pairs(items) do
                spell = Activator.name2spell(v.name)
                if (spell ~= nil and spell:canCast() and spell.slot > 5 and core.G.myself:itemCount(spell.slot - 5) > 0) then
                    print(spell:name(), core.G.myself:itemCount(spell.slot - 5))
                    spell:cast_target(core.G.myself)
                    Activator.ystime = core.game.time(0) + v.time
                    break
                end
            end
        end
    end
    -- --------------------------auto health--------------------------
    -- --------------------------auto items--------------------------
    if (Activator.b.zdwp and core.script.fitMode() == Enum.fitMode.combo) then
        local spell = nil
        for i, v in pairs(Activator.b.wuping) do
            local ispell = Activator.name2spell(v.sname)
            if (v.bool and ispell ~= nil and ispell:canCast()) then
                spell = ispell
            end
        end
        if (spell == nil) then
            goto nospell
        end
        for i, v in pairs(core.game.AIHeroClient()) do
            if (v:canMakeTarget() and v:team() == core.G.team_enemy and v:calculationDistance(core.G.myself:position()) <
                spell:range() + v:radius()) then
                spell:cast_postion(v:position())
                return
            end
        end
        ::nospell::
    end
    -- --------------------------auto items--------------------------
    -- --------------------------auto Dot--------------------------
    if (Activator.Dot ~= nil and Activator.Dot:canCast() and Activator.b.yr) then
        local damage = 50 + core.G.myself:level() * 20
        for i, v in pairs(core.game.AIHeroClient()) do
            if (v:canMakeTarget() and v:team() == core.G.team_enemy and v:hp() <= damage and
                v:calculationDistance(core.G.myself:position()) < Activator.Dot:range() + v:radius()) then
                Activator.Dot:cast_target(v)
                return
            end
        end
    end
    -- --------------------------auto Dot--------------------------
    -- --------------------------auto smite--------------------------
    if (Activator.Smite ~= nil and Activator.Smite:canCast() and (Activator.b.cjpt or Activator.b.cjss)) then
        local damage = Activator.Smite:name() == 'SummonerSmite' and 450 or 900
        local shishi = {"Dragon", "Baron", "Blue", "Red", "Rift"}
        local puton = {"SRU_Gromp", "SRU_Murkwolf", "SRU_Krug", "Sru_Crab", "SRU_Razorbeak"}
        local range = Activator.Smite:range()
        for i, v in pairs(core.game.AIMinionClient()) do
            if (v:team() ~= 300 or v:hp() > damage or v:calculationDistance(core.G.myself:position()) > range) then
                goto hn
            end
            if (Activator.b.cjss) then
                for si, sv in pairs(shishi) do
                    if (string.find(v:name(), sv) ~= nil) then
                        Activator.Smite:cast_target(v)
                    end
                end
            end
            if (Activator.b.cjpt) then
                for si, sv in pairs(puton) do
                    if (v:name() == sv) then
                        Activator.Smite:cast_target(v)
                    end
                end
            end
            ::hn::
        end
    end
    -- --------------------------auto smite--------------------------
end

Activator.draw = function()
    -- print(core.spell(core.G.myself,4):name())
    -- local myhero = core.G.myself
    -- local pos = {100, 10}
    -- for i, v in pairs(myhero:getBuffs()) do
    --     core.draw.drawfont2d(pos, v:name().."|".. tostring(v:timeEnd()), {1, 1, 1, 1}, 18)
    --     pos[2] = pos[2] + 20
    --     -- print(v:name())

    -- end
end

Activator.Boost = Activator.name2spell("SummonerBoost")
Activator.addbuff = function(buff)
    if (Activator.b.jk == false or buff:ownd()._pbase ~= core.G.myself._pbase or buff:caster():team() ~=
        core.G.team_enemy) then
        return
    end
    local find = false
    for i, v in pairs(Activator.b.buff) do
        if (buff:type() == v.type and v.bool) then
            find = true
            break
        end
    end
    if (find == false) then
        return
    end
    local spell = Activator.Boost
    if (spell == nil or spell:canCast() == false) then
        local items = {"QuicksilverSash", "ItemMercurial", "6035_Spell"}
        for i, v in pairs(items) do
            local itspell = Activator.name2spell(v)
            if (itspell ~= nil and itspell:canCast()) then
                spell = itspell
            end
        end
    end
    if (spell ~= nil) then
        spell:cast_target(core.G.myself)
    end
end

Activator.subbuff = function(buff)
    -- print("subbuff:", buff:name(), buff:type())
end

register.init({
    name = " 活化剂",
    tick = Activator.tick,
    draw = Activator.draw,
    menu = Activator.menu,
    addbuff = Activator.addbuff,
    subbuff = Activator.subbuff
})

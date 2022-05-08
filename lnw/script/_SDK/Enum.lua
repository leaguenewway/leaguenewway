Enum = {}
---@class fitMode
Enum.fitMode = {
    combo = 1,
    harass = 2,
    laneclear = 3,
    lasthit = 4,
    flee = 5
}
---@class CombatType
Enum.combatType = {
    Any = 0,
    Melee = 1,
    Ranged = 2
}
local _g=require("_SDK.G")
---@class team
Enum.team={
    teammate=_g.team_mine,
    enemy=_g.team_enemy,
    neutral=300
}
---@class emote
Enum.emote = {
    Dance=0,
    Irony = 1,
    Laugh = 2,
    Jeered = 3,
}
---@class damageType
Enum.damageType={
    Physics=0,
    magic=1,
    Real=2
}
---@class spellSlot
Enum.spellSlot={
    q=0,
    w=1,
    e=2,
    r=3,
    d=4,
    f=5,
    item1=6,
    item2=7,
    item3=8,
    item5=9,
    item6=10,
    item4=11,
    recall=12
}
---@class buffType
Enum.buff = {
    Internal = 0,
    Aura = 1,
    CombatEnchancer = 2,
    CombatDehancer = 3,
    SpellShield = 4,
    Stun = 5,
    Invisibility = 6,
    Silence = 7,
    Taunt = 8,
    Berserk = 9,
    Polymorph = 10,
    Slow = 11,
    Snare = 12,
    Damage = 13,
    Heal = 14,
    Haste = 15,
    SpellImmunity = 16,
    PhysicalImmunity = 17,
    Invulnerability = 18,
    AttackSpeedSlow = 19,
    NearSight = 20,
    Fear = 22,
    Charm = 23,
    Poison = 24,
    Suppression = 25,
    Blind = 26,
    Counter = 27,
    Currency = 21,
    Shred = 28,
    Flee = 29,
    Knockup = 30,
    Knockback = 31,
    Disarm = 32,
    Grounded = 33,
    Drowsy = 34,
    Asleep = 35,
    Obscured = 36,
    ClickproofToEnemies = 37,
    UnKillable = 38
}
return Enum

---@class vector3
---@class vector2
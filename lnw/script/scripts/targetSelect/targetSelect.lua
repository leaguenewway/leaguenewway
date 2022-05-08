local targetSelect = {}
---@param range number
---@param damgetype number
---@param checkYasuoWall boolean
---@param Pos table vector3
---@param addRadius boolean
---@return obj_AI
targetSelect.Target = function(range, damgetype, checkYasuoWall, Pos, addRadius)
    if (addRadius == nil) then
        addRadius = false
    end
    if (Pos == nil) then
        Pos = core.G.myself:position()
    end
    if (checkYasuoWall == nil) then
        checkYasuoWall = true
    end
    if (damgetype == nil) then
        damgetype = 0
    end
    if (range == nil) then
        range = 0
    end
    return require("_SDK.obj_AI"):load(script.targetSelect.Target(range, damgetype, checkYasuoWall, Pos, addRadius))
    -- return require("_SDK.obj_AI"):load(script.targetSelect.Target(range, damgetype, checkYasuoWall, Pos, addRadius))
end
targetSelect.Soldier = function(range, Pos, neutral)
    if (neutral == nil) then
        neutral = true
    end
    if (Pos == nil) then
        Pos = core.G.myself:position()
    end
    if (range == nil) then
        return {}
    end
    return require("_SDK.obj_AI"):load(script.targetSelect.soldier(range, Pos, neutral))
end
targetSelect.EnemyHeros = function(range, canmakeTarget, pos)
    local tmp = core.game.AIHeroClient()
    local ret = {}
    if (range == nil) then
        range = 25000
    end
    if (pos == nil) then
        pos = core.G.myself:position()
    end
    if (canmakeTarget == nil) then
        canmakeTarget = true
    end
    local obj_AI = require("_SDK.obj_AI")
    for i, v in pairs(tmp) do
        local h = obj_AI:load(v)
        if (h:team() == core.G.team_enemy and h:calculationDistance(pos) < range) then
            if (not canmakeTarget or h:canMakeTarget()) then
                table.insert(ret, v)
            end
        end
    end
    return ret
end
return targetSelect

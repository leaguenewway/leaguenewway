---@class std__G
---@field myself obj_AI
---@field scriptpath string
---@field team_mine team
---@field fitMode fitMode
local G={}
G.myself=require("_SDK.obj_AI"):load(core.G.myself)
G.scriptpath=core.G.scriptpath
G.team_enemy=core.G.team_enemy
G.team_mine=core.G.team_mine
setmetatable(
    G,
    {__index=function (t,k)
        if(k=="fitMode")then return core.script.fitMode() end
    end}
)
G.fitMode=nil
return G

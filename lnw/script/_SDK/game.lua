---@class std__game
local game={}
---@return number
function game.time() return core.game.time(0) end
---@return number
function game.hwnd() return core.game.hwnd() end
---@return number
function game.heapBase() return core.game.heapBase() end
---@return void
function game.setzoom(zoom) core.game.setzoom(zoom) end
---@return table<obj_AI>
function game.AIMissileClient() return core.game.AIMissileClient() end
---@return table<obj_AI>
function game.AIMinionClient() return core.game.AIMinionClient() end
---@return table<obj_AI>
function game.AITurretClient() return core.game.AITurretClient() end
---@return table<obj_AI>
function game.AIHeroClient() return core.game.AIHeroClient() end
---@return table<obj_AI>
function game.AIAttackableUnitClient() return core.game.AIAttackableUnitClient() end
---@return table<obj_AI>
function game.AIShopClient() return core.game.AIShopClient() end
---@return table<obj_AI>
function game.AIInhibitorClient() return core.game.AIInhibitorClient() end
---@return table<obj_AI>
function game.AIBuildingClient() return core.game.AIBuildingClient() end
---@param SourceID number
---@return obj_AI
function game.SourceID2OBJ(SourceID) return core.game.SourceID2OBJ(SourceID) end
---@param pos3d vector3
---@return vector2
function game.vector3T2(pos3d) return core.game.Vector3T2(pos3d) end
---@return number
function game.getWidth() return core.game.getWidth() end
---@return number
function game.getHeight() return core.game.getHeight() end
---@param pos vector3
---@return boolean
function game.isOverScreen(pos) return core.game.isOverScreen(pos) end
---@param pos vector2
---@return boolean
function game.isOverScreen2d(pos) return core.game.isOverScreen2d(pos) end
---@param pos vector2
---@return boolean
function game.isOverMiniMap(pos) return core.game.isOverMiniMap(pos) end
---@param posA vector3
---@param posB vector3
---@return number
function game.calculationDistance(posA,posB) return core.game.calculationDistance(posA,posB) end
---@param posA vector2
---@param posB vector2
---@return number
function game.calculationDistance2D(posA,posB) return core.game.calculationDistance2d(posA,posB) end
---@param pos vector3
---@return vector2
function game.word2minimap(pos) return core.game.word2minimap(pos) end
---@return vector3
function game.mousePosition() return core.game.mousePosition() end
---@param pos vector3
---@return boolean
function game.isInWall(pos) return core.game.isInWall(pos) end
---@param pos vector3
---@return boolean
function game.isInTod(pos) return core.game.isInTod(pos) end
---@return number
function game.ping() return core.game.ping() end
---@param value string
---@return void
function game.print(value) core.game.print(value) end
---@param keyCode number
---@return boolean
function game.keyIsDown(keyCode) return core.game.keyIsDown(keyCode) end
return game
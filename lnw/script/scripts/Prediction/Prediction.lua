local Prediction = {}
Prediction.check_YasuoWall = function(posEnd, posStart, width)
    if (width == nil) then
        width = 75
    end
    if (posStart == nil) then
        posStart = core.G.myself:position()
    end
    return script.Prediction.check_YasuoWall(posStart, posEnd, width)
end
Prediction.check_Obstruct = function(posEnd, posStart, width, checkYasuoWall)
    if (width == nil) then
        width = 75
    end
    if (checkYasuoWall == nil) then
        checkYasuoWall = true
    end
    if (posStart == nil) then
        posStart = core.G.myself:position()
    end
    return script.Prediction.check_Obstruct(posStart, posEnd, width, checkYasuoWall)
end
---@param target obj_AI
---@param range number
---@param speed number
---@param width number
---@param delay number
---@param PosStart table
---@return vector3,number
Prediction.PredictionPos = function(target, range, speed, width, delay, PosStart)
    if (width == nil) then
        width = 75
    end
    if (speed == nil) then
        speed = 1700
    end
    if (delay == nil) then
        delay = 0.25
    end
    if (PosStart == nil) then
        PosStart = core.G.myself:position()
    end
    if(target['navObj']~=nil)then
        target=target:navObj()
    end
    return script.Prediction.PredictionPos(target, speed, width, delay, range, PosStart), script.Prediction.probability
end
return Prediction

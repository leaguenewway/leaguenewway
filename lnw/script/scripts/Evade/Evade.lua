local Evade = {}
Evade.PosIsSafe = function(Pos)
    return (not script.evade.evade_Escape(Pos)), script.evade.evadepos
end
Evade.GetSafePos = function(Pos)
    local isdange = script.evade.evade_Escape(Pos)
    local thispos = Pos
    if (isdange) then
        thispos = script.evade.evadepos
    end
    return thispos
end
return Evade

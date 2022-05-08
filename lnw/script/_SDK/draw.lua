local draw={}
---@param pos vector3
---@param value string
---@param color table
---@param size number
function draw.drawfont(pos,value,color,size)
    if(color==nil)then color={1,1,1,1} end
    if(size==nil)then size=15 end
    core.draw.drawfont(pos,value,color,size)
end
---@param pos vector2
---@param value string
---@param color table
---@param size number
function draw.drawfont2D(pos,value,color,size)
    if(color==nil)then color={1,1,1,1} end
    if(size==nil)then size=15 end
    core.draw.drawfont2d(pos,value,color,size)
end
---@param posA vector3
---@param posB vector3
---@param width number
---@param color table
function draw.drawline(posA,posB,width,color)
    if(color==nil)then color={1,1,1,1} end
    if(width==nil)then width=1 end
    core.draw.drawfont2d(posA,posB,width,color)
end
---@param posA vector2
---@param posB vector2
---@param width number
---@param color table
function draw.drawline2D(posA,posB,width,color)
    if(color==nil)then color={1,1,1,1} end
    if(width==nil)then width=1 end
    core.draw.drawline2d(posA,posB,width,color)
end
---@param posA vector3
---@param posB vector3
---@param Reactwidth number
---@param width number
---@param color table
function draw.drawVectorReact(posA,posB,Reactwidth,width,color)
    if(color==nil)then color={1,1,1,1} end
    if(width==nil)then width=1 end
    if(Reactwidth==nil)then Reactwidth=1 end
    core.draw.drawVectorReact(posA,posB,Reactwidth,width,color)
end
---@param posA vector2
---@param posB vector2
---@param Reactwidth number
---@param width number
---@param color table
function draw.drawVectorReact2d(posA,posB,Reactwidth,width,color)
    if(color==nil)then color={1,1,1,1} end
    if(width==nil)then width=1 end
    if(Reactwidth==nil)then Reactwidth=1 end
    core.draw.drawVectorReact2d(posA,posB,Reactwidth,width,color)
end
---@param pos vector3
---@param radius number
---@param width number
---@param smooth number
---@param color table
function draw.drawcircle(pos,radius,width,smooth,color)
    if(color==nil)then color={1,1,1,1} end
    if(width==nil)then width=1 end
    if(smooth==nil)then smooth=10 end
    core.draw.drawcircle(pos,radius,width,smooth,color)
end
---@param pos vector2
---@param radius number
---@param width number
---@param smooth number
---@param color table
function draw.drawcircle2d(pos,radius,width,smooth,color)
    if(color==nil)then color={1,1,1,1} end
    if(width==nil)then width=1 end
    if(smooth==nil)then smooth=10 end
    core.draw.drawcircle2d(pos,radius,width,smooth,color)
end
---@param pos vector3
---@param radius number
---@param width number
---@param smooth number
---@param color table
function draw.drawcircleMiniMap(pos,radius,width,smooth,color)
    if(color==nil)then color={1,1,1,1} end
    if(width==nil)then width=1 end
    if(smooth==nil)then smooth=10 end
    core.draw.drawcircleMiniMap(pos,radius,width,smooth,color)
end
---@param fileName string
---@param pos vector3
---@param size number
function draw.drawimage(fileName,pos,size) core.draw.drawimage(fileName,pos,size) end
---@param fileName string
---@param pos vector2
---@param size number
function draw.drawimage2d(fileName,pos,size) return core.draw.drawimage2d(fileName,pos,size) end
---@param r number
---@param g number
---@param b number
---@param a number
---@return table
function draw.rgba(r,g,b,a) return {r/255,g/255,b/255,a/255} end
---@param rgba number
---@return table
function draw.rgbaFromInt(rgba)
    local tmp=string.format("%06X",rgba)
    while (string.len(tmp)<8)do tmp="0"..tmp end
    local r,g,b,a
    r=tonumber(tmp.sub(tmp,7,8),16)
    g=tonumber(tmp.sub(tmp,5,6),16)
    b=tonumber(tmp.sub(tmp,3,4),16)
    a=tonumber(tmp.sub(tmp,1,2),16)
    return {r/255,g/255,b/255,a/255}
end
return draw
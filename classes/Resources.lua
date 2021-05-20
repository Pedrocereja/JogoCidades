local tileset = love.graphics.newImage( "images/cartographypack/Spritesheet/spritesheet_default.png" )
local tilesetW, tilesetH = tileset:getWidth(), tileset:getHeight()
local tileW, tileH = 64,64

Recurso = Object:extend()

function Recurso:new(quad, x, y)
    self.x, self.y = x, y
    self.quad = quad
    self.state = "Full" --"Full", "Depleted"
    self.quantity = math.random(50, 200)
end

function Recurso:draw()
    if self.state == "Depleted" then
       return
    elseif self.state == "Full" then
        love.graphics.draw(tileset, self.quad, self.x, self.y)
    end
end


--TODO alocar a criação de um tile em uma só função de criação?
local tile = {}
tile["montanha"] = love.graphics.newQuad(192,  320, tileW, tileH, tilesetW, tilesetH)
tile["arvore"] = love.graphics.newQuad(0,  576, tileW, tileH, tilesetW, tilesetH)
tile["agua"] = love.graphics.newQuad(128,  640, tileW, tileH, tilesetW, tilesetH)

local function produceResourceType(quad, x, y)
    local newResource = Recurso(quad, x, y)
return newResource end

function newForest(x, y)
    forest = produceResourceType(tile["arvore"], x, y)
return forest end

function newMountain(x, y)
    mountain = produceResourceType(tile["montanha"], x, y)
return mountain end

function newWater(x, y)
    water = produceResourceType(tile["agua"], x, y)
return water end

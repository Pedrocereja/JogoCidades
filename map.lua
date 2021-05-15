local tileSet = love.graphics.newImage( "images/cartographypack/Spritesheet/spritesheet_default.png" )
local bgImage = love.graphics.newImage( "images/cartographypack/Textures/parchmentAncient.png" )
local tileW, tileH = 64,64
local tilesetW, tilesetH = tileSet:getWidth(), tileSet:getHeight()

tiles = {}
tiles[0] = love.graphics.newQuad(192,  320, tileW, tileH, tilesetW, tilesetH) --montanha
tiles[1] = love.graphics.newQuad(384,  128, tileW, tileH, tilesetW, tilesetH) --terra
tiles[2] = love.graphics.newQuad(0,  576, tileW, tileH, tilesetW, tilesetH)  --arvore
tiles[3] = love.graphics.newQuad(128,  640, tileW, tileH, tilesetW, tilesetH)  --agua

function drawBG()
    love.graphics.draw(
               bgImage,
               0,
               0)
end
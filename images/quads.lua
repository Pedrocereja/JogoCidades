tileset = love.graphics.newImage( "images/cartographypack/Spritesheet/spritesheet_default.png" )
local tilesetW, tilesetH = tileset:getWidth(), tileset:getHeight()
local tileW, tileH = 64,64

tile = {}
tile["mountain"] = love.graphics.newQuad(192,  320, tileW, tileH, tilesetW, tilesetH)
tile["trees"] = love.graphics.newQuad(0,  576, tileW, tileH, tilesetW, tilesetH)
tile["water"] = love.graphics.newQuad(128,  640, tileW, tileH, tilesetW, tilesetH)
tile["castle"] = love.graphics.newQuad(0,  0, 2*tileW, tileH, tilesetW, tilesetH)
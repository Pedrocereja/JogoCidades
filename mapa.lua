local tileset = love.graphics.newImage( "images/cartographypack/Spritesheet/spritesheet_default.png" )
local bgImage = love.graphics.newImage( "images/cartographypack/Textures/parchmentAncient.png" )
local tilesetW, tilesetH = tileset:getWidth(), tileset:getHeight()
local tileW, tileH = 64,64

local tiles = {}
tiles[0] = love.graphics.newQuad(192,  320, tileW, tileH, tilesetW, tilesetH) --montanha
tiles[1] = love.graphics.newQuad(384,  128, tileW, tileH, tilesetW, tilesetH) --terra
tiles[2] = love.graphics.newQuad(0,  576, tileW, tileH, tilesetW, tilesetH)  --arvore
tiles[3] = love.graphics.newQuad(128,  640, tileW, tileH, tilesetW, tilesetH)  --agua

local map={
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 1, 0, 0, 2, 2, 2, 0, 3, 0, 3, 0, 1, 1, 1, 0},
   { 0, 1, 0, 0, 2, 0, 2, 0, 3, 0, 3, 0, 1, 0, 0, 0},
   { 0, 1, 1, 0, 2, 2, 2, 0, 0, 3, 0, 0, 1, 1, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
   { 0, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0},
   { 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 2, 2, 2, 0, 3, 3, 3, 0, 1, 1, 1, 0, 2, 0, 0},
   { 0, 2, 0, 0, 0, 3, 0, 3, 0, 1, 0, 1, 0, 2, 0, 0},
   { 0, 2, 0, 0, 0, 3, 0, 3, 0, 1, 0, 1, 0, 2, 0, 0},
   { 0, 2, 2, 2, 0, 3, 3, 3, 0, 1, 1, 1, 0, 2, 2, 2},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
}

local mapW = #map[1]
local mapH = #map
local mapX = 0
local mapY = 0
local mapDisplayWidth = 25
local mapDisplayHeight = 19

local numberOfBufferedTiles = 4

function drawBG()
   love.graphics.draw(
              bgImage,
              0,
              0)
end

function drawMap()
   drawBG()

   local firstTileX = math.floor(mapX / tileW)
   local firstTileY = math.floor(mapY / tileH)
   local mapMaxYView = mapDisplayHeight + numberOfBufferedTiles
   local mapMaxXView = mapDisplayWidth + numberOfBufferedTiles
   for y=1, mapMaxYView do
      for x=1, mapMaxXView do
         if y+firstTileY >= 1 and y+firstTileY <= mapH
            and x+firstTileX >= 1 and x+firstTileX <= mapW
         then
            local tileInView_Index = tiles[ map[y + firstTileY][x + firstTileX] ]
            local tileInView_X = ( (firstTileX + x - 1) * tileW)
            local tileInView_Y = ( (firstTileY + y - 1) * tileH)
            love.graphics.draw(
               tileset,
               tileInView_Index,
               tileInView_X,
               tileInView_Y)
         end
      end
   end
end

function updateMapToCameraPosition()
   local function cameraTopLeftPosition()  return camera.x - (camera.w/2)/camera.scale, camera.y - (camera.h/2)/camera.scale end
	mapX, mapY = cameraTopLeftPosition()
   mapDisplayWidth = math.ceil(camera.w/camera.scale)/tileW
   mapDisplayHeight = math.ceil(camera.h/camera.scale)/tileH
end

function toMapCoordinates(x, y)
   local tileX, tileY = math.floor(x/tileW) + 1, math.floor(y/tileH) + 1
   if (tileX > mapW) or (tileY > mapH) then
      return nil, nil
   end
return tileX, tileY end
require "resources"

local bgImage = love.graphics.newImage( "images/cartographypack/Textures/parchmentAncient.png" )
local tileW, tileH = 64,64

local mapX = 0
local mapY = 0
local mapDisplayWidth = 25
local mapDisplayHeight = 19

local numberOfBufferedTiles = 4

local function drawBG()
   love.graphics.draw(bgImage, 0, 0)
end

local function drawResources()
   --temporary map for testing purposes

end

local function drawStructures()
   --to do
end

function drawMap()
   drawBG()
   drawResources()
   drawStructures()
end

function updateMapToCameraPosition()
   local function cameraTopLeftPosition()  return camera.x - (camera.w/2)/camera.scale, camera.y - (camera.h/2)/camera.scale end
	mapX, mapY = cameraTopLeftPosition()
   mapDisplayWidth = math.ceil(camera.w/camera.scale)/tileW
   mapDisplayHeight = math.ceil(camera.h/camera.scale)/tileH
end

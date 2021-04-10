-- our tiles
local tile = {}
for i=0,3 do -- change 3 to the number of tile images minus 1.
   tile[i] = love.graphics.newImage( "images/tile"..i..".png" )
end
   
-- map variables
local map_w = 20
local map_h = 20
local map_x = 0
local map_y = 0
local map_offset_x = 30
local map_offset_y = 30
local map_display_w = 14
local map_display_h = 10
local tile_w = 32
local tile_h = 32
local map_display_buffer = 2 -- We have to buffer one tile before and behind our viewpoint.
                        -- Otherwise, the tiles will just pop into view, and we don't want that

local map={
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
   { 0, 1, 0, 0, 2, 2, 2, 0, 3, 0, 3, 0, 1, 1, 1, 0, 0, 0, 0, 0},
   { 0, 1, 0, 0, 2, 0, 2, 0, 3, 0, 3, 0, 1, 0, 0, 0, 0, 0, 0, 0},
   { 0, 1, 1, 0, 2, 2, 2, 0, 0, 3, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
   { 0, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0},
   { 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 2, 2, 2, 0, 3, 3, 3, 0, 1, 1, 1, 0, 2, 0, 0, 0, 0, 0, 0},
   { 0, 2, 0, 0, 0, 3, 0, 3, 0, 1, 0, 1, 0, 2, 0, 0, 0, 0, 0, 0},
   { 0, 2, 0, 0, 0, 3, 0, 3, 0, 1, 0, 1, 0, 2, 0, 0, 0, 0, 0, 0},
   { 0, 2, 2, 2, 0, 3, 3, 3, 0, 1, 1, 1, 0, 2, 2, 2, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
}

function draw_map()
   offset_x = map_x % tile_w
   --print(offset_x)
   offset_y = map_y % tile_h
   firstTile_x = math.floor(map_x / tile_w)
   firstTile_y = math.floor(map_y / tile_h)
   
   for y=1, (map_display_h + map_display_buffer) do
      for x=1, (map_display_w + map_display_buffer) do
         -- Note that this condition block allows us to go beyond the edge of the map.
         if y+firstTile_y >= 1 and y+firstTile_y <= map_h
            and x+firstTile_x >= 1 and x+firstTile_x <= map_w
         then
            love.graphics.draw(
               tile[map[y+firstTile_y][x+firstTile_x]], 
               ((x-1)*tile_w) - offset_x - tile_w/2, 
               ((y-1)*tile_h) - offset_y - tile_h/2)
         end
      end
   end
end

function updateMap()
	map_y = camera.y-camera.h/2
	map_x = camera.x-camera.w/2
   map_display_w = camera.w*camera.scale
   map_display_h = camera.h*camera.scale
end
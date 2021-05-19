function love.load()
    Object = require "libs.classic"
    require "Scene"
	require "quads"
	--require "handlers.Dijkstra"
	local Camera = require "handlers.Camera"
	local tileset = love.graphics.newImage( "images/cartographypack/Spritesheet/spritesheet_default.png" )
	debugMode = true

	camera = Camera()
    camera:setFollowLerp(0.2)

	scene = Scene()
	onMouse = {} --objeto seguindo o mouse

	scene:setBackgroundAndGridSize("images/cartographypack/Textures/parchmentBasic.png")
	scene:newBuilding(200, 200)
end

function love.update(dt)
	camera:update(dt)
	scene:update(dt)
	--dijkstra:updateNodoseArestas(mundo.tortas, mundo.caminhos)
end

function love.draw()
	camera:attach()

	scene:draw()

    camera:detach()
end

function love.mousepressed(x, y, button)
	x, y = camera:toWorldCoords(x, y)
	local item = scene:whatDidIClick(x, y)
	print(item, x, y)
end

function love.wheelmoved(x, y)
	local minimumScale, maximumScale = .1, 4
	camera.scale = camera.scale + y*.1
	if camera.scale < minimumScale then
		camera.scale = minimumScale
	elseif camera.scale > maximumScale then
		camera.scale = maximumScale
	end
end

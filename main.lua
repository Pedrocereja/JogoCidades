function love.load()
    Object = require "libs.classic"
    require "Scene"
	require "handlers.collisionHandler"
	local Camera = require "handlers.Camera"
	--require "handlers.Dijkstra"

	camera = Camera()
    camera:setFollowLerp(0.2)

	scene = Scene()
	onMouse = {} --objeto seguindo o mouse

	scene:setBackground("images/cartographypack/Textures/parchmentBasic.png")
	scene:newBuilding(50, 200, 200)
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
end

function love.wheelmoved(x, y)
	camera.scale = camera.scale + y*.1
	if camera.scale < .1 then camera.scale = .1 elseif camera.scale > 4 then camera.scale=4 end
end

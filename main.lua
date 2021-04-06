function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest") --não interpola os desenhos, evitando blurry na pixel art

    Object = require "libs.classic"
    require "classes.populacao"
    require "classes.torta"
    require "classes.caminho"
    require "handlers.gerenciadorMundo"
	require "handlers.collisionHandler"
	local Camera = require "handlers.Camera"
	--require "handlers.menorCaminho"
    require "mapa"

	camera = Camera()
    camera:setFollowLerp(0.2)

	mundo = Mundo()
	onMouse = {} --objeto seguindo o mouse

    --desenha uma torta inicial no meio da tela e a popula com 3 habitantes
    local width, height = love.graphics.getDimensions()
    local torta = Torta(width/2, height/2)
    local pessoa = Populacao(torta)
    local pessoa1 = Populacao(torta)
    local pessoa2 = Populacao(torta)
    mundo:inserir(pessoa, "UI")
    mundo:inserir(pessoa1, "UI")
    mundo:inserir(pessoa2, "UI")
    mundo:inserir(torta, "torta")
    camera:follow(width/2, height/2)
end

function love.draw()
	camera:attach()

	draw_map()
	mundo:draw()

    camera:detach()
end

function love.update(dt)
	camera:update(dt)
	camera:newmove(dt, 700)
	mundo:update(dt)
end

function love.mousepressed(x, y, button)
	x, y = camera:toWorldCoords(x, y)
	if button == 1 then
		tortaColidida = mundo:tortaCollision(x, y)
		if tortaColidida then
			if #onMouse==0 then
				local torta = Torta(tortaColidida.x, tortaColidida.y)
				local caminho = Caminho(tortaColidida, torta)
				mundo:inserir(torta, "UI")
				mundo:inserir(caminho, "UI")
				onMouse[1] = torta
				onMouse[2] = caminho
			elseif #onMouse>0 and tortaColidida.x==onMouse[1].xorigin and tortaColidida.y==onMouse[1].yorigin then
				onMouse[1].r = onMouse[1].r-10
				if onMouse[1].r < 10 then onMouse[1].r = 50 end
			elseif #onMouse>0 and tortaColidida.x~=onMouse[1].xorigin or tortaColidida.y~=onMouse[1].yorigin then
				onMouse[1].xorigin, onMouse[1].yorigin, onMouse[1].r = tortaColidida.x, tortaColidida.y, 50
				onMouse[2]:new(onMouse[1], tortaColidida)
			end
		elseif not tortaColidida then
			if #onMouse>0 and not mundo:tortaCollision(onMouse[1].x, onMouse[1].y, onMouse[1].r) then
				mundo:remove(onMouse[1])
				mundo:remove(onMouse[2])
				mundo:inserir(onMouse[1], "torta")
				mundo:inserir(onMouse[2], "caminho")
		   		local pessoa = Populacao(onMouse[1])
		   		mundo:inserir(pessoa, "UI")
				onMouse = {}
			end
		end
	elseif button ==2 then
		while #onMouse>0 do
			mundo:remove(onMouse[#onMouse])
			table.remove(onMouse, #onMouse)
		end
	end
end

function love.mousemoved(x, y)
	for i,v in ipairs(mundo.tortas) do
		v:showInfo(x, y)
	end
end

function love.wheelmoved(x, y)
	camera.scale = camera.scale + y*.1
	if camera.scale < .1 then camera.scale = .1 end
	print(camera.scale)
end

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
	onMouse = 0 --objeto seguindo o mouse

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
		--se clicar em uma torta, você pode posicionar uma torta nova
		if onMouse == 0 then
			local tcolididaMouse = mundo:tortaCollision(x, y)
			if tcolididaMouse then
				local torta = Torta(tcolididaMouse.x, tcolididaMouse.y)
				local caminho = Caminho(tcolididaMouse, torta)
				mundo:inserir(torta, "UI")
				mundo:inserir(caminho, "UI")
				onMouse = torta
				onMouse.caminho = caminho
			end
		elseif onMouse ~= 0 then
			local tcolididaMouse = mundo:tortaCollision(x,y)
			if not mundo:tortaCollision(x, y, onMouse.r) then --se contrução não colide
				mundo:remove(onMouse.caminho)
				mundo:inserir(onMouse.caminho, "caminho")
				onMouse.caminho = nil
				mundo:remove(onMouse)
				mundo:inserir(onMouse, "torta")
		   		local pessoa = Populacao(onMouse)
		   		mundo:inserir(pessoa, "UI")
				onMouse = 0
			elseif (tcolididaMouse)and(tcolididaMouse.x==onMouse.xorigin)and(tcolididaMouse.y==onMouse.yorigin) then --se construção colide com sua base reduz tamanho
				onMouse.r = onMouse.r-10
				if onMouse.r < 10 then onMouse.r = 50 end
			elseif (tcolididaMouse) then --se construção colide com não base "rebaseia"
				if (tcolididaMouse.x~=onMouse.xorigin)or(tcolididaMouse.y~=onMouse.yorigin) then
					onMouse.xorigin, onMouse.yorigin, onMouse.r = tcolididaMouse.x, tcolididaMouse.y, 50
					onMouse.caminho:new(onMouse, tcolididaMouse)
				end
			elseif not tcolididaMouse then --blink()
				print("TODO construção piscar em vermelho quando suas bordas colidem mas o mouse não")
			end
	   	end
	elseif button ==2 then
		--limpa construção no mouse
		if onMouse ~= 0 then
	   		mundo:remove(onMouse)
			mundo:remove(onMouse.caminho)
			onMouse.caminho = nil
			onMouse = 0
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

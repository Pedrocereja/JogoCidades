function love.load()
    Object = require "libs.classic"
    require "classes/populacao"
    require "classes/torta"
    require "handlers/colisao"
    require "handlers/gerenciadorMundo"
    --require "mapa"

	onMouse = 0 --objeto seguindo o mouse

    local width, height = love.graphics.getDimensions()
    local torta = Torta(width/2, height/2)
    local pessoa = Populacao(torta)
    local pessoa1 = Populacao(torta)
    local pessoa2 = Populacao(torta)
    insMundo(pessoa, "noFis")
    insMundo(pessoa1, "noFis")
    insMundo(pessoa2, "noFis")
    insMundo(torta, "fisTorta")
end

function love.draw()
	--draw_map()
    for i,v in ipairs(draws) do
    	--print(i,v)
        v:draw()
    end
end

function love.update()
	for i,v in ipairs(updates) do
		v:update()
	end
end

function love.mousepressed(x, y, button)
	if button == 1 then
		if onMouse == 0 then
			local aux = checkCollisions(x, y)
			if aux then
				local torta = Torta(aux.x, aux.y)
				insMundo(torta, "noFis")
				onMouse = torta
			end
		else
			local aux = checkCollisions(x, y, onMouse.r)
			if not aux then
				rmMundo(onMouse)
				insMundo(onMouse, "fisTorta")
		   		local pessoa = Populacao(onMouse)
		   		insMundo(pessoa, "noFis")
				onMouse = 0
			elseif (aux.x==onMouse.xorigin)and(aux.y==onMouse.yorigin) then
				onMouse.r = onMouse.r-10
				if onMouse.r < 10 then onMouse.r = 50 end
			else
				onMouse.xorigin, onMouse.yorigin, onMouse.r = aux.x, aux.y, 50
			end
	   	end
	elseif button ==2 then
		if onMouse ~= 0 then
	   		rmMundo(onMouse)
			onMouse = 0
		end
	end
end

function love.keypressed(key)
	mapScroll(key)
end

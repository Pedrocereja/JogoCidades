function love.load()
    Object = require "libs.classic"
    require "classes/populacao"
    require "classes/torta"
    require "handlers/gerenciadorMundo"
    --require "mapa"

	onMouse = 0 --objeto seguindo o mouse

    --desenha uma torta inicial no meio da tela e a popula com 3 habitantes
    local width, height = love.graphics.getDimensions()
    local torta = Torta(width/2, height/2)
    local pessoa = Populacao(torta)
    local pessoa1 = Populacao(torta)
    local pessoa2 = Populacao(torta)
    insMundo(pessoa, "UI")
    insMundo(pessoa1, "UI")
    insMundo(pessoa2, "UI")
    insMundo(torta, "torta")
end

function love.draw()
	--draw_map()
    for i,v in ipairs(draws) do
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
		--se clicar em uma torta, você pode posicionar uma torta nova
		if onMouse == 0 then
			local aux = tortaCollision(x, y)
			if aux then
				local torta = Torta(aux.x, aux.y)
				insMundo(torta, "UI")
				onMouse = torta
			end
		elseif onMouse ~= 0 then
			local aux = tortaCollision(x, y, onMouse.r)
			local aux1 = tortaCollision(x,y)
			if not aux then --se contrução não colide
				rmMundo(onMouse)
				insMundo(onMouse, "torta")
		   		local pessoa = Populacao(onMouse)
		   		insMundo(pessoa, "UI")
				onMouse = 0
			elseif (aux1)and(aux1.x==onMouse.xorigin)and(aux1.y==onMouse.yorigin) then --se construção colide com sua base reduz tamanho
				onMouse.r = onMouse.r-10
				if onMouse.r < 10 then onMouse.r = 50 end
			elseif (aux1) then --se construção colide com não base "rebaseia"
				if (aux1.x~=onMouse.xorigin)or(aux1.y~=onMouse.yorigin) then
					onMouse.xorigin, onMouse.yorigin, onMouse.r = aux1.x, aux1.y, 50
				end
			elseif not aux1 then --blink()
				print("TODO construção piscar em vermelho quando suas bordas colidem mas o mouse não")
			end
	   	end
	elseif button ==2 then
		--limpa construção no mouse
		if onMouse ~= 0 then
	   		rmMundo(onMouse)
			onMouse = 0
		end
	end
end

function love.keypressed(key)
	mapScroll(key)
end

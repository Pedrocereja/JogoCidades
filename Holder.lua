---@diagnostic disable: undefined-global
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
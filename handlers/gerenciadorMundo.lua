--Essa biblioteca mantém registro dos objetos existentes no mundo, desenhando-os e movendo-os como necessário.
--Além disso, age como detector de colisões básicos para contornos retangulares,
--mas não os resolve.

updates = {} --lista de objetos com propriedade ".update"
draws = {} --lista de objetos com propriedade ".draw"
tortas = {}
caminhos = {}
--terreno = {}

function insMundo(Obj, layer)
	--Cria o objeto no mundo do jogo, em uma das seguintes layers: "torta", "pessoa" "UI"
	if (layer=="torta") then
	    table.insert(tortas, Obj)
	    table.insert(draws, Obj)
		Obj.itortas = #tortas --as 'i-variaveis' mantém no objeto o registro de sua posição nas tabelas do mundo
		Obj.idraws = #draws
	elseif (layer=="UI") then
		table.insert(updates, Obj)
	    table.insert(draws, Obj)
		Obj.iupdates = #updates
		Obj.idraws = #draws
	elseif (layer=="noFis") then
		table.insert(updates, Obj)
	    table.insert(draws, Obj)
		Obj.iupdates = #updates
		Obj.idraws = #draws
	elseif (layer=="path") then
		table.insert(caminhos, Obj)
	    table.insert(draws, Obj)
		Obj.icaminhos = #updates
		Obj.idraws = #draws
	else print("Erro na função insMundo: layer não existente")
	end
end

function rmMundo(Obj)
	--Remove o objeto do mundo
	if (Obj.iupdates~=nil) then
		table.remove(updates, Obj.iupdates)
		for i=Obj.iupdates,#updates do --atualiza 'i-variavel' dos demais componentes da tabela
			updates[i].iupdates=updates[i].iupdates-1
		end
		Obj.iupdates = nil --limpa variável para o GC
	end
	if (Obj.idraws~=nil) then
		table.remove(draws, Obj.idraws)
		for i=Obj.idraws,#draws do
			draws[i].idraws=draws[i].idraws-1
		end
		Obj.iupdates = nil
	end
	if (Obj.itortas~=nil) then
		table.remove(tortas, Obj.itortas)
		for i=Obj.itortas,#tortas do
			tortas[i].itortas=tortas[i].itortas-1
		end
		Obj.itortas = nil
	end
	if (Obj.icaminhos~=nil) then
		table.remove(tortas, Obj.icaminhos)
		for i=Obj.icaminhos,#tortas do
			caminhos[i].icaminhos=caminhos[i].icaminhos-1
		end
		Obj.icaminhos = nil
	end
end

function CheckCollision(obj1, obj2)
	-- Collision detection function;
	-- Returns true if two boxes overlap, false if they don't;
	local x1, y1, w1, h1 = obj1.x-obj1.r, obj1.y-obj1.r, 2*obj1.r, 2*obj1.r --Converte as coordenadas do objeto para coordenadas
	local x2, y2, w2, h2 = obj2.x-obj2.r, obj2.y-obj2.r, 2*obj2.r, 2*obj2.r --do canto superior esquerdo, lagura e comprimento de seu retângulo
	return x1 < x2+w2 and
	    x2 < x1+w1 and
        y1 < y2+h2 and
        y2 < y1+h1
end

function tortaCollision(x, y, r)
	--Checa se o quadrado nas coordenadas (x,y) e "raio" r colide com alguma torta;
	--Retorna a torta que foi colidida ou falso;
	local r = r or 1
	local Obj2 = Torta(x, y, r)
	for i=1,#tortas do
    	if CheckCollision(tortas[i], Obj2) then
    		return tortas[i] end
        end
return false end
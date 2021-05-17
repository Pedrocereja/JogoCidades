--Essa biblioteca mantém registro dos objetos existentes no cenário,
--desenhando-os e movendo-os como necessário.

Mundo = Object:extend()

function Mundo:new()
	self.updates = {}

	self.bg = {}
	self.map = {}
	self.caminhos = {}
	self.pessoas = {}
	self.builds = {}
	self.UI = {}
	self.draws = {}

	self.tortas = {}
	self.caminhos = {}
end

function Mundo:inserir(Obj, layer)
	--Cria o objeto no mundo do jogo, em uma das seguintes layers: "torta", "pessoa" "UI"
	if (layer=="torta") then
	    table.insert(mundo.tortas, Obj)
	    table.insert(self.draws, Obj)
		Obj.itortas = #mundo.tortas --as 'i-variaveis' mantém no objeto o registro de sua posição nas tabelas do mundo
		Obj.idraws = #self.draws
	elseif (layer=="UI") then
		table.insert(self.updates, Obj)
	    table.insert(self.draws, Obj)
		Obj.iupdates = #self.updates
		Obj.idraws = #self.draws
	elseif (layer=="noFis") then
		table.insert(self.updates, Obj)
	    table.insert(self.draws, Obj)
		Obj.iupdates = #self.updates
		Obj.idraws = #self.draws
	elseif (layer=="caminho") then
		table.insert(self.caminhos, Obj)
	    table.insert(self.draws, Obj)
		Obj.icaminhos = #self.updates
		Obj.idraws = #self.draws
	else print("Erro na função insMundo: layer não existente")
	end
end

function Mundo:remove(Obj)
	--Remove o objeto do mundo
	if (Obj.iupdates~=nil) then
		table.remove(self.updates, Obj.iupdates)
		for i=Obj.iupdates,#self.updates do --atualiza 'i-variavel' dos demais componentes da tabela
			self.updates[i].iupdates=self.updates[i].iupdates-1
		end
		Obj.iupdates = nil --limpa variável para o GC
	end
	if (Obj.idraws~=nil) then
		table.remove(self.draws, Obj.idraws)
		for i=Obj.idraws,#self.draws do
			self.draws[i].idraws=self.draws[i].idraws-1
		end
		Obj.iupdates = nil
	end
	if (Obj.itortas~=nil) then
		table.remove(mundo.tortas, Obj.itortas)
		for i=Obj.itortas,#mundo.tortas do
			mundo.tortas[i].itortas=mundo.tortas[i].itortas-1
		end
		Obj.itortas = nil
	end
	if (Obj.icaminhos~=nil) then
		table.remove(mundo.tortas, Obj.icaminhos)
		for i=Obj.icaminhos,#mundo.tortas do
			self.caminhos[i].icaminhos=self.caminhos[i].icaminhos-1
		end
		Obj.icaminhos = nil
	end
end

function Mundo:draw()
	for i,v in ipairs(self.draws) do
        v:draw()
    end
end

function Mundo:update(dt)
	for i,v in ipairs(self.updates) do
		v:update(dt)
	end
end

function Mundo:tortaCollision(x, y, r)
	--Checa se o quadrado nas coordenadas (x,y) e "raio" r colide com alguma torta;
	--Retorna a torta que foi colidida ou falso;
	local r = r or 1
	local Obj2 = Torta(x, y, r)
	for i=1,#self.tortas do
    	if CheckCollision(self.tortas[i], Obj2) then
    		return self.tortas[i] end
        end
return false end

------------------------------------------------
require "colissionHandler"
require "renderer"
require "miningHandler"

Scene = Object:extend()

function Scene:new()
	self.background = {} --bgImage(sempre na posição 1), recursos, caminhos
	self.middleground = {} --construcoes, pessoas
	self.foreground = {} --UI
	self.draws = {self.background, self.middleground, self.foreground}

	self.update = {}
end

function Scene:setBackground(imagePath)
	local bgImage = love.graphics.newImage(imagePath)
	self.background["bg"] = bgImage
end

function Scene:newBuilding(type, x, y)
	local building
	for key, value in pairs(buildingTypes) do
		if type == value then
			building = value(x, y)
			break
		end
	end
	table.insert(self.middleground, building)
	building.position["middleground"] = #self.middleground
return building end

function Scene:newPerson(x, y)
	
end

function Scene:newPath()
	
end

function Scene:newResource(type, x, y)
	
end

function Scene:update(dt)
	for key, object in pairs(self.update) do
		object.update()
	end
end

function Scene:draw()
	love.graphics.draw(self.background["bg"], 0, 0)
	for k, layer in pairs(self.draws) do
		for i, object in pairs(layer) do
			object.draw()
		end
	end
end
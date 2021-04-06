--Essa biblioteca mantém registro dos objetos existentes no mundo,
--desenhando-os e movendo-os como necessário.

Mundo = Object:extend()

function Mundo:new()
	self.updates = {}
	self.desenhos = {}
	self.tortas = {}
	self.caminhos = {}
end

function Mundo:inserir(Obj, layer)
	--Cria o objeto no mundo do jogo, em uma das seguintes layers: "torta", "pessoa" "UI"
	if (layer=="torta") then
	    table.insert(mundo.tortas, Obj)
	    table.insert(self.desenhos, Obj)
		Obj.itortas = #mundo.tortas --as 'i-variaveis' mantém no objeto o registro de sua posição nas tabelas do mundo
		Obj.idraws = #self.desenhos
	elseif (layer=="UI") then
		table.insert(self.updates, Obj)
	    table.insert(self.desenhos, Obj)
		Obj.iupdates = #self.updates
		Obj.idraws = #self.desenhos
	elseif (layer=="noFis") then
		table.insert(self.updates, Obj)
	    table.insert(self.desenhos, Obj)
		Obj.iupdates = #self.updates
		Obj.idraws = #self.desenhos
	elseif (layer=="path") then
		table.insert(self.caminhos, Obj)
	    table.insert(self.desenhos, Obj)
		Obj.icaminhos = #self.updates
		Obj.idraws = #self.desenhos
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
		table.remove(self.desenhos, Obj.idraws)
		for i=Obj.idraws,#self.desenhos do
			self.desenhos[i].idraws=self.desenhos[i].idraws-1
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
	for i,v in ipairs(self.desenhos) do
        v:draw()
    end
end

function Mundo:update(dt)
	for i,v in ipairs(self.updates) do
		v:update(dt)
	end
end
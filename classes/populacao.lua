Populacao = Object:extend()

function Populacao:new(home)
	-- Habitantes de uma torta "home"
	self.home = home
	self.x = home.x
	self.y = home.y
	self.r = 5
	self.velocidade = 1
end

function Populacao:draw()
	love.graphics.circle("fill", self.x, self.y, self.r)
end

function Populacao:update()
	--Entra na cidade-casa quando colidir com ela
	local aux = tortaCollision(self.x, self.y, self.r)
	if aux==self.home then
		table.insert(aux.habitantes, self)
		rmMundo(self)
	else self:moveto(self.home) --se não estiver na cidade-casa, vai para ela
	end
end

function Populacao:moveto(destino)
	local dx = destino.x-self.x
	local dy = destino.y-self.y
	local magnitude = math.sqrt(dx^2+dy^2)
	self.x = self.x + self.velocidade*dx/magnitude 
	self.y = self.y + self.velocidade*dy/magnitude
end
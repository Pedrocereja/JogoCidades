Populacao = Object:extend()

function Populacao:new(home)
	self.image = love.graphics.newImage("/images/pessoa.png")
	self.home = home
	self.x = home.x
	self.y = home.y
	self.r = 9
	self.velocidade = 1
end

function Populacao:draw()
	love.graphics.draw(self.image, self.x, self.y)
end

function Populacao:update()
	--Entra na cidade-casa quando colidir com ela
--	local cidadeColidida = mundo:tortaCollision(self.x, self.y, self.r)
--	if cidadeColidida==self.home then
--		table.insert(cidadeColidida.populacao, self)
--		mundo:remove(self)
--	else self:moveto(self.home) --se não estiver na cidade-casa, vai para ela
--	end
end

function Populacao:moveto(destino, dt)
	local dx = destino.x-self.x
	local dy = destino.y-self.y
	local magnitude = math.sqrt(dx^2+dy^2)
	self.x = self.x + self.velocidade*dx/magnitude*dt
	self.y = self.y + self.velocidade*dy/magnitude*dt
end
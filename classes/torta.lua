Torta = Object:extend()

function Torta:new(x, y, r)
    self.x = x
    self.y = y
	self.r = r or 50
	self.xorigin = x
	self.yorigin = y
	self.populacao = {}
end

function Torta:update(dt)
	self.x, self.y = camera:getMousePosition()
end

function Torta:draw()
    love.graphics.circle("fill", self.x, self.y, self.r)

	--desenho dos habitantes no canto inferior esquerdo da cidade
	for i,habitante in ipairs(self.populacao) do
		love.graphics.draw(habitante.image, self.x-self.r+habitante.r+15*(i-1), self.y+self.r-habitante.r)
	end
end

function Torta:showInfo(x, y)
	local torta = Torta(x, y, 1)
	if CheckCollision(self, torta) and self.mostrador==nil then
		--self.mostrador = "Não há recursos"
		--print("Não há recursos")
	end
end
Torta = Object:extend()

function Torta:new(x, y, r)
    self.x = x
    self.y = y
	self.r = r or 50
	self.xorigin = x
	self.yorigin = y
	self.habitantes = {}
end

function Torta:update(dt)
	self.x, self.y = love.mouse.getPosition()
end

function Torta:draw()
    love.graphics.circle("fill", self.x, self.y, self.r)
	love.graphics.line(self.x, self.y, self.xorigin, self.yorigin)
	--x, y, xf, yf = self.x, self.y, self.xorigin, self.yorigin --guardar dois pontos para marcar a aresta
	love.graphics.setColor(0,0,255)
	for i,v in ipairs(self.habitantes) do
		love.graphics.circle("fill", self.x-self.r+v.r+12*(i-1), self.y+self.r-v.r, v.r)
	end
	love.graphics.setColor(255,255,255)
end

function Torta:showInfo(x, y)
	local torta = Torta(x, y, 1)
	if CheckCollision(self, torta) and self.mostrador==nil then
		--self.mostrador = "Não há recursos"
		--print("Não há recursos")
		--elseif then
	end
end
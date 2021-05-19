Torta = Object:extend()

function Torta:new(x, y)
    self.x = x
    self.y = y
	self.w = 128
	self.h = 64
	self.xorigin = x
	self.yorigin = y
	self.populacao = {}
	self.image = tile["castle"]
end

function Torta:update(dt)
	self.x, self.y = camera:getMousePosition()
end

function Torta:draw()
    love.graphics.draw(tileset, self.image, self.x, self.y)

	--desenho dos habitantes no canto inferior esquerdo da cidade
	for i,habitante in ipairs(self.populacao) do
		love.graphics.draw(habitante.image, self.x+habitante.r+15*(i-1), self.y+self.h-habitante.r)
	end

	if debugMode then
		love.graphics.setColor(255,0,0)
		love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
		love.graphics.setColor(255,255,255)
	end
end

function Torta:showInfo(x, y)
end
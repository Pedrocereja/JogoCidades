Caminho = Object:extend()

function Caminho:new(xo, yo, xf, yf)
    self.xo = xo
    self.yo = yo
	self.xf = xf
	self.yf = yf
	self.habitantes = {}
end

function Caminho:draw()
	love.graphics.line(self.xo, self.yo, self.xf, self.yf)
end

function Caminho:update(dt)
	self.xf, self.yf = camera:getMousePosition()
end
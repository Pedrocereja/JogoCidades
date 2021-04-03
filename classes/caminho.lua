Caminho = Object:extend()

function Caminho:new(T1, T2)
    self.T1 = T1
    self.T2 = T2
	--self.habitantes = {}
end

function Caminho:draw()
	love.graphics.line(self.T1.x, self.T1.y, self.T2.x, self.T2.y)
end

function Caminho:update(dt)
	--nothing
end
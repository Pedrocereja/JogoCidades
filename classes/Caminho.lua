Caminho = Object:extend()

function Caminho:new(tortaInicio, tortaFim)
    self.inicio = tortaInicio
    self.fim = tortaFim
end

function Caminho:draw()
	love.graphics.line(self.inicio.x, self.inicio.y, self.fim.x, self.fim.y)
end

function Caminho:update(dt)
	--nothing
end
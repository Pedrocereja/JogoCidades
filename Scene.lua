require "classes.Torta"
--TODO scripts:
--require "colissionHandler"
--require "renderer"
--require "miningHandler"

Scene = Object:extend()

function Scene:new()
	self.background = {} --bgImage(sempre na posição 1), recursos, caminhos
	self.middleground = {} --construcoes, pessoas
	self.foreground = {} --UI
	self.draws = {self.background, self.middleground, self.foreground}

	self.updatable = {}
end

function Scene:setBackground(imagePath)
	local bgImage = love.graphics.newImage(imagePath)
	self.background["bg"] = bgImage
end

function Scene:newBuilding(r, x, y)
	local building = Torta(r, x, y)
	table.insert(self.middleground, building)
	building.position = {}
	building.position["middleground"] = #self.middleground
return building end

function Scene:newPerson(x, y)
	
end

function Scene:newPath()
	
end

function Scene:newResource(type, x, y)
	
end

function Scene:update(dt)
	for key, object in ipairs(self.updatable) do
		object.update()
	end
end

function Scene:draw()
	love.graphics.draw(self.background["bg"], 0, 0)
	for k, layer in ipairs(self.draws) do
		for i, object in ipairs(layer) do
			object:draw()
		end
	end
end
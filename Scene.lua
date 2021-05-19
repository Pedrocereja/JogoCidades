require "classes.Torta"
require "classes.Populacao"
require "classes.Caminho"
require "spacialPartition"
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

function Scene:setBackgroundAndGridSize(imagePath)
	local bgImage = love.graphics.newImage(imagePath)
	self.background["bg"] = bgImage

	self.grid = Grid(bgImage:getHeight(), bgImage:getWidth()) --TODO deixar grid independendte do BG
end

local function insertOnDraws(self, obj, layer)
	if obj.position == nil then
		obj.position = {}
	end
	if layer == "background" then
		table.insert(self.background, obj)
		obj.position["background"] = #self.background
	elseif layer == "middleground" then
		table.insert(self.middleground, obj)
		obj.position["middleground"] = #self.middleground
	elseif layer == "foreground" then
		table.insert(self.foreground, obj)
		obj.position["foreground"] = #self.foreground
	end
end

local function insertOnUpdatable(self, obj)
	if obj.position == nil then
		obj.position = {}
	end
	table.insert(self.updatable, obj)
	obj.position["updatable"] = #self.updatable
end

function Scene:newBuilding(r, x, y)
	local building = Torta(r, x, y)
	self.grid:insertItem(building)
	insertOnDraws(self, building, "middleground")
return building end

function Scene:newPerson(home)
	local person = Populacao(home)
	self.grid.insertItem(person)
	insertOnDraws(self, person, "middleground")
	insertOnUpdatable(self, person)
return person end

function Scene:newPath(origin, destination)
	local path = Caminho(origin, destination)
	self.grid.insertItem(path)
	insertOnDraws(self, path, "background")
return path end

function Scene:newResource(type, x, y)
	
end

local function updateItensIndexing(table, tableName, position)
	for i = position, #table do
		table[i].position[tableName] = table[i].position[tableName] - 1
	end
end

function Scene:remove(obj)
	if obj.position["background"] ~= nil then
		position = table.remove(self.background, obj.position["background"])
		updateItensIndexing(self.background, "background", position)
	end
	if obj.position["middleground"] ~= nil then
		position = table.remove(self.middleground, obj.position["middleground"])
		updateItensIndexing(self.middleground, "middleground", position)
	end
	if obj.position["foreground"] ~= nil then
		position = table.remove(self.foreground, obj.position["foreground"])
		updateItensIndexing(self.foreground, "foreground", position)
	end
	if obj.position["updatable"] ~= nil then
		position = table.remove(self.updatable, obj.position["updatable"])
		updateItensIndexing(self.updatable, "updatable", position)
	end
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

function Scene:whatDidIClick(x, y)
	local item = self.grid:getItemOnPosition(x, y)
return item end
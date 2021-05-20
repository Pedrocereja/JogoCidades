Grid = Object:extend()

local numberOfPartitions = 10 --arbitrário

local function initializeSegmentation()
    local partitions = {}
    local numberOfXPartitions = numberOfPartitions  --numero arbitrário
    local numberOfYPartitions = numberOfPartitions
    for i = 1, numberOfXPartitions do
        local colum = {}
        partitions[i] = colum
        for j = 1, numberOfYPartitions do
            local space = {}
            partitions[i][j] = space
        end
    end
return partitions end

function Grid:new(height, width)
    self.partitions = initializeSegmentation()
    self.partitionW = width/numberOfPartitions
    self.partitionH = height/numberOfPartitions
end

local function isInGridRange(self, X, Y)
    if self.partitions[X] == nil then
        print("Out of range")
        return
    elseif self.partitions[X][Y] == nil then
        print("Out of range")
        return
    end
end

local function havePositionAndArea(item)
    local havePosition = (item.x ~= nil) and (item.y ~= nil)
    local haveArea = (item.r ~= nil) or ((item.w ~= nil) and (item.h ~= nil))
return havePosition and haveArea end

local function getLocationPartition(self, x, y)
    local partitionX = 1 + math.floor(x / self.partitionW)
    local partitionY = 1 + math.floor(y / self.partitionH)
    if not isInGridRange(self, partitionX, partitionY) then
        print("Location is not in grid range")
        return
    end
return partitionX, partitionY end

function Grid:insertItem(item)
    if not havePositionAndArea(item) then
        print("Item does not have all the necessary properties for entering the grid: 'x, y, r' or 'x, y, w, h'")
        return
    end
    local X, Y = getLocationPartition(self, item.x, item.y)
    table.insert(self.partitions[X][Y], item)
end

function Grid:updateItem(item, xo, yo, xf, yf)
    
end

function Grid:removeItem(item)
    local X, Y = getLocationPartition(self, item.x, item.y)
    for i, value in ipairs(self.partitions[X][Y]) do
        if item == value then
            table.remove(self.partitions[X][Y], i)
            return
        end
    end
    print("Item not found")
end

local function positionsCollide(x1, y1, x2, y2, w2, h2)
	return x1 > x2 and
	    x1 < x2+w2 and
        y1 > y2 and
        y1 < y2+h2
end

function Grid:getItemOnPosition(x, y)
    local X, Y = getLocationPartition(self, x, y)
    for i, storedItem in ipairs(self.partitions[X][Y]) do
        if positionsCollide(x, y, storedItem.x, storedItem.y, storedItem.w, storedItem.h) then
            return storedItem
        end
    end
end

function Grid:drawGrid()
    for i = 1, numberOfPartitions do
        love.graphics.line(i*self.partitionW, 0, i*self.partitionW, self.partitionH*numberOfPartitions)
        love.graphics.line(0, i*self.partitionH, self.partitionW*numberOfPartitions, i*self.partitionH)
    end
end
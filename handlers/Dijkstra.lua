Dijkstra = Object:extend()

function Dijkstra:new(origem)
	self.nodos = {}
	self.arestas = {}
	self.origem = origem
	self.distances = {}
	self.lastVisited = {}
	self.unvisited = {}
end

function Dijkstra:update(nodos, arestas)
	self.nodos = nodos
	self.arestas = arestas
end

function Dijkstra:menorCaminho(alvo)--, tipo)
	self:setInitialValues()
	self:setLastVisited()
	local caminho = {}
	local alvo = alvo
	if self.lastVisited[alvo]~=nil and alvo~=self.origem then
		while alvo~=nil do
			table.insert(caminho, alvo)
			alvo = self.lastVisited[alvo]
		end
	end
	caminho = Dijkstra:inverterOrdem(caminho)
return caminho end

function Dijkstra:setInitialValues()
	for i,v in ipairs(self.nodos) do
		self.distances[v] = math.huge
		self.lastVisited[v] = nil
		table.insert(self.unvisited, v)
		v.iunvisited = #self.unvisited
	end
	self.distances[self.origem] = 0
end

function Dijkstra:setLastVisited()
	while #self.unvisited>0 do
		local actualNode = self:getShorterNode()
		self:removeFromUnvisited(actualNode)
		for i, vizinho in pairs(self:vizinhos(actualNode)) do
			local distVizinho = self.distances[actualNode] + self:getDistance(actualNode, vizinho)
			if distVizinho < self.distances[vizinho] then
				self.lastVisited[vizinho] = actualNode
				self.distances[vizinho] = distVizinho
			end
		end
	end
end

function Dijkstra:getShorterNode()
	local closerNode = self.unvisited[#self.unvisited]
	for i,nodo in pairs(self.unvisited) do
		if self.distances[nodo]<self.distances[closerNode] then
			closerNode = nodo
		end
	end
return closerNode end

function Dijkstra:removeFromUnvisited(nodo)
	table.remove(self.unvisited, nodo.iunvisited)
	for i=nodo.iunvisited,#self.unvisited do
		self.unvisited[i].iunvisited=self.unvisited[i].iunvisited-1
	end
end
   
function Dijkstra:vizinhos(nodo)
	local  adjacentes = {}
	for i,aresta in ipairs(self.arestas) do
		if aresta.inicio == nodo then
			table.insert(adjacentes, aresta.fim)
		elseif aresta.fim == nodo then
			table.insert(adjacentes, aresta.inicio)
		end 
	end
return adjacentes end

function Dijkstra:getDistance(T1, T2)
	local dist = (T1.x-T2.x)^2+(T1.y-T2.y)^2
	dist = math.sqrt(dist)
return dist end

function Dijkstra:inverterOrdem(table)
	local copy = Dijkstra:makeShallowCopy(table)
	for i, value in ipairs(table) do
		table[i] = copy[#table - i + 1]
	end
return table end

function Dijkstra:makeShallowCopy(table)
	local copy = {}
	for k,v in pairs(table) do
	  copy[k] = v
	end
	return copy
end
Dijkstra = Object:extend()

function Dijkstra:new(origem)
	self.nodos = self.shallowCopy(mundo.tortas)
	self.arestas = self.shallowCopy(mundo.caminhos)
	self.origem = origem
end

function Dijkstra:shallowCopy(table)
	local copy = {}
	for k,v in pairs(table) do
	  copy[k] = v
	end
	return copy
end

function Dijkstra:menorCaminho(alvo)--, tipo)
	local lastVisited = self.getLastVisited()
	local caminho = {}
	local alvo
	if lastVisited[alvo]~=nil and alvo~=self.origem then
		while alvo~=nil do
			table.insert(caminho, alvo)
			alvo = lastVisited[alvo]
		end
	end
	caminho = Dijkstra:inverterOrdem(caminho)
return caminho end

function Dijkstra:getLastVisited()
	local dist = {}
	local lastVisited = {}
	local unvisited = {}
	self:setInitialValues(dist, lastVisited, unvisited)
	while #unvisited>0 do
		local actualNode = self.getCloserNode(unvisited, dist)
		table.remove(unvisited, actualNode)
		for i, vizinho in pairs(self:vizinhos(actualNode)) do
			local distVizinho = dist[actualNode] + self:distance(actualNode, vizinho)
			if distVizinho < dist[vizinho] then
				lastVisited[vizinho] = actualNode
				dist[vizinho] = distVizinho
			end
		end
	end
return lastVisited end

function Dijkstra:setInitialValues(dist, lastVisited, unvisited)
	for i,v in ipairs(self.nodos) do
		dist[v] = math.huge
		lastVisited[v] = nil
		table.insert(unvisited, v)
	end
	dist[self.origem] = 0
end

function Dijkstra:getCloserNode(unvisitedNodes, distances)
	local closerNode = math.huge
	for i,nodo in pairs(unvisitedNodes) do
		if distances[nodo]<closerNode then
			closerNode = nodo
		end
	end
return closerNode end
   
function Dijkstra:vizinhos(nodo)
	local  adj = {} --constrói a tabela de nodos adjacentes ao atual
	for i,v in ipairs(self.arestas) do
		if v.inicio == nodo then
			table.insert(adj, v.fim)
		elseif v.fim == nodo then
			table.insert(adj, v.inicio)
		end 
	end
return adj end

function Dijkstra:distance(T1, T2)
	local dist = (T1.x-T2.x)^2+(T1.y-T2.y)^2
	dist = math.sqrt(dist)
return dist end

function Dijkstra:inverterOrdem(table)
	local copy = Dijkstra:shallowCopy(table)
	for i, value in ipairs(table) do
		table[i] = copy[#table - i + 1]
	end
return table end
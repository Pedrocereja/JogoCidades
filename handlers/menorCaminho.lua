local function shallow_copy(t)
	local copy = {}
	for k,v in pairs(t) do
	  copy[k] = v
	end
	return copy
end

local nodos = shallow_copy(mundo.tortas)
local arestas = shallow_copy(mundo.caminhos)

local function next_node(unvisited, distances)
	local unvisited_distances = {}
	for i,k in pairs(unvisited) do
		unvisited_distances[k] = distances[k]
	end
	for key, value in ipairs(nodos) do
		print(key, value.itortas)
	end
	local minval = math.min(unpack(unvisited_distances))
	--print(minval)
	local inv={}
	for k,v in pairs(unvisited_distances) do
	  inv[v]=k
	end
	--for index, value in pairs(unvisited_distances) do
		--print(index, value)
	--end
return inv[minval] end
   
local function vizinhos(nodo)
	local  adj = {} --constrói a tabela de nodos adjacentes ao atual
	for i,v in ipairs(arestas) do
		if v.inicio == nodo then
			table.insert(adj, v.fim)
		elseif v.fim == nodo then
			table.insert(adj, v.inicio)
		end 
	end
return adj end

local function distance(T1, T2)
	local dist = (T1.x-T2.x)^2+(T1.y-T2.y)^2
	dist = math.sqrt(dist)
return dist end

function menorCaminho(origem, alvo)--, tipo)
	-- Encontra o menor caminho entre duas tortas fornecidas

	local dist = {} --constrói a tabela de nodos adjacentes ao atual
	local lastVisited = {}
	local unvisited = {}  -- copy nodes from original table
	for i,v in ipairs(nodos) do
		dist[v] = math.huge
		lastVisited[v] = nil
		table.insert(unvisited, v)
	end
	dist[origem] = 0
	while #unvisited > 0 do
		local u = next_node(unvisited, dist)
		table.remove(unvisited, u)
		for i, v in pairs(vizinhos(u)) do
			local temp = dist[u] + distance(u,v)
			if temp < dist[v] then
				lastVisited[v] = u
				dist[v] = temp
			end
		end
	end
	
	-- gera caminho ate B
	local caminho = {}
	local u = alvo
	if lastVisited[u] ~= nil or u ~= origem then
		while u ~= nil do
			table.insert(caminho, u)
			u = lastVisited[u]
			--print(u)
		end
	end
return caminho end

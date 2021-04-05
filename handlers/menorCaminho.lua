local function shallow_copy(t)
	local t2 = {}
	for k,v in pairs(t) do
		t2[k] = v
	end
return t2 end

local nvst = shallow_copy(tortas) -- nodos não visitados
local mpath = {} -- tabela com nodo|peso|ult. visitado

local function minkey(initialtable)
	local orderedTable = {}
	orderedTable = unpack(initialtable)
	table.sort(orderedTable)
	local minval = orderedTable[1]
	local inv={}
	for k,v in pairs(initialtable) do
		inv[v]=k -- Dá problema quando temos valores repeteidos na tabela. Não vai rolar bem aqui
	end
return inv[minval] end

function menorCaminho(origem, alvo)--, tipo)
	-- Encontra o menor caminho entre duas tortas fornecidas

	local dist = {} --constrói a tabela de nodos adjacentes ao atual
	local lastVisited = {}
	local unvisited = {}  -- copy nodes from original table
	local distUnvisited = {}

	for i,v in ipairs(tortas) do
		dist[v] = math.huge
		distUnvisited[v] = math.huge
		lastVisited[v] = nil
		table.insert(unvisited, v)
	end
	local dist = {}
	dist[origem] = 0
	while #unvisited > 0 do
		local u = table.remove(unvisited, minkey(unvisited))
---@diagnostic disable-next-line: undefined-global
		for i, v in pair(vizinhos(u)) do
---@diagnostic disable-next-line: undefined-global
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
	if lastVisited[u] ~= nil or u == origem then
		while u ~= nil do
			table.insert(caminho, u)
			u = lastVisited[u]
		end
	end
return caminho end

local function vizinhos(nodo)
	local  adj = {} --constrói a tabela de nodos adjacentes ao atual
	for i,v in ipairs(caminhos) do
		if v.T1 == nodo then
			table.insert(adj, v.T2)
		elseif v.T2 == nodo then
			table.insert(adj, v.T1)
		end 
	end
return adj end

local function distance(T1, T2)
	local dist = (T1.x-T2.x)^2+(T1.y-T2.y)^2
	dist = math.sqrt(dist)
return dist end

local nvst = table.shallow_copy(tortas) -- nodos não visitados
local mpath = {} -- tabela com nodo|peso|ult. visitado

function menorCaminho(origem, alvo)--, tipo)
	-- Encontra o menor caminho entre duas tortas fornecidas

	local dist = {} --constrói a tabela de nodos adjacentes ao atual
	local lastVisited = {}
	local unvisited = {}  -- copy nodes from original table

	for i,v in ipairs(tortas) do
		dist[v] = math.huge
		lastVisited[v] = nil
		table.insert(unvisited, v)
	end
	dist[origem] = 0
	while #unvisited > 0 do
		u = table.remove(unvisited, minkey(unvisited))
		for i, v in pair(vizinhos(u)) do
			temp = dist[u] + distance(u,v)
			if temp < dist[v] then
				lastVisited[v] = u
				dist[v] = temp
			end
		end
	end
	
	-- gera caminho ate B
	caminho = {}
	u = alvo
	if lastVisited[u] ~= nil or u == source then
		while u ~= nil do
			table.insert(caminho, u)
			u = lastVisited[u]
	
	return caminho
end

local function table.shallow_copy(t)
  local t2 = {}
  for k,v in pairs(t) do
    t2[k] = v
  end
  return t2
end

local function minkey(initialtable)
	local minval = math.min(unpack(initialtable))
	local inv={}
	for k,v in pairs(initialtable) do
	  inv[v]=k
	end
	return inv[minval]
   end
   
local function vizinhos(nodo)
	local  adj = {} --constrói a tabela de nodos adjacentes ao atual
	for i,v in ipairs(caminhos) do
		if v.T1 == nodo then
			table.insert(adj, v.T2)
		elseif v.T2 == nodo then
			table.insert(adj, v.T1)
		end 
	end
end

local function distance(T1, T2)
	local dist = (T1.x-T2.x)^2+(T1.y-T2.y)^2
	dist = math.sqrt(dist)
return dist

local nvst = table.shallow_copy(tortas) -- nodos não visitados
local mpath = {} -- tabela com nodo|peso|ult. visitado

function menorCaminho(A, B)--, tipo)
	-- Encontra o menor caminho entre duas tortas fornecidas

	--local tipo = tipo or 1
	local  adj = {} --constrói a tabela de nodos adjacentes ao atual
	for i,v in ipairs(caminhos) do
		if v.T1 == A then
			table.insert(adj, v.T2)
		elseif v.T2 == A then
			table.insert(adj, v.T1)
		end 
	end

	for i,v in ipairs(adj) do
		if v.vst
	end
end

local function table.shallow_copy(t)
  local t2 = {}
  for k,v in pairs(t) do
    t2[k] = v
  end
  return t2
end
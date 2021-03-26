updates = {} --lista de objetos com propriedade ".update"
local iupdates = 1
draws = {} --lista de objetos com propriedade ".draw"
local idraws = 1
colisorTortas = {} --objetos a serem checados em colisões
local icolisorTortas = 1
pessoas = {} --pessoas em transito nas tortas
local ipessoas = 1
terreno = {}
local iterreno = 1

function insMundo(Obj, layer)
	--Cria o objeto no mundo do jogo, em uma das seguintes layers: "fisTorta", "fisPessoas" "noFis"
	if (layer=="fisTorta") then
	    table.insert(colisorTortas, Obj)
	    table.insert(draws, Obj)
		Obj.icolisorTortas = iupdates
		icolisorTortas = icolisorTortas+1
		Obj.idraws = idraws
		idraws = idraws+1
	elseif (layer=="noFis") then
		table.insert(updates, Obj)
	    table.insert(draws, Obj)
		Obj.iupdates = iupdates
		iupdates = iupdates+1
		Obj.idraws = idraws
		idraws = idraws+1
	else print("Erro na função insMundo: layer não existente")
	end
end

function rmMundo(Obj)
	--Remove o objeto do mundo
	if (Obj.iupdates~=nil) then
		table.remove(updates, Obj.iupdates)
		for i=Obj.iupdates,#updates do
			updates[i].iupdates=updates[i].iupdates-1
		end
		iupdates = iupdates-1
		Obj.iupdates = nil
	end
	if (Obj.idraws~=nil) then
		table.remove(draws, Obj.idraws)
		for i=Obj.idraws,#draws do
			draws[i].idraws=draws[i].idraws-1
		end
		idraws = idraws-1
		Obj.iupdates = nil
	end
	if (Obj.icolisorTortas~=nil) then
		table.remove(colisorTortas, Obj.icolisorTortas)
		for i=Obj.icolisorTortas,#colisorTortas do
			colisorTortas[i].icolisorTortas=colisorTortas[i].icolisorTortas-1
		end
		icolisorTortas = icolisorTortas-1
		Obj.icolisorTortas = nil
	end
end
Tile = Object:extend()

function Tile:new()
    self.quantidadeRecurso = {}
end

local function isNumber(n)
    return (type(n) == "number") and (math.floor(n) == n)
end

function Tile:extractResource(recurso, extractionSpeed, dt)
    local recursoExtraido = 0
    if self.quantidadeRecurso[recurso] == nil then
        print("Não há "..recurso.." aqui")
    elseif isNumber(self.quantidadeRecurso[recurso]) then
        recursoExtraido = extractionSpeed*dt
        self.quantidadeRecurso[recurso] = self.quantidadeRecurso[recurso] - recursoExtraido

        if self.quantidadeRecurso[recurso] <= 0 then
            recursoExtraido = recursoExtraido + self.quantidadeRecurso[recurso]
            self.quantidadeRecurso[recurso] = nil
        end
    end
return recursoExtraido end
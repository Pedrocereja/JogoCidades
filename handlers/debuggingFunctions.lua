debugging = true

function printTable(table)
    if debugging then
        for key, value in pairs(table) do
            print(table[key])
        end
    end
end

function bugPrint(texto)
    if debugging then
        print(texto)
    end    
end
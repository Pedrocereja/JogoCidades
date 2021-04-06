function CheckCollision(obj1, obj2)
	-- Collision detection function;
	-- Returns true if two boxes overlap, false if they don't;
	local x1, y1, w1, h1 = obj1.x-obj1.r, obj1.y-obj1.r, 2*obj1.r, 2*obj1.r --Converte as coordenadas do objeto para coordenadas
	local x2, y2, w2, h2 = obj2.x-obj2.r, obj2.y-obj2.r, 2*obj2.r, 2*obj2.r --do canto superior esquerdo, lagura e comprimento de seu retângulo
	return x1 < x2+w2 and
	    x2 < x1+w1 and
        y1 < y2+h2 and
        y2 < y1+h1
end
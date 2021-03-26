-- Collision detection function;
-- Returns true if two boxes overlap, false if they don't;
-- x1,y1 are the top-left coords of the first box, while w1,h1 are its width and height;
-- x2,y2,w2 & h2 are the same, but for the second box.
function CheckCollision(obj1, obj2)
	local x1, y1, w1, h1 = obj1.x-obj1.r, obj1.y-obj1.r, 2*obj1.r, 2*obj1.r
	local x2, y2, w2, h2 = obj2.x-obj2.r, obj2.y-obj2.r, 2*obj2.r, 2*obj2.r
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end


function checkCollisions(x, y, r)
	r = r or 1
	local Obj2 = Torta(x, y, r)
	for i=1,#colisorTortas do
    	if CheckCollision(colisorTortas[i], Obj2) then
    		return colisorTortas[i] end
        end
return false end
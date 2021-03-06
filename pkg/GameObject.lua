local Body = require("Body")

local GameObject = {
x = 0,
y = 0,
speed_x = 0,
speed_y = 0,
width = 0,
height = 0,
img = nil,
invincible=false,
dead = false,
duration = 0,
animation = nil
}

function GameObject:new(o)
  local b = o or {}
  self.__index = self
  setmetatable(b, self)
  b.boxes = {}

  return b
end

function GameObject:isDead()
  return self.dead
end

function GameObject:draw()
  love.graphics.draw(self.img, self.x, self.y)
end

function GameObject:setBox(b)
  table.insert(self.boxes, b)
end

function GameObject:getBoxes()
  return self.boxes
end

function GameObject:euclidian(bodyB)
  return math.sqrt(((bodyB.x - self.x) ^ 2) + ((bodyB.y - self.y) ^ 2));
end

function GameObject:collide(bodyB)
  if self.invincible or bodyB.invincible then return false end
  for  _, a in ipairs(self:getBoxes()) do         
    for _, b in ipairs(bodyB:getBoxes()) do
      if a.x + self.x < bodyB.x + b.x + b.width 
      and self.x + a.x + a.width > b.x + bodyB.x 
      and a.y + self.y < b.y + b.height + bodyB.y
      and a.height + a.y + self.y  > b.y + bodyB.y
      then
        return true;
      end
    end
  end
  return false;
end


return GameObject
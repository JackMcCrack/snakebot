--- WELCOME TO YOUR FIRST SNAKE!
-- It is programmed in the Lua language. If you didn't used 
-- it until now, ask us or visit https://www.lua.org/manual/5.3/.
-- 
-- You can edit this code, save and run it.
-- You should see log output at the bottom of this page,
-- and a live view on your snake's wellbeing on the right

--- init() is called once upon creation of the bot
-- initialize your data here, and maybe set colors for your snake
function init()
    self.colors = { 0xFF00FF, 0x00FF00, 0x00FF00, 0x00FF00, 0x00FF00, 0xFF0000, 0x00FF00}
end

function Reverse (arr)
	local i, j = 1, #arr

	while i < j do
		arr[i], arr[j] = arr[j], arr[i]

		i = i + 1
		j = j - 1
	end
end


--- step() is called once every frame, maybe up to 60 times per second.
-- implement your game logic here.
-- after deciding what your bot should do next,
-- just return the desired steering angle.
-- a negative angle means turn left and a positive angle means turn right.
-- with 0, the snake keeps its current direction.
function step()
    
    local turnto = 0
    local dist = 1
    local turbo = false
    -- there is some info in the "self" object, e.g. your current head/segment radius
    local own_radius = self.segment_radius

    -- your snake needs food to grow
    -- to find food in your head's surroundings, call something like that:
    local food = findFood(55, 0.3)
    -- this will give you all food in maximum distance of 100 around your head,
    -- with a mass of at least 0.8 ordered by food value (largest to lowest)
    
    Reverse(food)
    
    -- you can iterate over the result:
    for i, item in pairs(food) do

        -- distance of the food item, relative to the center of your head
        distance = item.dist
         

        -- direction to the food item, in radians (-math.pi .. +math.pi)
        -- 0 means "straight ahead", math.pi means "right behind you"
        local direction = item.d
        local maxturn = 0.05 + self.max_step_angle
        log(tostring(direction) .. " ; " .. tostring(distance) .. " ; " .. tostring(maxturn) .. " ; " .. tostring(self.max_step_angle))
        if (direction < (-1 * maxturn) or (1 * maxturn) < direction) and distance < 55.0 then
            turnto = direction/3
        else
            turnto = direction
        end

        -- mass of the food item. you will grow this amount if you eat it.
        -- realistic values are 0 - 4
        local value = item.v

	end

    
    -- you should also look out for your enemies.
    -- to find snake segments around you, call:
    local segments = findSegments(300, false)

    Reverse(segments)
    -- in return, you get a list of
    -- all snake segments nearer than 100 to your head,
    -- in this case not including your own segments:
    for i, item in pairs(segments) do

        -- id of the bot the segment belongs to
        -- (you can compare this to self.id)
        local bot = item.bot

        -- distance to the center of the segment
        local distance = item.dist

	-- direction to the segment, in radians (-math.pi .. +math.pi)
        local direction = item.d

        -- radius of the segment
        local radius = item.r
        
        if direction > 0 then
            turnto = direction + (0.25 * math.pi)
        else
            turnto = direction - (0.25 * math.pi)
        end
	end
    
    turnto = turnto + (math.random(-1,1)*0.1* math.pi)
    return turnto -- this will lead us in a large circle, clockwise.
end

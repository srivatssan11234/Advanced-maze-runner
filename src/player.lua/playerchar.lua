-- player.lua
local Utils = require("src.utils")

local Player = {}

function Player.new(x, y)
    local self = {
        x = x,
        y = y,
        speed = 1,
        shield = false,
        powerUpTimer = 0
    }

    function self.move(direction, maze)
        local dx, dy = 0, 0
        if direction == "up" then dy = -1 end
        if direction == "down" then dy = 1 end
        if direction == "left" then dx = -1 end
        if direction == "right" then dx = 1 end

        local newX = Utils.clamp(self.x + dx, 1, #maze[1])
        local newY = Utils.clamp(self.y + dy, 1, #maze)

        if maze[newY] and maze[newY][newX] == 0 then
            self.x, self.y = newX, newY
        end
    end

    function self.applyPowerUp(powerUp)
        if powerUp == "speed" then
            self.speed = 2
            self.powerUpTimer = 5 -- Lasts for 5 seconds
        elseif powerUp == "shield" then
            self.shield = true
            self.powerUpTimer = 5
        end
    end

    function self.update(dt)
        if self.powerUpTimer > 0 then
            self.powerUpTimer = self.powerUpTimer - dt
            if self.powerUpTimer <= 0 then
                self.speed = 1
                self.shield = false
            end
        end
    end

    return self
end

return Player
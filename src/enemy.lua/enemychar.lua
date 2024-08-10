-- enemy.lua
local Utils = require("src.utils")

local Chaser = {}
local Patroller = {}

function Chaser.new(x, y)
    local self = { x = x, y = y }

    function self.moveTowardsPlayer(player, maze)
        local path = FindPath(maze, self.x, self.y, player.x, player.y)
        if path and #path > 1 then
            self.x, self.y = path[2].x, path[2].y
        end
    end

    return self
end

function Patroller.new(x, y)
    local self = { x = x, y = y, pathIndex = 1 }
    self.path = {{x = x, y = y}, {x = x + 5, y = y}, {x = x + 5, y = y + 5}, {x = x, y = y + 5}}

    function self.patrol()
        self.pathIndex = self.pathIndex % #self.path + 1
        local nextPosition = self.path[self.pathIndex]
        if Utils.isWithinBounds(nextPosition.x, nextPosition.y, #maze[1], #maze) then
            self.x, self.y = nextPosition.x, nextPosition.y
        end
    end

    return self
end

return {Chaser = Chaser, Patroller = Patroller}
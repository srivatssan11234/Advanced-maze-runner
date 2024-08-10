-- maze.lua
local Utils = require("src.utils")

local Maze = {}

function Maze.generateMaze(width, height)
    local maze = {}
    for i = 1, height do
        maze[i] = {}
        for j = 1, width do
            maze[i][j] = 1 -- Initialize all cells as walls
        end
    end

    local function carve(x, y)
        local directions = Utils.shuffleTable({{0, 1}, {1, 0}, {0, -1}, {-1, 0}})
        for _, d in ipairs(directions) do
            local nx, ny = x + d[1] * 2, y + d[2] * 2
            if Utils.isWithinBounds(nx, ny, width, height) and maze[ny][nx] == 1 then
                maze[y + d[2]][x + d[1]] = 0
                maze[ny][nx] = 0
                carve(nx, ny)
            end
        end
    end

    maze[2][2] = 0
    carve(2, 2)
    return maze
end

return Maze
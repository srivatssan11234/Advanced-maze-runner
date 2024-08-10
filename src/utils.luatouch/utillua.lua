-- utils.lua
-- Utility functions for Maze Runner - Advanced Edition

local Utils = {}

-- Clamp function to ensure a value is within a certain range
function Utils.clamp(value, min, max)
    if value < min then
        return min
    elseif value > max then
        return max
    else
        return value
    end
end

-- Function to shuffle a table (useful for randomizing directions in maze generation)
function Utils.shuffleTable(t)
    local shuffled = {}
    for i = 1, #t do
        local randIndex = math.random(i)
        shuffled[i] = shuffled[randIndex]
        shuffled[randIndex] = t[i]
    end
    return shuffled
end

-- Function to check if a point is within the bounds of the maze
function Utils.isWithinBounds(x, y, width, height)
    return x > 0 and x <= width and y > 0 and y <= height
end

return Utils
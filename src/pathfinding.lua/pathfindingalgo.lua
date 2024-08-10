-- A* Pathfinding Algorithm
function FindPath(maze, startX, startY, goalX, goalY)
    local openSet = { {x = startX, y = startY, g = 0, h = 0, f = 0, parent = nil} }
    local closedSet = {}
    
    local function heuristic(x1, y1, x2, y2)
        return math.abs(x1 - x2) + math.abs(y1 - y2)
    end
    
    while #openSet > 0 do
        table.sort(openSet, function(a, b) return a.f < b.f end)
        local current = table.remove(openSet, 1)
        
        if current.x == goalX and current.y == goalY then
            local path = {}
            while current do
                table.insert(path, 1, {x = current.x, y = current.y})
                current = current.parent
            end
            return path
        end
        
        table.insert(closedSet, current)
        local neighbors = { {0, 1}, {1, 0}, {0, -1}, {-1, 0} }
        for _, n in ipairs(neighbors) do
            local nx, ny = current.x + n[1], current.y + n[2]
            if maze[ny] and maze[ny][nx] == 0 then
                local g = current.g + 1
                local h = heuristic(nx, ny, goalX, goalY)
                local f = g + h
                
                local neighbor = {x = nx, y = ny, g = g, h = h, f = f, parent = current}
                
                local inClosedSet = false
                for _, node in ipairs(closedSet) do
                    if node.x == nx and node.y == ny then
                        inClosedSet = true
                        break
                    end
                end
                
                if not inClosedSet then
                    table.insert(openSet, neighbor)
                end
            end
        end
    end
    
    return nil -- No path found
end
-- gameLoop.lua
local Utils = require("src.utils")

local GameLoop = {}

-- Function to render the maze, player, and enemies
local function render(maze, player, chasers, patrollers)
    -- Clear the screen (this is pseudo-code; replace with actual screen clearing logic)
    os.execute("clear")  -- On Windows, use "cls"

    -- Render the maze
    for y, row in ipairs(maze) do
        for x, cell in ipairs(row) do
            if player.x == x and player.y == y then
                io.write("P ")  -- Player
            else
                local isEnemy = false
                for _, chaser in ipairs(chasers) do
                    if chaser.x == x and chaser.y == y then
                        io.write("C ")  -- Chaser Enemy
                        isEnemy = true
                        break
                    end
                end
                if not isEnemy then
                    for _, patroller in ipairs(patrollers) do
                        if patroller.x == x and patroller.y == y then
                            io.write("E ")  -- Patroller Enemy
                            isEnemy = true
                            break
                        end
                    end
                end
                if not isEnemy then
                    io.write(cell == 1 and "# " or ". ")  -- Wall or Empty Space
                end
            end
        end
        io.write("\n")
    end
end

-- Function to handle the game loop
function GameLoop.start(maze, player, chasers, patrollers)
    local dt = 1 / 60 -- Assuming 60 FPS
    local goalX, goalY = #maze[1], #maze  -- Example goal position (bottom-right corner)

    while true do
        -- Example input handling (replace with actual input logic)
        local direction = "up" -- Example: Get direction from input
        player:move(direction, maze)
        
        -- Update player and enemies
        player:update(dt)
        for _, chaser in ipairs(chasers) do
            chaser:moveTowardsPlayer(player, maze)
        end
        for _, patroller in ipairs(patrollers) do
            patroller:patrol()
        end
        
        -- Render the game state
        render(maze, player, chasers, patrollers)
        
        -- Check for Collisions
        for _, chaser in ipairs(chasers) do
            if chaser.x == player.x and chaser.y == player.y and not player.shield then
                print("Game Over! You were caught by a chaser!")
                return
            end
        end
        
        for _, patroller in ipairs(patrollers) do
            if patroller.x == player.x and patroller.y == player.y and not player.shield then
                print("Game Over! You were caught by a patroller!")
                return
            end
        end
        
        -- Check for Victory Condition
        if player.x == goalX and player.y == goalY then
            print("Congratulations! You've reached the exit!")
            return
        end

        -- Small delay to simulate frame rate (e.g., 60 FPS)
        os.execute("sleep " .. tostring(dt))
    end
end

return GameLoop
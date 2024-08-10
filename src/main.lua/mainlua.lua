-- main.lua
-- Entry point for Maze Runner - Advanced Edition

-- Import necessary modules
local Maze = require("src.maze")
local Player = require("src.player")
local Chaser = require("src.enemy").Chaser
local Patroller = require("src.enemy").Patroller
local GameLoop = require("src.gameLoop")
local Utils = require("src.utils")

-- Initialize game parameters
local width, height = 20, 20  -- Maze dimensions
local maze = Maze.generateMaze(width, height)
local player = Player.new(2, 2)  -- Starting position for player

-- Initialize enemies
local chasers = {Chaser.new(width - 2, height - 2)}
local patrollers = {Patroller.new(10, 10)}

-- Setup game loop and start the game
GameLoop.start(maze, player, chasers, patrollers)
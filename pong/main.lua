local WINDOW_WIDTH = 1280
local WINDOW_HEIGHT = 720

-- Res that is going to be scalated
local VIRTUAL_WIDTH = 432 
local VIRTUAL_HEIGHT = 243

local push = require 'push' -- Import push module
require 'tools' -- Import our own functions

-- Load is called when the program runs
function love.load()
    -- Remove bilinear filtering
    love.graphics.setDefaultFilter("nearest", "nearest")

    -- Load fonts into an object
    smallFont = love.graphics.newFont("font.ttf", 8)
    scoreFont = love.graphics.newFont("font.ttf", 32)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT,
     WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = 1,
        resizable = false
     })

     -- Normalized background
     r = tools.normalize(40, 255)
     g = tools.normalize(45, 255)
     b = tools.normalize(52, 255)

     -- Ball 
    Ball = {width = 5, height = 5}
    
    -- Rectangles
    Rectangle = {width = 5, height = 20}

    -- Score variables
    player1Score = 0
    player2Score = 0

    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 40 

    PADDLE_SPEED = 200
end

-- Update is called every frame before draw
function love.update(dt)
    if love.keyboard.isDown("s") then
        player1Y = player1Y + PADDLE_SPEED * dt
    elseif love.keyboard.isDown("w") then 
        player1Y = player1Y - PADDLE_SPEED * dt 
    end

    if love.keyboard.isDown("down") then
        player2Y = player2Y + PADDLE_SPEED * dt
    elseif love.keyboard.isDown("up") then  
        player2Y = player2Y - PADDLE_SPEED * dt
    end
end

-- Quit game 
function love.keypressed(key) 
    if key == "escape" then
        love.event.quit()
    end
end

-- Draw is called on every frame
function love.draw() 
    push:apply("start") -- Start drawing 
    
    -- Setup background 
    love.graphics.clear(r, g, b, 1)

    -- Ball and rectangles
    love.graphics.rectangle("fill", VIRTUAL_WIDTH / 2 - 2.5, VIRTUAL_HEIGHT / 2 - 2.5 , Ball.width, Ball.height)
    love.graphics.rectangle("fill", 10, player1Y, Rectangle.width, Rectangle.height)
    love.graphics.rectangle("fill", VIRTUAL_WIDTH - Rectangle.width - 10, player2Y, Rectangle.width, Rectangle.height)

    love.graphics.setFont(smallFont)
    love.graphics.printf("Hello Pong!",
     0, -- starting X
     20, -- starting Y
     VIRTUAL_WIDTH, -- number of pixels to center within (entire screen) 
     "center") -- alignment mode

    -- Scores
     love.graphics.setFont(scoreFont)
     love.graphics.print(player1Score, VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 5)
     love.graphics.print(player2Score, VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 5) 
    
     push:apply("end") 

end

require "utils"
require "classes.particle"

function love.load()
    seed = os.clock()
    math.randomseed(seed)
    windowWidth, windowHeight = love.graphics.getDimensions()

    colorMatrix = {}
    colors = {}
    addColor("red", {1,0,0})
    addColor("green", {0,1,0})
    addColor("blue", {0,0,1})
    addColor("yellow", {1,1,0})
    addColor("cyan", {0,1,1})
    addColor("white", {1,1,1})
    addColor("purple", {0.6,0,0.6})
    addColor("pink", {1,0.5,0.5})

    printMatrix()

    particleAmount = 1500
    particles = {}
    for i = 0, particleAmount do
        local randX = math.random(0, windowWidth)
        local randY = math.random(0, windowHeight)
        particles[i] = particle.new({color = randomColor(), position = {x = randX, y = randY}})
    end
end

function love.resize()
    windowWidth, windowHeight = love.graphics.getDimensions()

    particles = {}
    for i = 0, particleAmount do
        local randX = math.random(0, windowWidth)
        local randY = math.random(0, windowHeight)
        particles[i] = particle.new({color = randomColor(), position = {x = randX, y = randY}})
    end
end

function love.update(dt)
    for i = 0, #particles do
        particles[i]:update(dt)
    end
end

function love.draw()
    for i = 0, #particles do
        particles[i]:draw()
    end

    love.graphics.setColor(1,1,1)
    love.graphics.print("FPS:"..love.timer.getFPS())
    love.graphics.print("SEED:"..seed, 0, 10)
end
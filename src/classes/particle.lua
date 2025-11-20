particle = {}
particle.__index = particle

function particle.new(settings)
    local self = setmetatable({}, particle)

    self.color = settings.color
    self.velocity = {x = 0, y = 0}
    self.position = settings.position

    self.mass = 100
    self.forceMagnitude = 10
    self.CloseDis = 50
    self.toCloseforceMagnitude = self.forceMagnitude*10
    self.toCloseDis = 5
    self.size = 2

    return self
end

function particle:update(dt)
    self.position.x = self.position.x + self.velocity.x * dt
    self.position.y = self.position.y + self.velocity.y * dt

    for i = 0, #particles do
        local direction_x = particles[i].position.x - self.position.x
        local direction_y = particles[i].position.y - self.position.y
        local distance = math.sqrt(direction_x^2 + direction_y^2)

        local force_x = 0
        local force_y = 0
        if distance == 0 then
            force_x = 0
            force_y = 0
        elseif distance <= self.toCloseDis then
            force_x = (direction_x / distance) * -self.toCloseforceMagnitude
            force_y = (direction_y / distance) * -self.toCloseforceMagnitude
        elseif distance <= self.CloseDis then
            force_x = (direction_x / distance) * colorMatrix[self.color][particles[i].color]*self.forceMagnitude
            force_y = (direction_y / distance) * colorMatrix[self.color][particles[i].color]*self.forceMagnitude
        end
        self.velocity.x = self.velocity.x + (force_x / self.mass) * dt
        self.velocity.y = self.velocity.y + (force_y / self.mass) * dt
        self.position.x = self.position.x + self.velocity.x * dt
        self.position.y = self.position.y + self.velocity.y * dt
    end

    if self.position.x > windowWidth then
        self.position.x = 0
    end
    if self.position.x < 0 then
        self.position.x = windowWidth
    end
    if self.position.y > windowHeight then
        self.position.y = 0
    end
    if self.position.y < 0 then
        self.position.y = windowHeight
    end

    self.velocity.x = self.velocity.x * 0.95
    self.velocity.y = self.velocity.y * 0.95
end

function particle:draw()
    love.graphics.setColor(colorMatrix[self.color]["color"])
    love.graphics.circle("fill", self.position.x, self.position.y, self.size)
end
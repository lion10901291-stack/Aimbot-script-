-- Lua puro (con LÖVE2D para interfaz gráfica)
-- Guarda como main.lua y ejecútalo con Love2D

local aimAssist = false
local rapidFire = false

local player = {x = 400, y = 300}
local enemies = {
    {x = 200, y = 150},
    {x = 600, y = 200},
    {x = 500, y = 400}
}

local function getClosestTarget()
    local closest = nil
    local minDist = math.huge

    for _, e in ipairs(enemies) do
        local dx = e.x - player.x
        local dy = e.y - player.y
        local dist = math.sqrt(dx*dx + dy*dy)
        if dist < minDist then
            minDist = dist
            closest = e
        end
    end
    return closest
end

local function shoot()
    if aimAssist then
        local t = getClosestTarget()
        if t then
            print("Disparo asistido hacia:", t.x, t.y)
        end
    else
        print("Disparo normal")
    end
end

function love.draw()
    -- jugador
    love.graphics.circle("fill", player.x, player.y, 10)

    -- enemigos
    for _, e in ipairs(enemies) do
        love.graphics.circle("line", e.x, e.y, 10)
    end

    -- menú
    love.graphics.print("1: AimAssist [" .. (aimAssist and "ON" or "OFF") .. "]", 10, 10)
    love.graphics.print("2: RapidFire [" .. (rapidFire and "ON" or "OFF") .. "]", 10, 30)
    love.graphics.print("Click izquierdo: disparar", 10, 50)
end

function love.mousepressed(x, y, button)
    if button == 1 then
        if rapidFire then
            for i = 1,5 do
                shoot()
            end
        else
            shoot()
        end
    end
end

function love.keypressed(key)
    if key == "1" then
        aimAssist = not aimAssist
    elseif key == "2" then
        rapidFire = not rapidFire
    end
end

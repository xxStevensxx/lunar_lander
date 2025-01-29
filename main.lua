-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
  end
  
  -- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
  io.stdout:setvbuf("no")

  local lander = {
    x = 0,
    y = 0,
    angle = -90,
    vx = 0,
    vy = 0,
    ship = love.graphics.newImage("/assets/ship.png"),
    engine = love.graphics.newImage("/assets/engine.png"),
    engineStart = false,
    speed = 105

  }

  function love.load()

    largeur = love.graphics.getWidth()
    hauteur = love.graphics.getHeight()


    lander.x = largeur/2
    lander.y = hauteur/2
  end

  function love.update(dt)
    -- Ajout de l'inertie de chute au vaisseau
    lander.vy = lander.vy + 0.09 * dt

    -- on ajoute a la position X et Y la vitesse d'inertie pour que le vaisseau se deplace 
    lander.x = lander.x + lander.vx 
    lander.y = lander.y + lander.vy 

    if love.keyboard.isDown("left") then
      lander.angle = lander.angle - 90 * dt
    end

    if love.keyboard.isDown("right") then
      lander.angle = lander.angle + 90 * dt
    end

    if love.keyboard.isDown("up") then
      lander.engineStart = true

      -- on va appliquer une force de poussé selon l'angle du vaisseau avec le sin et cos
      local angle_radian = math.rad(lander.angle)
      local forceX = math.cos(angle_radian) * lander.speed * dt
      local forceY = math.sin(angle_radian) * lander.speed * dt

      lander.vx = lander.vx + forceX * dt
      lander.vy = lander.vy + forceY * dt

    else
      lander.engineStart = false
    end

  end

  function love.draw()
    love.graphics.draw(lander.ship, lander.x, lander.y, math.rad(lander.angle), 1, 1, lander.ship:getWidth()/2, lander.ship:getHeight()/2)

    if lander.engineStart == true then
      love.graphics.draw(lander.engine, lander.x, lander.y, math.rad(lander.angle), 1, 1, lander.engine:getWidth()/2, lander.engine:getHeight()/2)
    end

    love.graphics.print(lander.vy)

    print(lander.engineStart)

  end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  end
end
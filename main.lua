-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
  end
  
  -- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
  io.stdout:setvbuf("no")

  require("/etoiles")
  require("/lander")

  local etoiles = {}
  local lander = {}

  function love.load()
    etoiles = AddNbEtoile(300)
    lander = CreateLander()
  end

  function love.update(dt)
    Inertie(0.10, lander, dt)
    -- LanderCollider(lander)
    animateEtoile(etoiles, dt)
    StarCollider(etoiles)
    KeyInput(lander, dt)

  end

  function love.draw()
    sDebug = "Debug: "
    love.graphics.print(" angle: "..lander.angle )
    love.graphics.print(" vitesse Y : "..lander.vy, 0, 25)
    love.graphics.print(" vitesse X : "..lander.vx, 0, 50)
    love.graphics.print("  pos X : "..lander.x, 0, 75)
    love.graphics.print("  pos Y : "..lander.y, 0, 100)


    -- On affiche le vaisseau
    love.graphics.draw(lander.ship, lander.x, lander.y, math.rad(lander.angle), 1, 1, lander.ship:getWidth()/2, lander.ship:getHeight()/2)

    -- On affiche les flammes du moteur lors du mouvement du vaisseeau
    if lander.engineStart == true then
      love.graphics.draw(lander.engine, lander.x, lander.y, math.rad(lander.angle), 1, 1, lander.engine:getWidth()/2, lander.engine:getHeight()/2)
    end

    -- on affiche notre pluie d'etoiles
    for index = 1, #etoiles do 
      e = etoiles[index] 
      love.graphics.draw(e.image, e.x, e.y, e.rotate, e.scale_x, e.scale_y)
    end
  end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  end
end
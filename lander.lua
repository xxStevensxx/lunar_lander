local largeur = love.graphics.getWidth()
local hauteur = love.graphics.getHeight()

function CreateLander()
    local lander = {
    x = largeur/2,
    y = hauteur/2,
    angle = 270,
    vx = 0,
    vy = 0,
    ship = love.graphics.newImage("/assets/ship.png"),
    engine = love.graphics.newImage("/assets/engine.png"),
    engineStart = false,
    speed = 105
  }
  return lander
end


function Inertie(gravity, lander, dt)

    -- Ajout de l'inertie de chute au vaisseau
    lander.vy = lander.vy + gravity * dt

    -- on ajoute a la position X et Y la vitesse d'inertie pour que le vaisseau se deplace 
    lander.x = lander.x + lander.vx 
    lander.y = lander.y + lander.vy 

    -- On gere l'angle pour eviter d'aller dans les negatifs ou apres 360
    if lander.angle < 0 then
        lander.angle = 360
    elseif lander.angle > 360 then
        lander.angle = 0
    end
end


function ThrustForce(lander, dt)
    -- on va appliquer une force de poussé selon l'angle du vaisseau avec le sin et cos
    local angle_radian = math.rad(lander.angle)
    
    local forceX = math.cos(angle_radian) * lander.speed * dt
    local forceY = math.sin(angle_radian) * lander.speed * dt
    
    lander.vx = lander.vx + forceX * dt
    lander.vy = lander.vy + forceY * dt
end

function KeyInput(lander, dt)

    --entrée clavier
    if love.keyboard.isDown("left") then
        lander.angle = lander.angle - 90 * dt
      end

      --entrée clavier
      if love.keyboard.isDown("right") then
        lander.angle = lander.angle + 90 * dt
      end
  
      --entrée clavier
      if love.keyboard.isDown("up") then
        lander.engineStart = true  
        ThrustForce(lander, dt)
      else
        lander.engineStart = false
      end

end


function LanderCollider(lander)
    if lander.x < 0 then
        lander.x = -lander.x
    elseif lander.x > love.graphics.getWidth() then
        lander.x = -lander.x
    end

    if lander.y < 0 then
        lander.y = -lander.y
    elseif lander.y > love.graphics.getHeight() then
        lander.y = -lander.y
    end
end
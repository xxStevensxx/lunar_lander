local etoiles = {}

function CreateEtoiles()
    etoile = {
        image = love.graphics.newImage("/assets/star.png"),
        x = math.random(1, love.graphics.getWidth()),
        y = math.random(1, love.graphics.getHeight()),
        vitesse_x = math.random(10, 50),
        vitesse_y = math.random(10, 50),
        rotate = 0,
        scale_x = 0.01,
        scale_y = 0.01,
        speed = 0,
        largeur = 0,
        hauteur = 0
    }
        etoile.largeur = etoile.image:getWidth()
        etoile.hauteur = etoile.image:getHeight()

    return etoile
end

--On ajoute le nb d'etoiles voulu
function AddNbEtoile(nbEtoile)
    for index = 1, nbEtoile do 
        table.insert(etoiles, CreateEtoiles())
    end
return etoiles
end

function animateEtoile(etoiles, dt)
    for index = 1, #etoiles do
        local e = etoiles[index]    
        e.x = e.x + e.vitesse_x * dt
        e.y = e.y + e.vitesse_y *dt
    end
end

function StarCollider(etoiles)

    for index = 1, #etoiles do 
        e = etoiles[index]
        if e.x <= 0 then
            e.x = e.x + love.graphics.getWidth()
        elseif e.x >= love.graphics.getWidth() - e.largeur * e.scale_x then
            e.x = 0
        end
    end

    for index = 1, #etoiles do 
        e = etoiles[index]
        if e.y <= 0 then
            e.y = e.y + love.graphics.getHeight()
        elseif e.y >= love.graphics.getHeight() - e.hauteur * e.scale_y then
        e.y = 0
    end
    end
end
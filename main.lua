local cardConfig = require 'cardConfig'
local iconConfig = require 'iconConfig'
local characterStatsConfig = require 'characterStatsConfig'
local characterConfig = require 'characterConfig'
local musicConfig = require 'musicConfig'
local soundConfig = require 'soundConfig'
local aiCharacterConfig = require 'aiCharacterConfig'
local deckConfig = require 'deckConfig'
local cardFunction = require 'cardFunction'
local characterfunction = require 'characterfunction'
local aifunction = require 'aifunction'
--vector = require 'vector'
--anim8 = require 'anim8'

turn = 0
begin = false
endGame = false
timer = 100
local AP

function love.load()
  love.window.setTitle("CardFighter")
  xmin = 100
  ymin = 100
  xmax = love.window.getWidth() - 100
  ymax = love.window.getHeight() - 100
  sound1 = love.audio.newSource(musicConfig.battle1)
  love.audio.play(sound1)
  --icon image
  id = 0
  COLLISION_DISTANCE = iconConfig.Width/2
  atki = love.graphics.newImage(iconConfig.attackI)
  defi = love.graphics.newImage(iconConfig.defenseI)
  expi = love.graphics.newImage(iconConfig.expI)
  spi = love.graphics.newImage(iconConfig.specialI)
  spdi = love.graphics.newImage(iconConfig.speedI)
  isClicked = false
  --sound setup
  aisound = love.audio.newSource(soundConfig.special2)
  spSound = love.audio.newSource(soundConfig.special)
  pUpSound = love.audio.newSource(soundConfig.powerup)
  attackSound = love.audio.newSource(soundConfig.punch)
  defendSound = love.audio.newSource(soundConfig.kick)
  jumpSound = love.audio.newSource(soundConfig.jump)
  --card image
  atk = love.graphics.newImage(cardConfig.attack)
  def = love.graphics.newImage(cardConfig.defense)
  ev = love.graphics.newImage(cardConfig.evade)
  sp = love.graphics.newImage(cardConfig.special)
  heal = love.graphics.newImage(cardConfig.heal)
  --character image
  p1 = love.graphics.newImage("150.png")
  ai = love.graphics.newImage("411.png")
  AP = 5
  --background
  background = love.graphics.newImage("imagesbackground.jpg")
  xscale = love.graphics.getHeight() / background:getHeight()
  yscale = love.graphics.getWidth() / background:getWidth()
  --love.graphics.setBackgroundColor(155,155,255)
  
end

function love.draw(dt)
  --love.graphics.print("Timer: "..timer, 300, 20)
  love.graphics.print("Turn: "..turn,300,30)
  love.graphics.print("AP: "..AP,0,30)
  love.graphics.print("Level: "..characterStatsConfig.level,0,10)
  love.graphics.print("HP: "..characterStatsConfig.hp,0,20)
  love.graphics.print("Enemy: "..aiCharacterConfig.hp,720,20)
  love.graphics.draw(background, 0, 100, 0, xscale, yscale)
  --icon
  love.graphics.draw(atki, 100, 200, 0, 2, 2, iconConfig.Width,iconConfig.Height)
  love.graphics.draw(defi, 200, 200, 0, 2, 2, iconConfig.Width,iconConfig.Height)
  love.graphics.draw(expi, 300, 200, 0, 2, 2, iconConfig.Width,iconConfig.Height)
  love.graphics.draw(spi, 400, 200, 0, 1, 1, iconConfig.Width,iconConfig.Height)
  love.graphics.draw(spdi, 500, 200, 0, 2, 2, iconConfig.Width,iconConfig.Height)
  --character
  love.graphics.draw(p1, 200, 450, 0, 1, 1, p1:getWidth(), p1:getHeight())
  love.graphics.draw(ai, 700, 450, 0, 1, 1, ai:getWidth(), ai:getHeight())
  --card
  love.graphics.draw(atk,200,500,0,.25,.25,cardConfig.Width, cardConfig.Height)
  love.graphics.draw(def,300,500,0,.25,.25,cardConfig.Width, cardConfig.Height)
  love.graphics.draw(ev,400,500,0,.25,.25,cardConfig.Width, cardConfig.Height)
  love.graphics.draw(sp,500,500,0,.25,.25,cardConfig.Width, cardConfig.Height)
  love.graphics.draw(heal,600,500,0,.25,.25,cardConfig.Width, cardConfig.Height)
end

function love.update(dt)
  --gtime()
    if begin == false then
      startPhase()
    end
    if AP == 0 then
      endPhase()
      reset()
    end
    if aiCharacterConfig.hp < 0 then
      gameState()
    end
    
    if characterStatsConfig.hp < 0 then
      gameState()
    end
    
end



function love.mousepressed(x, y, button)
  
  if button == "l" then
    love.audio.play(pUpSound)
    characterStatsConfig.attack = characterStatsConfig.attack + 1
    characterStatsConfig.defense = characterStatsConfig.defense + 1
    characterStatsConfig.special = characterStatsConfig.special + 1
    characterStatsConfig.evade = characterStatsConfig.evade + 1
    incExp()
    levelUp()
  end
  
end

function love.keypressed(key,unicode)
  
  if key == "a" then
    love.audio.play(attackSound)
    attack()
    AP = AP - 1
    incExp()
    levelUp()
  end
  
  if key == 'd' then
    love.audio.play(defendSound)
    defend()
    AP = AP - 1
    incExp()
    levelUp()
  end
  
  if key == 's' then
    love.audio.play(spSound)
    special()
    AP = AP - 1
    incExp()
    levelUp()
  end
  
  if key == 'e' then
    love.audio.play(jumpSound)
    evade()
    AP = AP - 1
  end
  
  if key == 'f' then
    love.audio.play(spSound)
    --heal()
    characterStatsConfig.hp = characterStatsConfig.hp + 20
    AP = AP - 1
  end
  
end

function startPhase()
 begin = true
 turn = turn + 1

 battlePhase()

end

function battlePhase()

  for i = 1, 5 do
  if characterStatsConfig.hp < aiCharacterConfig.hp then
    --love.audio.play(attackSound)
    aiattack()
    end
  if aiCharacterConfig.hp < 50 then
    --love.audio.play(defendSound)
    aidefend()
    aiCharacterConfig.hp = aiCharacterConfig.hp + 20
    end
  if characterStatsConfig.hp < 50 then
    aispecial()
    end
  if aiCharacterConfig.evade > characterStatsConfig.evade then
    --love.audio.play(jumpSound)
    aievade()
  end
end
  
end
function endPhase()
  incExp()
  levelUp()
if aiCharacterConfig.hp > 0 then
    startPhase()
  end
end



function gameState()
endGame = true
--love.graphics.setColor(155,0,0)
love.graphics.print("YOU WIN!", 300, 30)
love.event.quit()
end

function reset()
  if AP == 0 then
  AP = 5
  end
end

function gtime()
  while timer > 0 do
    --love.graphics.print("hello",300,300)
    timer = timer - 1
end
    timer = 100
end

function iconClicked()
    --local x = love.mouse.getPosition()
    --local distance = x - iconConfig.Width
    --if distance < COLLISION_DISTANCE then
      isClicked = true
    --end
end

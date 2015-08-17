--ai capability
local cardFunction = require 'cardFunction'
local aiCharacterConfig = require 'aiCharacterConfig'
local deckConfig = require 'deckConfig'
local characterStatsConfig = require 'characterStatsConfig'

aicommand = {"attack", "defend","evade","special","heal"}
damage = aiCharacterConfig.attack - characterStatsConfig.defense
rdamage = characterStatsConfig.attack - aiCharacterConfig.defense


function randomCommand()
  for i = 1, 5, -1 do
    local r = math.random(1,5)
    aicommand[r], aicommand[i] = aicommand[i],aicommand[r]
    end
end

function execute()
  for k,v in pairs(aicommand) do
      aiplay(aicommand[i])
  end
end

function aiplay(aicommand)
  if aicommand == "attack" then
    aiattack()
  end
  
  if aicommand == "defend" then
    aidefend()
  end
  
  if aicommand == "evade" then
    aievade()
  end
  
  if aicommand == "special" then
    aispecial()
  end
  
  if aicommand == "heal" then
    aiheal()
  end
  
end

function aiattack()
  if aiCharacterConfig.attack > characterStatsConfig.defense then
  characterStatsConfig.hp = characterStatsConfig.hp - damage
  end
end

function aidefend()
  if aiCharacterConfig.defense > characterStatsConfig.attack then
    rdamage = 0
    aiCharacterConfig.hp = aiCharacterConfig.hp - rdamage
    else
      aiCharacterConfig.hp = aiCharacterConfig.hp - (rdamage/2)
  end
end

function aievade()
  --make the ai character jump to evade the attack
    --add the y value to the ai's character avatar to make it look like it jump.
    rdamage = 0
end

function aispecial()
  
  love.audio.play(aisound)
  characterStatsConfig.hp = characterStatsConfig.hp - aiCharacterConfig.special
end


function aiheal()
  aiCharacterConfig.hp = aiCharacterConfig.hp + (aiCharacterConfig * .10)
end

function aiAnimation()
  
end

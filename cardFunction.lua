--player capability
local characterStatsConfig = require 'characterStatsConfig'
local aiCharacterConfig = require 'aiCharacterConfig'
local iconConfig = require 'iconConfig'
local cardConfig = require 'cardConfig'
local deckConfig = require 'deckConfig'

phand = {}
pcommand = {}
deck = {}
damage = characterStatsConfig.attack - aiCharacterConfig.defense
rdamage = characterStatsConfig.attack - aiCharacterConfig.defense


function prepareDeck()
  for k,v in ipairs(deckConfig) do
    table.insert(deck,deckConfig[k])
    end
end

function shuffle()
  for i = 5,1 -1 do
    local r = math.random(1,5)
    deck[r], deck[i] = deck[i], deck[r]
    --mix the array of table arounds with random index numbers
  end
end

function attack()
  --local hit = player.x - aiplayer.x 
  --if cardConfig.attack then
    --if hit then
    if characterStatsConfig.attack > aiCharacterConfig.defense then
      aiCharacterConfig.hp = aiCharacterConfig.hp - damage
  --end
    end
end

function defend()
  --if cardConfig.defense then
    if characterStatsConfig.defense > aiCharacterConfig.attack then
      rdamage = 0
      characterStatsConfig.hp = characterStatsConfig.hp - rdamage
    else
      characterStatsConfig.hp = characterStatsConfig.hp - (rdamage/2)
    end
  end
  
function evade()
  --if cardConfig.evade then
    --make the character jump respectively to y axis
    if characterStatsConfig.evade > aiCharacterConfig.evade then
    rdamage = 0
    characterStatsConfig.hp = characterStatsConfig.hp - rdamage
    else
      characterStatsConfig.hp = characterStatsConfig.hp - damage
  end
end

function cardDraw()
  for k,v in ipairs(deck) do
    table.insert(phand,deck[k])
    end
end

function executeCommand()
  
end

function insertCommand()
  
end

function discard()
  for i = 1, 5 do
    table.remove(phand,i)
    end
end


function heal()
  --if cardConfig.heal then
  --if characterStatsConfig.hp > 0 then
    characterStatsConfig.hp = characterStatsConfig.hp + characterStatsConfig.hp * .10
  --end
end

function special()
    aiCharacterConfig.hp = aiCharacterConfig.hp - characterStatsConfig.special
end



local characterStatsConfig = require 'characterStatsConfig'
local soundConfig = require 'soundConfig'
local characterConfig = require 'characterConfig'

function levelUp()
  if characterStatsConfig.exp >= characterStatsConfig.nextLevel then
    characterStatsConfig.level = characterStatsConfig.level + 1
    incStat()
    incNextExp()
  end
end

function incExp()
  characterStatsConfig.exp = characterStatsConfig.exp + 10
end

function incStat()
    characterStatsConfig.hp = characterStatsConfig.hp + 15
    characterStatsConfig.attack = characterStatsConfig.attack + 1
    characterStatsConfig.defense = characterStatsConfig.defense + 1
    characterStatsConfig.special = characterStatsConfig.special + 1
    characterStatsConfig.evade = characterStatsConfig.evade + 1
end

function incNextExp()
    characterStatsConfig.nextLevel = characterStatsConfig.nextLevel + 100
end

function charAnimation()
  
end

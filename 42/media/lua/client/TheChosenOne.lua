local IMMUNITY_ROLLED_KEY = "TheChosenOneImmunityRolled"
local IMMUNE_KEY = "TheChosenOneImmune"

local function clearKnoxInfection(player, bodyDamage)
    local bodyParts = bodyDamage:getBodyParts()

    for i = 0, bodyParts:size() - 1 do
        local bodyPart = bodyParts:get(i)
        if bodyPart:IsInfected() then
            bodyPart:SetInfected(false)
        end
    end

    bodyDamage:setInfected(false)
    bodyDamage:setInfectionTime(-1)
    bodyDamage:setInfectionMortalityDuration(-1)
    player:getStats():reset(CharacterStat.ZOMBIE_INFECTION)
end

local function getKnoxMaxHealth(player)
    local infectionProgress = player:getStats():get(CharacterStat.ZOMBIE_INFECTION) / 100.0
    infectionProgress = math.max(0.0, math.min(1.0, infectionProgress))

    return (1.0 - infectionProgress ^ 4) * 100.0
end

local function rollImmunity(player)
    local modData = player:getModData()
    if modData[IMMUNITY_ROLLED_KEY] ~= nil then
        return
    end

    local chance = SandboxVars.TheChosenOne.KnoxImmunityChancePercent
    chance = math.max(0, math.min(100, chance or 0))

    modData[IMMUNE_KEY] = ZombRand(100) < chance
    modData[IMMUNITY_ROLLED_KEY] = true
end

local function onCreatePlayer(playerNum, player)
    if not player then
        return
    end

    rollImmunity(player)
end

local function onPlayerUpdate(player)
    if not player then
        return
    end

    local modData = player:getModData()
    if modData[IMMUNE_KEY] ~= true then
        return
    end

    local bodyDamage = player:getBodyDamage()
    if not bodyDamage:isInfected() then
        return
    end

    if SandboxVars.TheChosenOne.EnableKnoxFever then
        local threshold = SandboxVars.TheChosenOne.KnoxMaxHealthThresholdPercent or 2
        threshold = math.max(1, math.min(100, threshold))

        if getKnoxMaxHealth(player) <= threshold then
            clearKnoxInfection(player, bodyDamage)
        end
        return
    end

    clearKnoxInfection(player, bodyDamage)
end

Events.OnCreatePlayer.Add(onCreatePlayer)
Events.OnPlayerUpdate.Add(onPlayerUpdate)

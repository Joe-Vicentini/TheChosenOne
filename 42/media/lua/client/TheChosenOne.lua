local IMMUNITY_ROLLED_KEY = "TheChosenOneImmunityRolled"
local IMMUNE_KEY = "TheChosenOneImmune"
local FEVER_HEALTH_THRESHOLD = 2.0

local function clearKnoxInfection(bodyDamage)
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
end

local function rollImmunity(player)
    local modData = player:getModData()
    if modData[IMMUNITY_ROLLED_KEY] ~= nil then
        return
    end

    local chance = SandboxVars.TheChosenOne.Chance_of_being_immune_in_percentage
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

    if SandboxVars.TheChosenOne.Have_fever then
        if bodyDamage:getOverallBodyHealth() <= FEVER_HEALTH_THRESHOLD then
            clearKnoxInfection(bodyDamage)
        end
        return
    end

    clearKnoxInfection(bodyDamage)
end

Events.OnCreatePlayer.Add(onCreatePlayer)
Events.OnPlayerUpdate.Add(onPlayerUpdate)

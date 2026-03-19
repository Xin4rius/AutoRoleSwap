local addonName, addonTable = ...
local L = addonTable.L

local function ARCPrint(text, hexColor)
    if not text then return end
    hexColor = hexColor or "ffffffff"
    -- Remove the localized text prefix if present
    text = string.gsub(text, "^AutoRoleSwap%s*:%s*", "")
    -- Format and print
    print("|cff00ccff[AutoRoleSwap]|r |cff" .. hexColor .. text .. "|r")
end

local function GetLocalizedRoleName(role)
    if role == "TANK" then return L["ROLE_TANK"] or "Tank" end
    if role == "HEALER" then return L["ROLE_HEALER"] or "Healer" end
    if role == "DAMAGER" then return L["ROLE_DAMAGER"] or "Damager" end
    return role
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("PLAYER_ROLES_ASSIGNED")
frame:RegisterEvent("GROUP_ROSTER_UPDATE")
frame:RegisterEvent("CHARACTER_POINTS_CHANGED")
pcall(function() frame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED") end)
pcall(function() frame:RegisterEvent("PLAYER_TALENT_UPDATE") end)

local isHooked = false
local lastManualChange = 0
local applyTimer = nil
local ApplySavedRole -- Forward declaration

-- Utility function to determine the current specialization based on talent points
addonTable.GetCurrentSpecID = function()
    local _, classFile = UnitClass("player")
    local maxPoints = -1
    local maxTab = 0
    local numTabs = GetNumTalentTabs()
    
    if numTabs and numTabs > 0 then
        for i = 1, numTabs do
            local id, name, description, iconTexture, pointsSpent, background, previewPointsSpent, isUnlocked = GetTalentTabInfo(i)
            if pointsSpent and pointsSpent > maxPoints then
                maxPoints = pointsSpent
                maxTab = i
            end
        end
    end
    
    if maxPoints <= 0 then
        return classFile .. "_0" -- No talent points spent
    end
    return classFile .. "_" .. maxTab -- Returns something like "DRUID_2" for Feral
end
local GetCurrentSpecID = addonTable.GetCurrentSpecID

SLASH_AUTOROLESWAP1 = "/ars"
SlashCmdList["AUTOROLESWAP"] = function(msg)
    if msg == "lock" then
        if type(AutoRoleSwapDB) == "table" then
            local specID = GetCurrentSpecID()
            local lockKey = specID .. "_locked"
            AutoRoleSwapDB[lockKey] = not AutoRoleSwapDB[lockKey]
            if AutoRoleSwapDB[lockKey] then
                local msg = L["locked"]
                if msg then ARCPrint(msg, "ff4444") end -- Red for locked
                ApplySavedRole(true)
                if addonTable.UpdateMinimapButton then addonTable.UpdateMinimapButton() end
            else
                local msg = L["unlocked"]
                if msg then ARCPrint(msg, "44ff44") end -- Green for unlocked
                if addonTable.UpdateMinimapButton then addonTable.UpdateMinimapButton() end
            end
        end
    else
        local msg = L["help"]
        if msg then ARCPrint(msg, "cccccc") end -- Gray for help
    end
end

-- Met à jour le rôle du joueur selon les priorités du LFG (Tank > Heal > DPS)
local function UpdateRoleFromLFG()
    if InCombatLockdown() then return end
    
    local specID = GetCurrentSpecID()
    if type(AutoRoleSwapDB) == "table" and AutoRoleSwapDB[specID .. "_locked"] then
        return
    end

    local isLeader, isTank, isHealer, isDamage = GetLFGRoles()
    local newRole = nil
    
    if isTank then
        newRole = "TANK"
    elseif isHealer then
        newRole = "HEALER"
    elseif isDamage then
        newRole = "DAMAGER"
    end
    
    if newRole then
        if type(AutoRoleSwapDB) == "table" and AutoRoleSwapDB[specID] ~= newRole then
            AutoRoleSwapDB[specID] = newRole
            UnitSetRole("player", newRole)
            local msg = L["role_restored"]
            if msg then ARCPrint(string.format(msg, "|cffffd100" .. GetLocalizedRoleName(newRole) .. "|r"), "ffff00") end -- Yellow
        end
    end
end

-- Hook to capture the player's manual role changes (via portrait UI)
local function HookRoleChanges()
    if isHooked then return end
    hooksecurefunc("UnitSetRole", function(unit, role)
        if unit == "player" then
            if type(AutoRoleSwapDB) == "table" then
                local specID = GetCurrentSpecID()
                local isLocked = AutoRoleSwapDB[specID .. "_locked"]
                local savedRole = AutoRoleSwapDB[specID]
                
                -- Si le rôle est verrouillé et qu'on essaie de mettre un rôle différent
                if isLocked and savedRole and savedRole ~= "NONE" and role ~= savedRole then
                    if InCombatLockdown() then return end
                    lastManualChange = GetTime() -- Met à jour pour bloquer les apply indésirables pendant 2s
                    UnitSetRole("player", savedRole)
                    local msg = L["role_blocked"]
                    if msg then ARCPrint(string.format(msg, "|cffffd100" .. GetLocalizedRoleName(savedRole) .. "|r"), "ff8800") end -- Orange
                    return
                end
                
                -- Update the time of the last manual change
                lastManualChange = GetTime()
                
                if role == "TANK" or role == "HEALER" or role == "DAMAGER" or role == "NONE" then
                    AutoRoleSwapDB[specID] = role
                end
            end
        end
    end)
    isHooked = true
end

-- Applies the saved role for the current specialization
ApplySavedRole = function(force)
    if type(AutoRoleSwapDB) ~= "table" then return end
    if InCombatLockdown() then return end
    
    -- If the player manually changed their role within the last 2 seconds, do not overwrite it
    if not force and GetTime() - lastManualChange < 2.0 then return end

    local specID = GetCurrentSpecID()
    local savedRole = AutoRoleSwapDB[specID]
    local currentRole = UnitGroupRolesAssigned("player")
    
    if savedRole and savedRole ~= "NONE" and savedRole ~= currentRole then
        UnitSetRole("player", savedRole)
        
        local msg = L["role_restored"]
        if msg then ARCPrint(string.format(msg, "|cffffd100" .. GetLocalizedRoleName(savedRole) .. "|r"), "ffff00") end -- Yellow
    end
    
    if addonTable.UpdateMinimapButton then addonTable.UpdateMinimapButton() end
end

frame:SetScript("OnEvent", function(self, event, arg1)
    if event == "PLAYER_LOGIN" then
        if type(AutoRoleSwapDB) ~= "table" then
            AutoRoleSwapDB = {}
        end
        HookRoleChanges()
    elseif event == "PLAYER_ENTERING_WORLD" then
        UpdateRoleFromLFG()
        ApplySavedRole()
    elseif event == "PLAYER_ROLES_ASSIGNED" or event == "GROUP_ROSTER_UPDATE" then
        ApplySavedRole()
    elseif event == "CHARACTER_POINTS_CHANGED" or event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "PLAYER_TALENT_UPDATE" then
        -- Use a timer to avoid spamming ApplySavedRole() on every spent talent point
        if applyTimer then
            applyTimer:Cancel()
        end
        applyTimer = C_Timer.NewTimer(1.0, ApplySavedRole)
    end
end)

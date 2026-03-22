local addonName, addonTable = ...
local L = addonTable.L

local ARSPrint = addonTable.ARSPrint
local GetLocalizedRoleName = addonTable.GetLocalizedRoleName

local ARS_TalentUI = CreateFrame("Frame")
local mainButton
local dropdownFrame
local lockBtn
local roleButtons = {}

local function GetRoleIconData(role)
    -- Native Role Icons Coords
    if role == "TANK" then
        return "Interface\\LFGFrame\\UI-LFG-ICON-ROLES", 0, 0.2617, 0.2578, 0.5234
    elseif role == "HEALER" then
        return "Interface\\LFGFrame\\UI-LFG-ICON-ROLES", 0.2617, 0.5234, 0, 0.2617
    else
        return "Interface\\LFGFrame\\UI-LFG-ICON-ROLES", 0.2617, 0.5234, 0.2578, 0.5234 -- DPS
    end
end

local function UpdateDropdownUI()
    if type(AutoRoleSwapDB) ~= "table" then return end
    if not addonTable.GetCurrentSpecID then return end
    if not dropdownFrame or not dropdownFrame:IsShown() then return end
    
    local specID = addonTable.GetCurrentSpecID()
    local savedRole = AutoRoleSwapDB[specID] or "NONE"
    local isLocked = AutoRoleSwapDB[specID .. "_locked"]
    
    if isLocked then
        lockBtn:SetText(L["status_locked"] or "Lock")
    else
        lockBtn:SetText(L["status_unlocked"] or "Unlock")
    end
    
    for role, btn in pairs(roleButtons) do
        if role == savedRole then
            btn.text:SetTextColor(1, 0.82, 0) -- Yellow for selected
            btn.check:Show()
        else
            btn.text:SetTextColor(1, 1, 1)    -- White for others
            btn.check:Hide()
        end
    end
end

local function SelectRole(role)
    if type(AutoRoleSwapDB) == "table" then
        local specID = addonTable.GetCurrentSpecID()
        AutoRoleSwapDB[specID] = role
        if not InCombatLockdown() then
            UnitSetRole("player", role)
        end
        UpdateDropdownUI()
        
        local msg = L["role_restored"]
        if msg and ARSPrint and GetLocalizedRoleName then
            ARSPrint(string.format(msg, "|cffffd100" .. GetLocalizedRoleName(role) .. "|r"), "ffff00")
        end
    end
end

local function ToggleLock()
    if type(AutoRoleSwapDB) == "table" then
        local specID = addonTable.GetCurrentSpecID()
        AutoRoleSwapDB[specID .. "_locked"] = not AutoRoleSwapDB[specID .. "_locked"]
        UpdateDropdownUI()
        
        if AutoRoleSwapDB[specID .. "_locked"] then
            local msg = L["locked"]
            if msg and ARSPrint then ARSPrint(msg, "ff4444") end
        else
            local msg = L["unlocked"]
            if msg and ARSPrint then ARSPrint(msg, "44ff44") end
        end
        
        if addonTable.UpdateMinimapButton then addonTable.UpdateMinimapButton() end
    end
end

local function CreateDropdown()
    dropdownFrame = CreateFrame("Frame", "ARS_RoleDropdown", mainButton, "BackdropTemplate")
    dropdownFrame:SetSize(160, 145)
    
    -- Position ABOVE the main button
    dropdownFrame:SetPoint("BOTTOMLEFT", mainButton, "TOPLEFT", 50, 6)
    dropdownFrame:SetFrameLevel(mainButton:GetFrameLevel() + 5)
    
    dropdownFrame:SetBackdrop({
        bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    dropdownFrame:SetBackdropColor(0.05, 0.05, 0.05, 0.95)
    dropdownFrame:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)
    
    -- Invisible full-screen button to close dropdown when clicking outside
    local closeLayer = CreateFrame("Button", nil, dropdownFrame)
    closeLayer:SetAllPoints(UIParent)
    closeLayer:SetFrameStrata("DIALOG")
    closeLayer:SetFrameLevel(dropdownFrame:GetFrameLevel() - 1)
    closeLayer:SetScript("OnClick", function() dropdownFrame:Hide() end)
    
    dropdownFrame:SetFrameStrata("DIALOG")
    
    -- Lock / Unlock Toggle Button at the top
    lockBtn = CreateFrame("Button", nil, dropdownFrame, "UIPanelButtonTemplate")
    lockBtn:SetSize(130, 22)
    lockBtn:SetPoint("TOP", 0, -12)
    lockBtn:SetScript("OnClick", function() ToggleLock() end)
    
    -- Separator
    local sep = dropdownFrame:CreateTexture(nil, "ARTWORK")
    sep:SetSize(140, 1)
    sep:SetColorTexture(1, 1, 1, 0.15)
    sep:SetPoint("TOP", lockBtn, "BOTTOM", 0, -6)
    
    -- Role Buttons
    local roles = {"TANK", "HEALER", "DAMAGER"}
    local yOffset = -46
    
    for _, role in ipairs(roles) do
        local btn = CreateFrame("Button", nil, dropdownFrame)
        btn:SetSize(140, 24)
        btn:SetPoint("TOP", 0, yOffset)
        
        -- Custom Highlight for native dropdown feel
        local highlight = btn:CreateTexture(nil, "HIGHLIGHT")
        highlight:SetAllPoints()
        highlight:SetColorTexture(1, 1, 1, 0.1)
        
        local tex, l, r, t, b = GetRoleIconData(role)
        local icon = btn:CreateTexture(nil, "ARTWORK")
        icon:SetSize(18, 18)
        icon:SetPoint("LEFT", 10, 0)
        icon:SetTexture(tex)
        icon:SetTexCoord(l, r, t, b)
        
        local text = btn:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        text:SetPoint("LEFT", 34, 0)
        text:SetText(L["ROLE_" .. role] or role)
        btn.text = text
        
        -- Beautiful native checkmark for the selected role
        local check = btn:CreateTexture(nil, "OVERLAY")
        check:SetSize(16, 16)
        check:SetPoint("RIGHT", -8, 0)
        check:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
        check:Hide()
        btn.check = check
        
        btn:SetScript("OnClick", function() SelectRole(role) end)
        
        roleButtons[role] = btn
        yOffset = yOffset - 26
    end
    
    dropdownFrame:SetScript("OnShow", function()
        UpdateDropdownUI()
        closeLayer:Show()
    end)
    
    dropdownFrame:SetScript("OnHide", function()
        closeLayer:Hide()
    end)
    
    dropdownFrame:Hide()
end

local function InitTalentsUI()
    if mainButton then return end
    
    -- Support multiple APIs: Retail, WotLK/Cata, Classic Era
    local parentFrame = PlayerSpellsFrame or PlayerTalentFrame or TalentFrame
    if not parentFrame then return end
    
    -- A beautiful standard UI Panel Button
    mainButton = CreateFrame("Button", "ARS_TalentRoleButton", parentFrame, "UIPanelButtonTemplate")
    mainButton:SetSize(50, 24)
    mainButton:SetFrameLevel(parentFrame:GetFrameLevel() + 10)
    
    mainButton:SetText("ARS")
    
    -- Position: Snapped beautifully inside the bottom right corner of the window
    mainButton:SetPoint("BOTTOMRIGHT", parentFrame,"BOTTOMRIGHT",-35,50)
    
    mainButton:SetScript("OnClick", function()
        if not dropdownFrame then CreateDropdown() end
        if dropdownFrame:IsShown() then
            dropdownFrame:Hide()
        else
            dropdownFrame:Show()
        end
    end)
    
    mainButton:SetScript("OnHide", function()
        if dropdownFrame then dropdownFrame:Hide() end
    end)
end

-- Event Registration
ARS_TalentUI:RegisterEvent("ADDON_LOADED")
ARS_TalentUI:RegisterEvent("PLAYER_LOGIN")
ARS_TalentUI:RegisterEvent("CHARACTER_POINTS_CHANGED")
ARS_TalentUI:RegisterEvent("PLAYER_TALENT_UPDATE")
pcall(function() ARS_TalentUI:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED") end)

ARS_TalentUI:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and (arg1 == "Blizzard_TalentUI" or arg1 == "Blizzard_PlayerSpells") then
        InitTalentsUI()
    elseif event == "PLAYER_LOGIN" then
        local loaded = (C_AddOns and C_AddOns.IsAddOnLoaded or IsAddOnLoaded)
        if loaded("Blizzard_TalentUI") or loaded("Blizzard_PlayerSpells") then
            InitTalentsUI()
        end
        if PlayerSpellsFrame or PlayerTalentFrame or TalentFrame then
            InitTalentsUI()
        end
    elseif event == "CHARACTER_POINTS_CHANGED" or event == "PLAYER_TALENT_UPDATE" or event == "ACTIVE_TALENT_GROUP_CHANGED" then
        if mainButton and mainButton:IsVisible() then
            -- Delay so it catches the newest specID data
            C_Timer.After(0.5, function()
                if dropdownFrame and dropdownFrame:IsShown() then
                    UpdateDropdownUI()
                end
            end)
        end
    end
end)

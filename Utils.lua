local addonName, addonTable = ...
local L = addonTable.L

addonTable.ARSPrint = function(text, hexColor)
    if not text then return end
    hexColor = hexColor or "ffffffff"
    -- Remove the localized text prefix if present
    text = string.gsub(text, "^AutoRoleSwap%s*:%s*", "")
    -- Format and print
    print("|cff00ccff[AutoRoleSwap]|r |cff" .. hexColor .. text .. "|r")
end

addonTable.GetLocalizedRoleName = function(role)
    if role == "TANK" then return L["ROLE_TANK"] or "Tank" end
    if role == "HEALER" then return L["ROLE_HEALER"] or "Healer" end
    if role == "DAMAGER" then return L["ROLE_DAMAGER"] or "Damager" end
    return role
end

local _, addonTable = ...

if GetLocale() ~= "deDE" then return end

local L = addonTable.L
L["role_restored"] = "AutoRoleSwap: Eure Rolle wurde für die aktuelle Spezialisierung wieder auf '%s' gesetzt."
L["ROLE_TANK"] = "Tank"
L["ROLE_HEALER"] = "Heiler"
L["ROLE_DAMAGER"] = "Schaden"
L["locked"] = "AutoRoleSwap: Rollen sind nun GESPERRT. Die LFG-Auswahl überschreibt euren gespeicherten Rollen nicht länger."
L["unlocked"] = "AutoRoleSwap: Rollen sind ENTSPERRT. Die LFG-Auswahl überschreibt euren gespeicherten Rollen nun wieder."
L["help"] = "AutoRoleSwap-Befehle:\n  /ars lock - Aktiviert/Deaktiviert das Überschreiben der Rollen durch die LFG-Auswahl."
L["role_blocked"] = "AutoRoleSwap: Eure Rolle wurde auf '%s' zurückgesetzt, da sie GESPERRT ist."
L["tooltip_click_toggle"] = "\nLinksklick: |cffffffffSperren / Entsperren|r"
L["tooltip_drag_move"] = "Linksklick & Ziehen: |cffffffffSymbol bewegen|r"
L["status_locked"] = "Gesperrt"
L["status_unlocked"] = "Entsperrt"
L["talents_button_tooltip"] = "Linksklick: \n|cffffffffRolle wählen / Sperren|r"

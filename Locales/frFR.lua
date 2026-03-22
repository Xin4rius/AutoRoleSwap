local _, addonTable = ...

if GetLocale() ~= "frFR" then return end

local L = addonTable.L
L["role_restored"] = "AutoRoleSwap : Restauration de votre rôle en '%s' pour la spécialisation actuelle."
L["ROLE_TANK"] = "Tank"
L["ROLE_HEALER"] = "Soigneur"
L["ROLE_DAMAGER"] = "Dégâts"
L["locked"] = "AutoRoleSwap: Rôles VERROUILLÉS. Le LFG n'écrasera plus le rôle de votre spécialisation."
L["unlocked"] = "AutoRoleSwap: Rôles DÉVERROUILLÉS. Vos choix LFG s'appliqueront lors des écrans de chargement."
L["help"] = "Commandes AutoRoleSwap:\n  /ars lock - Active/Désactive la protection de l'écrasement des rôles par le LFG."
L["role_blocked"] = "AutoRoleSwap: Restauration de votre rôle en '%s' car la spécialisation est VERROUILLÉE."
L["tooltip_click_toggle"] = "\nClic gauche: |cffffffffVerrouiller / Déverrouiller|r"
L["tooltip_drag_move"] = "Clic gauche maintenu: |cffffffffDéplacer l'icône|r"
L["status_locked"] = "Verrouillé"
L["status_unlocked"] = "Déverrouillé"
L["talents_button_tooltip"] = "Clic gauche: \n|cffffffffChoisir le rôle / Verrouiller|r"

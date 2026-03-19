local _, addonTable = ...

if GetLocale() ~= "itIT" then return end

local L = addonTable.L
L["role_restored"] = "AutoRoleSwap: Ruolo ripristinato in '%s' per la specializzazione attuale."
L["ROLE_TANK"] = "Difensore"
L["ROLE_HEALER"] = "Curatore"
L["ROLE_DAMAGER"] = "Assaltatore"
L["locked"] = "AutoRoleSwap: Ruoli BLOCCATI. La selezione nella Ricerca Gruppi non sovrascriverà più il rôle salvato."
L["unlocked"] = "AutoRoleSwap: Ruoli SBLOCCATI. La selezione nella Ricerca Gruppi sovrascriverà il ruolo durante i caricamenti."
L["help"] = "Comandi AutoRoleSwap:\n  /ars lock - Attiva/disattiva la protezione dei ruoli dalla Ricerca Gruppi."
L["role_blocked"] = "AutoRoleSwap: Ruolo ripristinato in '%s' perché è BLOCCATO."
L["tooltip_click_toggle"] = "\nClic sinistro: |cffffffffBlocca / Sblocca|r"
L["tooltip_drag_move"] = "Tieni premuto clic sinistro: |cffffffffSposta icona|r"
L["status_locked"] = "Bloccato"
L["status_unlocked"] = "Sbloccato"

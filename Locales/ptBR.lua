local _, addonTable = ...

if GetLocale() ~= "ptBR" and GetLocale() ~= "ptPT" then return end

local L = addonTable.L
L["role_restored"] = "AutoRoleSwap: Função restaurada para '%s' na especialização atual."
L["ROLE_TANK"] = "Tanque"
L["ROLE_HEALER"] = "Curador"
L["ROLE_DAMAGER"] = "Dano"
L["locked"] = "AutoRoleSwap: Funções BLOQUEADAS. A seleção no Localizador de Grupos não substituirá suas funções salvas."
L["unlocked"] = "AutoRoleSwap: Funções DESBLOQUEADAS. A seleção no Localizador de Grupos substituirá suas funções durante telas de carregamento."
L["help"] = "Comandos AutoRoleSwap:\n  /ars lock - Ativa/desativa a proteção de substituição de função pelo Localizador de Grupos."
L["role_blocked"] = "AutoRoleSwap: Função restaurada para '%s' porque está BLOQUEADA."
L["tooltip_click_toggle"] = "\nClique esquerdo: |cffffffffBloquear / Desbloquear|r"
L["tooltip_drag_move"] = "Clique esquerdo e arraste: |cffffffffMover ícone|r"
L["status_locked"] = "Bloqueado"
L["status_unlocked"] = "Desbloqueado"

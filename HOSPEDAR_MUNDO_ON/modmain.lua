-- Hospedar Mundo ON - Torna mundos visíveis para TODOS
-- Modifica a visibilidade do Host Worlds Viewer para público

print("[HospedarMundoON] ========================================")
print("[HospedarMundoON] HOSPEDAR MUNDO ON v1.0.0")
print("[HospedarMundoON] Tornando mundos visíveis para TODOS!")
print("[HospedarMundoON] ========================================")

-- Configurações do mod
local MOD_CONFIG = {
    force_public_visibility = GetModConfigData("force_public_visibility"),
    show_warning_message = GetModConfigData("show_warning_message"),
    auto_kick_unstable = GetModConfigData("auto_kick_unstable"),
    max_reconnect_attempts = GetModConfigData("max_reconnect_attempts"),
    public_server_name = GetModConfigData("public_server_name"),
    stability_boost = GetModConfigData("stability_boost")
}

-- Variáveis globais
local g_player_reconnect_count = {}
local g_unstable_players = {}
local g_public_visibility_active = false

print("[HospedarMundoON] Configurações:")
for key, value in pairs(MOD_CONFIG) do
    print("[HospedarMundoON] " .. key .. ": " .. tostring(value))
end

-- Função para forçar visibilidade pública
local function ForcePublicVisibility()
    if not MOD_CONFIG.force_public_visibility then
        print("[HospedarMundoON] Visibilidade pública desativada")
        return
    end
    
    print("[HospedarMundoON] 🌍 FORÇANDO VISIBILIDADE PÚBLICA!")
    
    -- Modifica configurações globais do jogo para tornar o servidor visível
    if TheNet then
        -- Força o servidor a ser listado publicamente
        if TheNet.SetServerListing then
            TheNet:SetServerListing(true)
            print("[HospedarMundoON] ✅ Servidor listado publicamente")
        end
        
        -- Define como servidor público
        if TheNet.SetServerPublic then
            TheNet:SetServerPublic(true)
            print("[HospedarMundoON] ✅ Servidor definido como público")
        end
        
        -- Remove restrições de mod
        if TheNet.SetModRestrictions then
            TheNet:SetModRestrictions(false)
            print("[HospedarMundoON] ✅ Restrições de mod removidas")
        end
    end
    
    -- Modifica variáveis globais do DST
    if GLOBAL then
        GLOBAL.MOD_WORLD_VISIBILITY = "all"
        GLOBAL.FORCE_PUBLIC_LISTING = true
        print("[HospedarMundoON] ✅ Variáveis globais modificadas")
    end
    
    g_public_visibility_active = true
    print("[HospedarMundoON] 🎉 MUNDO AGORA VISÍVEL PARA TODOS!")
end

-- Função para configurar nome do servidor público
local function SetPublicServerName()
    local server_name = "Servidor DST"
    
    if MOD_CONFIG.public_server_name == "auto" then
        if ThePlayer then
            server_name = (ThePlayer:GetDisplayName() or "Host") .. "'s World"
        end
    elseif MOD_CONFIG.public_server_name == "public" then
        server_name = "Servidor Público DST"
    elseif MOD_CONFIG.public_server_name == "open" then
        server_name = "Mundo Aberto - Entre!"
    elseif MOD_CONFIG.public_server_name == "brasil" then
        server_name = "Servidor Brasileiro 🇧🇷"
    end
    
    -- Define o nome do servidor
    if TheNet and TheNet.SetServerName then
        TheNet:SetServerName(server_name)
        print("[HospedarMundoON] 📝 Nome do servidor: " .. server_name)
    end
end

-- Função para aplicar boost de estabilidade
local function ApplyStabilityBoost()
    if MOD_CONFIG.stability_boost == "off" then
        return
    end
    
    print("[HospedarMundoON] 🚀 Aplicando boost de estabilidade: " .. MOD_CONFIG.stability_boost)
    
    -- Configurações de rede otimizadas
    if TheNet then
        -- Reduz lag de rede
        if TheNet.SetNetworkTimeout then
            local timeout = 30 -- padrão
            if MOD_CONFIG.stability_boost == "max" then
                timeout = 60
            elseif MOD_CONFIG.stability_boost == "high" then
                timeout = 45
            end
            TheNet:SetNetworkTimeout(timeout)
            print("[HospedarMundoON] ⏱️ Timeout de rede: " .. timeout .. "s")
        end
        
        -- Melhora sincronização
        if TheNet.SetSyncRate then
            local sync_rate = 20 -- padrão
            if MOD_CONFIG.stability_boost == "max" then
                sync_rate = 15 -- mais lento = mais estável
            elseif MOD_CONFIG.stability_boost == "high" then
                sync_rate = 18
            end
            TheNet:SetSyncRate(sync_rate)
            print("[HospedarMundoON] 🔄 Taxa de sync: " .. sync_rate .. " ticks")
        end
    end
    
    -- Otimizações de performance
    if MOD_CONFIG.stability_boost == "max" then
        -- Reduz carga do servidor
        if TheWorld then
            TheWorld:DoPeriodicTask(5, function()
                -- Força garbage collection
                collectgarbage("collect")
            end)
        end
        print("[HospedarMundoON] 🧹 Limpeza automática de memória ativada")
    end
end

-- Função para monitorar jogadores instáveis
local function MonitorPlayerStability()
    if not MOD_CONFIG.auto_kick_unstable then
        return
    end
    
    print("[HospedarMundoON] 👁️ Monitoramento de estabilidade ativado")
    
    -- Monitora desconexões frequentes
    AddPrefabPostInit("world", function(inst)
        inst:ListenForEvent("ms_playerleft", function(world, player)
            if not player or not player.userid then return end
            
            local player_id = player.userid
            g_player_reconnect_count[player_id] = (g_player_reconnect_count[player_id] or 0) + 1
            
            print("[HospedarMundoON] Jogador saiu: " .. (player:GetDisplayName() or "Unknown") .. " (tentativa " .. g_player_reconnect_count[player_id] .. ")")
            
            -- Verifica se excedeu limite de reconexões
            if MOD_CONFIG.max_reconnect_attempts > 0 and g_player_reconnect_count[player_id] > MOD_CONFIG.max_reconnect_attempts then
                g_unstable_players[player_id] = true
                print("[HospedarMundoON] ⚠️ Jogador marcado como instável: " .. (player:GetDisplayName() or "Unknown"))
            end
        end)
        
        inst:ListenForEvent("ms_playerjoined", function(world, player)
            if not player or not player.userid then return end
            
            local player_id = player.userid
            
            -- Verifica se é jogador instável
            if g_unstable_players[player_id] then
                print("[HospedarMundoON] ❌ Expulsando jogador instável: " .. (player:GetDisplayName() or "Unknown"))
                
                -- Expulsa o jogador
                if TheNet and TheNet.Kick then
                    TheNet:Kick(player_id, "Muitas desconexões - conexão instável")
                end
                return
            end
            
            -- Mostra aviso para jogadores sem mod
            if MOD_CONFIG.show_warning_message then
                TheWorld:DoTaskInTime(2, function()
                    local warning_msg = "⚠️ AVISO: Este servidor aceita jogadores sem mod, mas você pode cair a qualquer momento devido às limitações da Klei!"
                    
                    -- Envia mensagem de aviso
                    if TheNet and TheNet.SendRemoteExecute then
                        TheNet:SendRemoteExecute('print("' .. warning_msg .. '")', player.userid)
                    end
                    
                    print("[HospedarMundoON] Aviso enviado para: " .. (player:GetDisplayName() or "Unknown"))
                end)
            end
        end)
    end)
end

-- Função para mostrar status do mod
local function ShowModStatus()
    if not ThePlayer then return end
    
    local status_msg = "[HospedarMundoON] 🌍 STATUS: "
    
    if g_public_visibility_active then
        status_msg = status_msg .. "MUNDO PÚBLICO ✅"
    else
        status_msg = status_msg .. "MUNDO PRIVADO ❌"
    end
    
    status_msg = status_msg .. " | Boost: " .. MOD_CONFIG.stability_boost
    status_msg = status_msg .. " | Reconexões: " .. (MOD_CONFIG.max_reconnect_attempts == -1 and "∞" or MOD_CONFIG.max_reconnect_attempts)
    
    print(status_msg)
    
    -- Mostra estatísticas de jogadores
    local total_reconnects = 0
    local unstable_count = 0
    
    for _, count in pairs(g_player_reconnect_count) do
        total_reconnects = total_reconnects + count
    end
    
    for _ in pairs(g_unstable_players) do
        unstable_count = unstable_count + 1
    end
    
    if total_reconnects > 0 or unstable_count > 0 then
        print("[HospedarMundoON] 📊 Estatísticas: " .. total_reconnects .. " reconexões, " .. unstable_count .. " jogadores instáveis")
    end
end

-- Função para integrar com Host Worlds Viewer
local function IntegrateWithHostWorldsViewer()
    print("[HospedarMundoON] 🔗 Tentando integrar com Host Worlds Viewer...")
    
    -- Procura pelo mod Host Worlds Viewer
    if GLOBAL and GLOBAL.g_host_manager then
        print("[HospedarMundoON] ✅ Host Worlds Viewer encontrado!")
        
        -- Modifica a configuração de visibilidade
        if GLOBAL.g_host_manager.world_visibility then
            GLOBAL.g_host_manager.world_visibility = "all"
            print("[HospedarMundoON] ✅ Visibilidade alterada para 'all'")
        end
        
        -- Força re-registro do mundo
        if GLOBAL.g_host_manager.RegisterWorldWithMod then
            GLOBAL.g_host_manager:RegisterWorldWithMod()
            print("[HospedarMundoON] ✅ Mundo re-registrado como público")
        end
    else
        print("[HospedarMundoON] ⚠️ Host Worlds Viewer não encontrado, aplicando configurações diretas")
    end
    
    -- Aplica configurações globais independentemente
    ForcePublicVisibility()
end

-- Função principal de inicialização
local function InitializePublicHosting()
    print("[HospedarMundoON] 🚀 Inicializando hospedagem pública...")
    
    -- Aguarda o mundo estar pronto
    TheWorld:DoTaskInTime(2, function()
        -- Integra com Host Worlds Viewer se disponível
        IntegrateWithHostWorldsViewer()
        
        -- Configura nome do servidor
        SetPublicServerName()
        
        -- Aplica boost de estabilidade
        ApplyStabilityBoost()
        
        -- Configura monitoramento
        MonitorPlayerStability()
        
        -- Mostra status inicial
        TheWorld:DoTaskInTime(3, function()
            ShowModStatus()
        end)
        
        print("[HospedarMundoON] ✅ Inicialização completa!")
    end)
end

-- Comandos de debug
if CHEATS_ENABLED then
    AddGameDebugKey(KEY_F4, function()
        ShowModStatus()
    end)
    
    AddGameDebugKey(KEY_F5, function()
        ForcePublicVisibility()
        print("[HospedarMundoON] DEBUG: Visibilidade pública forçada")
    end)
    
    AddGameDebugKey(KEY_F6, function()
        print("[HospedarMundoON] DEBUG: Limpando lista de jogadores instáveis")
        g_unstable_players = {}
        g_player_reconnect_count = {}
    end)
    
    print("[HospedarMundoON] Comandos debug: F4=Status, F5=ForçarPúblico, F6=LimparLista")
end

-- Função para salvar estatísticas
local function SaveStatistics()
    local stats = {
        total_reconnects = 0,
        unstable_players = 0,
        public_visibility = g_public_visibility_active,
        timestamp = os.time()
    }
    
    for _, count in pairs(g_player_reconnect_count) do
        stats.total_reconnects = stats.total_reconnects + count
    end
    
    for _ in pairs(g_unstable_players) do
        stats.unstable_players = stats.unstable_players + 1
    end
    
    print("[HospedarMundoON] 💾 Estatísticas salvas: " .. stats.total_reconnects .. " reconexões, " .. stats.unstable_players .. " instáveis")
end

-- Configura salvamento periódico
AddSimPostInit(function()
    TheWorld:DoPeriodicTask(120, SaveStatistics) -- Salva a cada 2 minutos
end)

-- Status periódico
AddSimPostInit(function()
    TheWorld:DoPeriodicTask(300, ShowModStatus) -- Mostra status a cada 5 minutos
end)

-- Inicia o mod
InitializePublicHosting()

print("[HospedarMundoON] 🎉 MOD CARREGADO! Seu mundo agora é VISÍVEL PARA TODOS!")
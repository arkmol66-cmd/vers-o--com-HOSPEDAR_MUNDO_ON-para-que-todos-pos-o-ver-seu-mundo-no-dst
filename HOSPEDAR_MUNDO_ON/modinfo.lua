name = "Hospedar Mundo ON (Visibilidade Total)"
description = "TORNA SEU MUNDO VISÍVEL PARA TODOS OS JOGADORES! Muda a configuração para que QUALQUER PESSOA possa ver e entrar no seu mundo hospedado, mesmo sem ter o mod Host Worlds Viewer. ATENÇÃO: Jogadores sem o mod podem cair a qualquer momento devido às limitações da Klei. Use por sua conta e risco!"
author = "DST Community"
version = "1.0.0"

forumthread = ""

api_version = 10

dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false

all_clients_require_mod = false
client_only_mod = false

icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = {"host", "publico", "todos", "visibilidade", "aberto"}

configuration_options = {
    {
        name = "force_public_visibility",
        label = "Forçar Visibilidade Pública",
        hover = "Força seu mundo a ser visível para TODOS os jogadores",
        options = {
            {description = "SIM - Todos podem ver", data = true},
            {description = "NÃO - Só com mod", data = false}
        },
        default = true
    },
    {
        name = "show_warning_message",
        label = "Mostrar Avisos",
        hover = "Mostra avisos sobre instabilidade para jogadores sem mod",
        options = {
            {description = "Ativado", data = true},
            {description = "Desativado", data = false}
        },
        default = true
    },
    {
        name = "auto_kick_unstable",
        label = "Expulsar Jogadores Instáveis",
        hover = "Expulsa automaticamente jogadores que caem muito",
        options = {
            {description = "Ativado", data = true},
            {description = "Desativado", data = false}
        },
        default = false
    },
    {
        name = "max_reconnect_attempts",
        label = "Tentativas de Reconexão",
        hover = "Máximo de tentativas de reconexão para jogadores",
        options = {
            {description = "Ilimitado", data = -1},
            {description = "10 tentativas", data = 10},
            {description = "5 tentativas", data = 5},
            {description = "3 tentativas", data = 3},
            {description = "1 tentativa", data = 1}
        },
        default = 5
    },
    {
        name = "public_server_name",
        label = "Nome do Servidor Público",
        hover = "Nome que aparecerá para todos os jogadores",
        options = {
            {description = "Auto (Nome do Host)", data = "auto"},
            {description = "Servidor Público", data = "public"},
            {description = "Mundo Aberto", data = "open"},
            {description = "Servidor Brasileiro", data = "brasil"}
        },
        default = "auto"
    },
    {
        name = "stability_boost",
        label = "Boost de Estabilidade",
        hover = "Tenta melhorar estabilidade para jogadores sem mod",
        options = {
            {description = "Máximo", data = "max"},
            {description = "Alto", data = "high"},
            {description = "Normal", data = "normal"},
            {description = "Desativado", data = "off"}
        },
        default = "high"
    }
}
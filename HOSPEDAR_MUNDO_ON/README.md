# 🌍 Hospedar Mundo ON - Visibilidade Total

## Descrição
Este mod **FORÇA** seu mundo DST a ser visível para **TODOS OS JOGADORES**, mesmo aqueles que não têm o mod Host Worlds Viewer instalado.

## ⚠️ AVISO IMPORTANTE
- **Jogadores SEM o mod podem cair a qualquer momento** devido às limitações da Klei
- **Use por sua conta e risco** - pode haver instabilidade
- **Você (host) não cai**, mas outros jogadores podem desconectar

## 🚀 Funcionalidades

### ✅ Visibilidade Total
- Torna seu mundo visível na lista pública do DST
- Remove restrições de mod
- Permite que qualquer jogador entre

### 🛡️ Proteções Incluídas
- **Boost de Estabilidade**: Otimizações para reduzir desconexões
- **Monitoramento**: Rastreia jogadores que caem muito
- **Auto-Kick**: Remove jogadores muito instáveis (opcional)
- **Avisos**: Informa jogadores sobre possível instabilidade

### ⚙️ Configurações

#### Forçar Visibilidade Pública
- **SIM**: Mundo visível para todos
- **NÃO**: Apenas jogadores com mod

#### Nome do Servidor Público
- **Auto**: Usa nome do host
- **Servidor Público**: Nome genérico
- **Mundo Aberto**: Convida entrada
- **Servidor Brasileiro**: Com bandeira 🇧🇷

#### Boost de Estabilidade
- **Máximo**: Configurações mais conservadoras
- **Alto**: Bom equilíbrio
- **Normal**: Configurações padrão
- **Desativado**: Sem otimizações

#### Controle de Reconexões
- **Ilimitado**: Permite reconexões infinitas
- **1-10 tentativas**: Limita reconexões por jogador
- **Auto-Kick**: Remove jogadores muito instáveis

## 🎮 Como Usar

1. **Instale o mod** na pasta de mods do DST
2. **Configure as opções** no menu de mods
3. **Inicie um mundo** - será automaticamente público
4. **Monitore o chat** para ver status e avisos

## 🔧 Integração

### Com Host Worlds Viewer
Se você tem o mod Host Worlds Viewer instalado:
- Este mod **automaticamente altera** a configuração de visibilidade
- Muda de "mod_only" para "all"
- Funciona em conjunto sem conflitos

### Sem Host Worlds Viewer
- Aplica configurações diretas no DST
- Força listagem pública do servidor
- Remove restrições de mod

## 📊 Monitoramento

### Comandos Debug (se CHEATS ativado)
- **F4**: Mostra status atual
- **F5**: Força visibilidade pública
- **F6**: Limpa lista de jogadores instáveis

### Logs Automáticos
- Status a cada 5 minutos
- Estatísticas a cada 2 minutos
- Avisos para jogadores instáveis

## ⚡ Otimizações de Performance

### Boost Máximo
- Timeout de rede: 60s
- Taxa de sync reduzida
- Limpeza automática de memória
- Configurações conservadoras

### Boost Alto
- Timeout de rede: 45s
- Taxa de sync balanceada
- Otimizações moderadas

## 🎯 Casos de Uso

### Para Hosts
- Quer que **qualquer pessoa** possa entrar
- Não se importa com possível instabilidade
- Quer máxima visibilidade do servidor

### Para Comunidades
- Servidores públicos brasileiros
- Eventos abertos
- Testes de mods com público geral

## 🚨 Limitações da Klei

Este mod **NÃO PODE RESOLVER** as limitações fundamentais do DST:
- Jogadores sem mod **PODEM CAIR** a qualquer momento
- Conexões **PODEM SER INSTÁVEIS**
- Host **SEMPRE FICA CONECTADO**

## 🔄 Compatibilidade

- ✅ **DST**: Totalmente compatível
- ✅ **Host Worlds Viewer**: Integração automática
- ✅ **Outros mods**: Não interfere
- ✅ **Multiplataforma**: Windows/Mac/Linux

## 📝 Notas Técnicas

### Modificações Aplicadas
```lua
-- Força visibilidade pública
TheNet:SetServerListing(true)
TheNet:SetServerPublic(true)
TheNet:SetModRestrictions(false)

-- Variáveis globais
GLOBAL.MOD_WORLD_VISIBILITY = "all"
GLOBAL.FORCE_PUBLIC_LISTING = true
```

### Integração com Host Worlds Viewer
```lua
-- Altera configuração do mod principal
GLOBAL.g_host_manager.world_visibility = "all"
```

---

**Desenvolvido pela DST Community**  
**Versão 1.0.0**  
**Use com responsabilidade! 🎮**
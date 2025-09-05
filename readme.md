# Hydra Pentest Automation with IP Rotation

## ⚠️ DISCLAIMER

**ESTE SCRIPT É DESTINADO EXCLUSIVAMENTE PARA TESTES DE PENETRAÇÃO AUTORIZADOS**

- Use apenas em sistemas onde você possui autorização explícita por escrito
- O uso não autorizado deste script é ILEGAL e pode resultar em consequências criminais
- O desenvolvedor não se responsabiliza pelo uso indevido desta ferramenta

## Descrição

Script de automação para testes de penetração que combina o Hydra (ferramenta de força bruta) com rotação automática de IP através do Anonsurf. O script detecta automaticamente bloqueios de IP e renova a identidade de rede para continuar o teste.

## Funcionalidades

- **Automação Completa**: Execução contínua do Hydra com renovação automática de sessão
- **Detecção de Bloqueio**: Identifica automaticamente quando o IP é bloqueado pelo target
- **Rotação de IP**: Utiliza Anonsurf para renovar automaticamente a identidade de rede
- **Persistência**: Mantém o progresso através do arquivo `.restore` do Hydra
- **Monitoramento em Tempo Real**: Exibe output do Hydra em tempo real

## Pré-requisitos

### Ferramentas Necessárias

```bash
# Instalar Hydra
sudo apt-get install hydra

# Instalar Anonsurf
git clone https://github.com/Und3rf10w/kali-anonsurf.git
cd kali-anonsurf
sudo ./installer.sh
```

### Permissões

- Acesso sudo para executar `anonsurf restart`
- Permissões de escrita no diretório de trabalho para arquivos `.restore`

## Uso

### Configuração Básica

1. **Edite o script** para especificar o target:
```bash
# Substitua "IP-A-SER-TESTADO" pelo IP ou domínio autorizado
hydra -R -t 4 -w 30 https-get / -s 2083 SEU-TARGET-AQUI
```

2. **Configure wordlists** (se necessário):
```bash
# Para usar wordlist específica, modifique o comando Hydra:
hydra -R -t 4 -w 30 -L users.txt -P passwords.txt https-get / -s 2083 TARGET
```

### Execução

```bash
# Tornar o script executável
chmod +x hydra_automation.sh

# Executar o script
./hydra_automation.sh
```

### Parar o Script

- Pressione `Ctrl+C` para interromper a execução
- O progresso será salvo no arquivo `.restore`

## Parâmetros do Hydra Utilizados

| Parâmetro | Descrição |
|-----------|-----------|
| `-R` | Continua sessão anterior usando arquivo `.restore` |
| `-t 4` | Usa 4 threads simultâneas |
| `-w 30` | Timeout de 30 segundos por tentativa |
| `-s 2083` | Porta específica (modifique conforme necessário) |
| `https-get` | Protocolo de ataque (HTTPS GET) |

## Configurações Avançadas

### Modificar Detecção de Bloqueio

```bash
# Personalizar mensagens de erro para detecção:
if [[ "$line" == *"[ERROR]"* && "$line" == *"sua_mensagem_customizada"* ]]; then
```

### Ajustar Timeouts

```bash
# Tempo de espera após renovação de IP (padrão: 10s)
sleep 10

# Pausa entre loops (padrão: 5s)
sleep 5
```

## Troubleshooting

### Problemas Comuns

**Anonsurf não funciona:**
```bash
# Verificar status do Anonsurf
sudo anonsurf status

# Reiniciar serviços Tor
sudo systemctl restart tor
```

**Hydra não encontra arquivo .restore:**
```bash
# Verificar permissões no diretório
ls -la .restore

# Remover arquivo .restore corrompido
rm .restore
```

**Erro de conectividade:**
```bash
# Testar conectividade básica
curl -I http://target-ip:porta

# Verificar se o Tor está funcionando
curl --socks5 127.0.0.1:9050 http://check.torproject.org/
```

### Logs e Monitoramento

```bash
# Executar com log detalhado
./hydra_automation.sh 2>&1 | tee pentest_log.txt

# Monitorar arquivos .restore em tempo real
watch -n 2 "ls -la *.restore"
```

## Considerações de Segurança

### Boas Práticas

- **Documentação**: Sempre documente a autorização por escrito antes do teste
- **Escopo**: Mantenha-se dentro do escopo autorizado
- **Throttling**: Configure delays apropriados para evitar DoS acidental
- **Limpeza**: Remova arquivos temporários após o teste

### Detecção e Evasão

- Este script gera tráfego detectável
- Use apenas em ambientes controlados
- Monitore logs do sistema alvo se possível
- Considere usar proxychains para rotação adicional

## Licença

Este projeto é disponibilizado apenas para fins educacionais e de teste autorizado. O uso inadequado é de inteira responsabilidade do usuário.

## Suporte

Para suporte técnico ou dúvidas sobre uso ético, consulte:
- Documentação oficial do [Hydra](https://github.com/vanhauser-thc/thc-hydra)
- Documentação oficial do [Anonsurf](https://github.com/Und3rf10w/kali-anonsurf)
- Guias de pentest ético
- Frameworks como OWASP Testing Guide

---

**Use esta ferramenta de forma ética e legal.**
# Instalação e Configuração do WSL 2 no Windows 11

## Introdução
O WSL 2 traz um kernel Linux real ao Windows, melhorando a experiência de desenvolvimento em ambientes Linux.

## Passo 1: Verificação dos Requisitos
Certifique-se de ter uma versão compatível do Windows 11 e a virtualização habilitada.

## Passo 2: Ativação do WSL
No PowerShell ISE como administrador, execute:
```bash
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
wsl --install
wsl --set-default-version 2
```
## Passo 3: Escolha de uma Distribuição

- Instale uma distribuição Linux pela Microsoft Store. Recomenda-se o Ubuntu 24.04 LTS.
- Reinicie o seu computador. 

## Passo 4: Configuração Inicial

- Inicie o WSL, configure o usuário e senha da distribuição.

## Passo 5: 

- Instale o Docker Desktop para Windows e realize o logout/login.
## Conclusão

Pronto! Agora o ambiente esta preparado para nossos laboratorios.

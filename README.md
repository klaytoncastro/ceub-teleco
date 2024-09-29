# Instalação e Configuração do Ambiente de Laboratório

## Introdução

O Docker é uma plataforma de virtualização leve que permite empacotar aplicações e todas as suas dependências (bibliotecas, configurações e código) em ambientes isolados, chamados containers. Esses containers são altamente portáveis e podem ser executados em qualquer sistema operacional compatível. Essa solução é amplamente adotada no mercado para criar ambientes replicáveis e consistentes, eliminando a necessidade de configurar e instalar manualmente cada aplicação em diferentes máquinas.

Nos sistemas Microsoft Windows, recomenda-se a utilização do WSL (Windows Subsystem for Linux) para a instalação do Docker. O WSL é um recurso nativo do Windows que permite a execução de distribuições Linux sem a necessidade de emulação ou virtualização completa, como o Microsoft Hyper-V ou Oracle VirtualBox. Projetado para facilitar o desenvolvimento de software no Windows, o WSL oferece uma integração simplificada entre os dois sistemas operacionais, tornando o uso do Docker mais eficiente e acessível.

O uso do Docker, em conjunto com o WSL, é essencial para nossos laboratórios, pois garante a replicabilidade do ambiente de desenvolvimento, independentemente do sistema operacional usado por cada estudante.

**Nota**: Usuários de sistemas baseados em Linux ou macOS não precisam utilizar o WSL, pois esses sistemas já possuem suporte nativo ao Docker. Para executar containers, basta instalar o Docker diretamente, sem a necessidade de qualquer subsistema ou ferramenta adicional.

## Passo 1: Verificação dos Requisitos
Certifique-se de ter uma versão compatível do Windows 10 ou superior e o recurso de virtualização habilitado (VT-x para os processadores da família Intel e AMD-V para os processadores da família AMD). 

## Passo 2: Ativação do WSL
No PowerShell ISE como administrador, execute:

```bash
# Ativa o subsistema Windows para Linux
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

# Ativa a plataforma de máquina virtual necessária para o WSL 2
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# Instala o WSL
wsl --install

# Define a versão 2 do WSL como padrão
wsl --set-default-version 2
```
## Passo 3: Escolha de uma Distribuição

- Caso ainda não utilize uma distribuição Linux embarcada no Windows, instale uma distribuição pela Microsoft Store. Recomenda-se o Ubuntu 24.04 LTS.
- Após a instalação, reinicie o seu computador. 

## Passo 4: Configuração Inicial

- Inicie o aplicativo WSL, configure o usuário e senha da distribuição. Pronto, você já tem acesso a um kernel e terminal Linux. 

## Passo 5: Instalação do Docker

- Baixe e instale o [Docker Desktop for Windows](https://docs.docker.com/desktop/install/windows-install/#:~:text=Docker%20Desktop%20for%20Windows%20%2D%20x86_64) e realize o logout/login.
- O Docker Desktop for Windows fornece uma interface gráfica e integra o Docker ao sistema, facilitando a execução e o gerenciamento de containers diretamente no Windows.

## Passo 6: Utilização do Ambiente

- Ao longo do curso, você será guiado pelo Professor nas atividades práticas que envolverá o conteúdo das subpastas deste repositório.
- Para começar, inicie o Docker Desktop e o aplicativo WSL. Se preferir, você pode utilizar o terminal Linux diretamente no Visual Studio Code (VS Code) para gerenciar seus containers e desenvolver seus projetos.
 
## Conclusão

Pronto! Agora seu ambiente está preparado para nossos laboratórios. A partir daqui, você poderá seguir as instruções do professor para completar os exercícios práticos. Se surgir qualquer dúvida, consulte os materiais de apoio indicados no Moodle e neste repositório. 

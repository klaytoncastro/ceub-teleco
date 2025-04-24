# Telecomunicações

Esta disciplina apresenta os fundamentos em telecomunicações, e este repositório é voltado à prática em redes digitais, simulação de topologias, roteamento avançado, com uso de tecnologias amplamente adotadas na academia e na indústria. Abaixo, apresentamos as instruções de instalação e configuração do ambiente.

## Ambiente de Laboratório

Durante os laboratórios, utilizaremos ferramentas de simulação e ambientes virtualizados para configurar dispositivos de rede, analisar protocolos e compreender seu funcionamento de forma realista. 

Para isso, será utilizado o Docker para configurar o simulador GNS3 e outras ferramentas, permitindo a criação de cenários de rede replicáveis a partir de qualquer computador, de forma padronizada e prática.

O Docker é uma plataforma de virtualização leve que permite empacotar aplicações e todas as suas dependências (bibliotecas, configurações e código) em ambientes isolados, chamados containers. Esses containers são altamente portáveis e podem ser executados em qualquer sistema operacional compatível. Essa solução é amplamente usada no mercado para criar ambientes consistentes de maneira automática, eliminando a necessidade de configurar cada aplicação ou serviço manualmente em diferentes máquinas.

Nos sistemas Microsoft Windows, recomenda-se a utilização do WSL (Windows Subsystem for Linux) para a instalação do Docker. O WSL é um recurso nativo do Windows que permite a execução de distribuições Linux sem emulação ou virtualização completa, como o Hyper-V ou VirtualBox. Projetado para facilitar o desenvolvimento de software no Windows, o WSL oferece uma integração eficiente entre os dois sistemas operacionais.

**Nota**: Usuários de sistemas baseados em Linux ou MacOS não precisam utilizar o WSL, pois esses sistemas já possuem suporte nativo ao Docker. Para executar containers, basta instalar o Docker diretamente, sem a necessidade de qualquer subsistema ou ferramenta adicional.

## Passo 1: Verificação dos Requisitos

Certifique-se de que você está utilizando o sistema operacional Windows 10 ou uma versão superior, e que o recurso de virtualização de hardware está habilitado. 

**Nota:** Você pode verificar na BIOS/UEFI de seu dispositivo se o recurso de virtualização de hardware está ativado (`VT-x` para processadores Intel, como `Core i3`, `i5`, `i7`, etv; e `AMD-V` para processadores `Ryzen 5`, `Ryzen 7`, etc). 

## Passo 2: Ativação do WSL
Abra o aplicativo **PowerShell ISE**, como administrador, e execute os comandos abaixo:

```bash
# Ativa o subsistema Windows para Linux
dism /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

# Ativa a plataforma de máquina virtual necessária para o WSL 2
dism /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# Instala o WSL
wsl --install

# Define a versão 2 do WSL como padrão
wsl --set-default-version 2
```

## Passo 3: Escolha de uma Distribuição

- Caso ainda não utilize WSL com uma distribuição Linux embarcada, instale uma distribuição pelo aplicativo **Microsoft Store** ou via **linha de comando (CLI)**. Recomenda-se instalar o **Ubuntu 24.04**.

- Caso prefira realizar a instalação de forma rápida via CLI, execute o comando abaixo diretamente no **PowerShell ISE**, execute o comando abaixo: 

<!--
wsl -l -o
-->

```bash
# Instala o Ubuntu 24.04
wsl --install -d Ubuntu-24.04

# Define o Ubuntu 24.04 como distribuição padrão ao executar o comando wsl. 
wsl --setdefault Ubuntu-24.04
```

- Finalizada a instalação, reinicie o seu computador. 

## Passo 4: Configuração Inicial

- Inicie o aplicativo WSL e configure o usuário e a senha da distribuição. Depois disso você terá acesso a um kernel e a um terminal Linux. Você pode invocar o Powershell ou Terminal Windows e acionar o comando `wsl` para ter acesso ao ambiente. 
- Além do acesso via CLI, você também pode navegar via nas pastas e arquivos do ambiente Linux através do Windows Explorer (ícone do pinguim), diretamente na pasta da sua distribuição.
- Caso prefira uma interface gráfica (GUI), considere o uso do [Visual Studio Code (VS Code)](https://code.visualstudio.com/), que permite estabelecer uma sessão de terminal com seu ambiente WSL. Esta alternativa pode ser mais intuitiva e amigável para edição de arquivos, unificando sua experiência de desenvolvimento e administração. Procure o professor caso tenha dúvidas na utilização dessa ferramenta.

## Passo 5: Instalação do Docker

- O Docker Desktop for Windows fornece uma interface gráfica e integra o Docker ao sistema, facilitando a execução e o gerenciamento de containers diretamente no Windows.
- Baixe e instale o [Docker Desktop for Windows](https://docs.docker.com/desktop/install/windows-install/#:~:text=Docker%20Desktop%20for%20Windows%20%2D%20x86_64). Após a instalação, o Windows pode solicitar que você faça o logout e o login novamente para aplicar as alterações. 

## Passo 6: Utilização do Ambiente

Ao longo do curso, você será guiado nas atividades práticas organizadas nas subpastas deste repositório. Essas atividades envolvem tanto o uso do terminal (CLI) quanto interfaces gráficas via navegador, conforme o objetivo de cada etapa.

Grande parte das configurações será feita no terminal Linux — uma interface de texto que permite executar comandos de forma direta, automatizável e precisa. Embora possa parecer menos intuitivo no início, o terminal é a principal ferramenta utilizada por profissionais de infraestrutura e redes em ambientes reais. Dominar seu uso é um diferencial técnico e uma exigência de mercado.

Por outro lado, também utilizaremos interfaces gráficas. O principal exemplo é o GNS3, uma ferramenta clássica e amplamente adotada por empresas, provedores e plataformas de certificação como Cisco e Juniper. Suas topologias serão montadas de forma visual, diretamente no navegador, facilitando a compreensão dos cenários e a interação com os dispositivos virtuais.

Ou seja, o terminal será utilizado para a execução de comandos e automações essenciais, enquanto a orquestração das topologias de rede será feita com o GNS3, acessado via navegador.

### Comandos Básicos

Para quem está tendo seu primeiro contato com terminal, abaixo segue um glossário com os principais comandos que usaremos nas atividades:

| Comando | Descrição                                              | Exemplo                                |
|---------|--------------------------------------------------------|----------------------------------------|
| `whoami`| Exibe o nome do usuário atual                           | `whoami`                               |
| `pwd`   | Mostra o diretório atual                                | `pwd`                                  |
| `history`| Exibe o histórico de comandos                          | `history`                              |
| `cd`    | Navega entre diretórios                                 | `cd /home`                             |
| `ls`    | Lista arquivos e diretórios                             | `ls -la`                               |
| `mkdir` | Cria um novo diretório                                  | `mkdir nova_pasta`                     |
| `cp`    | Copia arquivos ou diretórios                            | `cp arquivo.txt /caminho/destino/`     |
| `mv`    | Move ou renomeia arquivos e diretórios                  | `mv arquivo.txt /caminho/destino/`     |
| `rm`    | Remove arquivos ou diretórios                           | `rm arquivo.txt`                       |
| `cat`   | Exibe o conteúdo de um arquivo                          | `cat arquivo.txt`                      |
| `grep`  | Pesquisa por padrões em arquivos                        | `grep "termo" arquivo.txt`             |
| `vim`   | Editor de texto no terminal                             | `vim arquivo.txt`                      |
| `chmod` | Altera permissões de arquivos                           | `chmod 755 arquivo.txt`                |
| `chown` | Modifica o proprietário de um arquivo ou diretório      | `chown usuario:grupo arquivo.txt`      |
| `ps`    | Lista processos em execução                             | `ps aux`                               |
| `ping`  | Testa a conectividade com um host                       | `ping google.com`                      |
| `wget`  | Baixa conteúdo da web                                   | `wget http://exemplo.com/arquivo.zip`  |

### Inicialização 

- Inicie o Docker Desktop.
- Em seguida, abra o WSL ou, se preferir, utilize o terminal integrado no VS Code.
- Para acessar o GNS3, abra o navegador e vá até: `http://localhost:3080` — após o ambiente estar ativo.

**Importante**: O acesso ao GNS3 só estará funcional após a conclusão do [Laboratório 02](https://github.com/klaytoncastro/ceub-teleco/tree/main/gns3), quando o ambiente do simulador será devidamente configurado. Siga a ordem proposta na [tabela de projetos práticos](https://github.com/klaytoncastro/ceub-teleco?tab=readme-ov-file#projetos-pr%C3%A1ticos) para garantir o funcionamento correto do ambiente.

---

## Projetos Práticos

Durante este módulo do curso, os projetos práticos serão realizados em etapas progressivas. Cada etapa depende da anterior, seguindo a ordem de instalação e configuração do ambiente, e posterior desenvolvimento dos laboratórios:

| #  | Laboratório                             | Tipo de Aplicação       | Descrição                                                                |
|----|-----------------------------------------|-------------------------|--------------------------------------------------------------------------|
| 01 | [Instalação do Ambiente](/README.md)    | **WSL + Docker**        | Instalação do Windows Subsystem for Linux e Docker para containers.      |
| 02 | [Introdução ao Simulador GNS3](/gns3/)  | **Simulador de Redes**  | Clonagem do repositório e configuração do ambiente GNS3 via Docker.      |
| 03 | [Roteamento Dinâmico com OSPF](/ospf/)  | **Protocolo Intra-AS**  | Comunicação entre redes usando OSPF para estabelecer roteamento dinâmico.|
| 04 | [Integração com BGP](/bgp/)             | **Protocolo Inter-AS**  | Integração com redes externas via BGP, redistribuindo rotas do OSPF.     |


## Conclusão

Pronto! Agora seu ambiente está preparado para iniciar nossos laboratórios. A partir daqui, você poderá seguir as instruções do professor para completar os exercícios práticos. Se surgir qualquer dúvida, consulte os materiais de apoio indicados no Moodle e neste repositório. 

**Nota:** Se não conseguir avançar, entre em contato com o professor para obter orientação sobre a instalação.

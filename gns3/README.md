<!--
https://www.linkedin.com/pulse/ixbr-atinge-40-tbps-e-convida-%C3%A0-reflex%C3%A3o-sobre-o-futuro-moreiras-nv8hf/?trackingId=5yKB%2FpNbemoXUIh%2BgYU3dQ%3D%3D
-->

# Simulação de Redes com GNS3

## Introdução

O **GNS3 (Graphical Network Simulator 3)** é uma ferramenta robusta para simular redes em um ambiente virtual. Ele permite a simulação de dispositivos de rede, como **roteadores, switches, firewalls e PCs**, possibilitando a configuração e o teste de redes de forma realista. O GNS3 oferece uma oportunidade única de colocar em prática os conceitos de redes de computadores aprendidos em sala de aula, sem a necessidade de hardware físico. Além disso, utilizando ambientes baseados em containers, podemos simular serviços essenciais de rede, como **Mail eXchanger (MX)**, **DNS (Domain Name System)**, **DHCP (Dynamic Host Configuration Protocol)**, entre outros, permitindo a criação de ambientes de rede completamente funcionais e complexos.

## História e Comunidade

O GNS3 surgiu em 2008 como uma evolução de ferramentas de simulação de redes mais simples, como o **Dynamips**, com o objetivo de oferecer uma interface gráfica amigável para a configuração de redes simuladas. Inicialmente, o foco estava na emulação de roteadores Cisco, utilizando o **IOS (Internetwork Operating System)**, mas a ferramenta expandiu rapidamente para suportar uma ampla variedade de dispositivos e fabricantes. O GNS3 é mantido por uma comunidade ativa de desenvolvedores e entusiastas de redes ao redor do mundo, que contribuem com atualizações regulares, tutoriais, fóruns de discussão e projetos colaborativos, ajudando novos usuários a dominar a plataforma.

## Objetivo

Este repositório fornece as bases para a configuração e uso do **GNS3** em simulações de rede. Utilizaremos o GNS3 para criar redes simuladas, **configurar protocolos de roteamento** e **testar topologias de rede**, compreendendo o funcionamento e as interações entre dispositivos. Além disso, exploraremos a configuração de **serviços essenciais de rede**, como **DNS** e **DHCP**, aprofundando o entendimento sobre como as redes se mantêm e se configuram automaticamente.

## O que você aprenderá

Com este projeto, você será capaz de:

- Simular e configurar **roteadores**, **switches** e **serviços de rede** como **SMTP**, **IMAP**, **DNS** e **DHCP** de forma virtual.
- Compreender e aplicar protocolos de roteamento como **OSPF**, **RIP**, **EIGRP** e **BGP**.
- Criar e testar **topologias de rede** em um ambiente virtual seguro.
- Configurar e testar **servidores DHCP** para fornecer automaticamente configurações de rede aos dispositivos.
- Implementar e testar **servidores DNS** para resolução de nomes e gerenciamento de domínios.
- Explorar a interação entre **camadas de rede**, serviços e dispositivos em redes complexas.
- Solucionar problemas de conectividade e desempenho de redes.

## Aplicações do GNS3

O GNS3 pode ser utilizado para uma ampla gama de simulações e experimentos de redes, incluindo:

- **Configuração de dispositivos de rede**: Simular roteadores, switches, firewalls e até mesmo computadores para testar cenários reais de rede.
- **Protocolos de Roteamento**: Testar e configurar diversos protocolos de roteamento (OSPF, RIP, EIGRP, BGP).
- **Segurança de Rede**: Simular cenários de segurança, como firewalls e controle de acesso.
- **Monitoramento e Solução de Problemas**: Monitorar o tráfego de rede e identificar gargalos ou problemas de configuração.
- **Serviços de Rede**: Simular e testar a implementação de **DNS**, **DHCP**, **FTP**, **HTTP** e outros serviços de rede.
- **Automatização e Infraestrutura**: Explorar como redes modernas automatizam a configuração de dispositivos com **DHCP**, e como serviços como **DNS** são essenciais para a comunicação em redes complexas.

## Requisitos

- Docker instalado (para rodar o ambiente servidor do GNS3 e outras aplicações, como SMTP, IMAP, DNS, DHCP, Web Server, DBMS, etc).
- Familiaridade com **conceitos de redes de computadores**, como **roteamento**, **switching**, **serviços** e **protocolos de rede**.

## Importação do MikroTik CHR

Para os laboratórios de [OSPF](https://github.com/klaytoncastro/ceub-teleco/tree/main/ospf/) e [BGP](https://github.com/klaytoncastro/ceub-teleco/tree/main/bgp/), utilizaremos o MikroTik CHR (Cloud Hosted Router) — um roteador virtual compatível com múltiplos protocolos de roteamento e serviços para redes de computadores. O processo de importação deste equipamento para o ambiente do simulador GNS3 está ilustrado abaixo:

### 1. Baixe a imagem `.img`

[Download do arquivo `chr-7.16.img.zip`](https://drive.google.com/drive/folders/1d7FwTLtnRSnjJ5k-YRZlORNlY3c1ygQZ?usp=sharing)

![Download](./img/001-Download.png)

### 2. Ignore o alerta de segurança do navegador, se aparecer

![Ignore Alert](./img/002-Ignore_Alert.png)

### 3. Descompacte o arquivo `.zip`

![Unzip](./img/003-Unzip.png)

### 4. Acesse o GNS3 no navegador

![Login](./img/004-Login.png)

### 5. Crie um novo projeto

![Add Project](./img/005-Add_Project.png)

### 6. Crie um novo template

![New Template](./img/006-New_Template.png)

### 7. Escolha a opção *Install from controller*

![Import Appliance](./img/007-Import_Appliance.png)

### 8. Filtre e selecione *MikroTik CHR*

![Filter CHR](./img/008-Filter_CHR.png)

### 9. Selecione o arquivo `.img` descompactado

![Select CHR](./img/009-Select_CHR.png)

### 10. Aguarde e confirme a mensagem de sucesso

![Import Success](./img/010-Import_Success_Create.png)

### 11. Nomeie o template como `Router` e finalize

![Router Template](./img/011-Router.png)

### 12. Confirme que o roteador está disponível na biblioteca

![Router Available](./img/012-Router_Available.png)

### 13. Consulte os mapeamentos de portas e para gerenciar os dispositivos via protocolo `telnet`

![Telnet Hosts](./img/013-Telnet_Hosts.png)

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

- Docker instalado (para rodar o servidor GNS3 e outras aplicações, como SMTP, IMAP, DNS, DHCP, Web Server, DBMS, etc).
- Familiaridade com **conceitos de redes de computadores**, como **roteamento**, **switching**, **serviços de rede** e **protocolos de rede**.

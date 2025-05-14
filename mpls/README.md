# Multiprotocol Label Switching (MPLS)

## 1. Introdução 

Redes convergentes são infraestruturas de comunicação que integram múltiplos serviços (voz, vídeo, dados) e tecnologias distintas (TDM, IP, Ethernet) em uma plataforma unificada. O objetivo é simplificar a operação, reduzir custos e permitir a entrega dinâmica de serviços sobre um mesmo meio físico. 

Nesse cenário, o **Multiprotocol Label Switching (MPLS)** foi desenvolvido pela IETF como um padrão tecnológico para viabilizar a comutação de pacotes baseada em rótulos (*labels*). Seu objetivo é otimizar o encaminhamento de dados, complementando (mas não substituindo) o roteamento IP tradicional. O MPLS é frequentemente referido como uma tecnologia de **Camada 2,5** do modelo OSI, pois atua entre a comutação de quadros (Camada 2) e o roteamento IP (Camada 3).

>Em suma, o MPLS atua como uma camada de abstração, permitindo a coexistência de redes legadas e modernas através de encapsulamento universal para convergência de serviços. 

## 2. Como o MPLS Funciona?

Em suma, o MPLS opera independentemente do protocolo de camada 3 (IPv4/IPv6) ou de camada 2 (Ethernet, ATM) escolhido, atuando como uma camada de abstração que encapsula qualquer payload. Isso permite integração com redes legadas (ATM/FR) e modernas (IPv6, Ethernet).

### Princípios de Operação do MPLS

| Aspecto                | Descrição                                                                                     |
|------------------------|-------------------------------------------------------------------------------------------------|
| **Classificação por Rótulos** | Pacotes recebem um **rótulo MPLS** no *Ingress Router (LER)*. O rótulo inclui os bits **EXP (Experimental)**, que definem a **Classe de Serviço (CoS)** para QoS. |
| **Encaminhamento em LSPs**   | *Label Switch Routers (LSRs)* trocam rótulos com operações de **PUSH (Adicionar)**, **POP (Remover)** e **SWAP (Substituir)**, permitindo encaminhamento eficiente sem consultar tabelas IP. |
| **Túneis LSP (Label Switched Paths)** | São caminhos pré-definidos que permitem priorizar tráfego crítico (VoIP, vídeo) sobre dados comuns (web, e-mail). |
| **Tabelas de Encaminhamento** | O MPLS utiliza duas tabelas distintas para gerenciamento de tráfego: **FIB (Forwarding Information Base)** e **LFIB (Label Forwarding Information Base)**. |

### Tabelas de Encaminhamento Detalhadas

| Tabela | Função                                | Populada por                              |
|--------|----------------------------------------|--------------------------------------------|
| **FIB (Forwarding Information Base)** | Encaminha pacotes IP tradicionais.         | RIB (Routing Information Base) – OSPF/BGP. |
| **LFIB (Label Forwarding Information Base)** | Gerencia pacotes MPLS.                     | LDP (Label Distribution Protocol), RSVP-TE, BGP (VPNs). |

### Classificação e Encaminhamento

- **Ao Ingressar na Rede MPLS:** Um pacote (web, VoIP, vídeo) recebe um **rótulo MPLS** que define:
  - Seu **caminho (LSP - Label Switched Path)**.
  - Sua **prioridade (CoS - Classe de Serviço)**.
- **Encaminhamento por Prioridade:** Os pacotes são roteados com base em rótulos, evitando a análise de cabeçalhos IP:
  - **PUSH:** Adiciona um rótulo ao pacote (Ingress LER).
  - **SWAP:** Substitui o rótulo atual (Core LSR).
  - **POP:** Remove o rótulo (Egress LER).
- **QoS Garantida (Qualidade de Serviço):** O MPLS permite priorizar tráfego sensível a latência (VoIP, vídeo) sobre tráfego comum (web, e-mail).

### Exemplo de Operação:
- Um pacote de **voz (VoIP)** recebe um rótulo com **CoS 4 (Alta Prioridade)** e segue um **LSP com baixa latência**.
- Um pacote de **e-mail (Web)** recebe um rótulo com **CoS 0 (Baixa Prioridade)** e é roteado de maneira menos prioritária.

### Classes de Serviço (CoS) no MPLS:

| Classe | Bits EXP (Bin/Dec) | Prioridade       | Aplicação Típica                          |
|--------|--------------------|------------------|------------------------------------------|
| CoS 0  | 000 (0)            | Baixa            | Web, e-mail                              |
| CoS 1  | 001 (1)            | Média-Baixa      | FTP, aplicativos corporativos            |
| CoS 2  | 010 (2)            | Média            | Streaming (Vídeo sob Demanda)            |
| CoS 3  | 011 (3)            | Média-Alta       | Videoconferência                         |
| CoS 4  | 100 (4)            | Alta             | VoIP (tráfego sensível a latência)       |
| CoS 5  | 101 (5)            | Alta Prioridade  | Gerenciamento de rede                    |
| CoS 6  | 110 (6)            | Muito Alta       | Sinalização (tráfego de controle)        |
| CoS 7  | 111 (7)            | Máxima           | Emergências (aplicações de resgate)      |

### Vantagens do MPLS em Redes Convergentes
- **Abstração de Protocolos:** O MPLS é capaz de transportar dados de vários protocolos, como IPv4, IPv6, Ethernet, ATM, Frame Relay e até redes ópticas (SDH/SONET, OTN, DWDM) por meio do padrão **MPLS-TP (Transport Profile)**. Isso permite integrar tecnologias legadas e modernas em uma infraestrutura unificada.

- **Maior Eficiência:** O encaminhamento de pacotes é otimizado através dos **Label Switched Paths (LSPs)**, onde os pacotes são comutados com base em rótulos predefinidos, evitando o processamento do cabeçalho IP em cada salto.

- **Maior Flexibilidade e QoS:** O MPLS oferece uma abordagem granular para **Qualidade de Serviço (QoS)**, permitindo definir diferentes **Classes de Serviço (CoS)** por meio dos bits **EXP (Experimental)** do cabeçalho MPLS. Isso possibilita priorizar tráfego crítico (voz e vídeo) em relação a outros tipos de dados.

- **Suporte a Redes de Transporte (MPLS-TP):** O MPLS-TP é uma versão otimizada do MPLS para redes de transporte óptico (OTN, SDH, DWDM), garantindo recursos de monitoramento e gerenciamento (OAM - Operation, Administration, and Maintenance).

### Cenário Prático:

Em uma rede corporativa com MPLS:
- **VoIP (CoS 4)** e **videoconferência (CoS 3)** trafegam em túneis LSP de alta prioridade.
- **Dados comuns (CoS 0-1)** utilizam rotas secundárias, sem competir por recursos.
- Pacotes não rotulados (IP puro) são processados pela **FIB**; pacotes MPLS, pela **LFIB**.

## 3. Objetivo

Este laboratório propõe a configuração de uma rede com MPLS, aplicando os conceitos de Label Switching, **LSR (Label Switch Router)**, **LER (Label Edge Router)** e as tabelas de encaminhamento (**FIB** e **LFIB**). 

* A topologia será baseada na estrutura dos labs OSPF e BGP.
* O OSPF é um protocolo de roteamento de estado de link que descobre automaticamente os caminhos na rede e preenche a tabela de roteamento (RIB).
* O LDP (Label Distribution Protocol) usa as rotas OSPF para distribuir rótulos (labels) e preencher a LFIB.
* O BGP (Border Gateway Protocol) é usado para distribuir rótulos em VPNs MPLS (L3VPN), conectando diferentes redes (AS - Sistemas Autônomos).
* Roteadores LSR e LER conectados em uma rede MPLS.

### Configuração da Topologia no GNS3

* Adicionar os roteadores MikroTik CHR.
* Conectar as interfaces conforme o diagrama.
* Configurar endereços IP e OSPF.

### 3.1. Configuração Inicial dos Roteadores

* Configurar interfaces de rede:

```shell
/interface bridge add name=LAN
/interface bridge port add bridge=LAN interface=ether1
/ip address add address=192.168.1.1/24 interface=LAN
```

* Habilitar OSPF:

```shell
/routing ospf instance add name=OSPF-R1 router-id=1.1.1.1
/routing ospf network add network=192.168.1.0/24 area=0.0.0.0
```

### 3.2. Ativando o MPLS

<!--
* Habilitar o MPLS nas interfaces de backbone:

```shell
/mpls interface add interface=ether1
/mpls ldp enable=yes
```
-->

### 3.3. Validação e Testes

* Verificar conectividade com ping entre os roteadores.
* Visualizar tabelas FIB e LFIB:

```shell
/mpls forwarding-table print
```

## 4. Considerações Finais 

O MPLS consolidou-se como uma das tecnologias mais versáteis da história das telecomunicações precisamente por sua capacidade de desacoplar a comutação de pacotes (via rótulos) dos protocolos subjacentes, tornando-se a "camada de convergência" entre tecnologias legadas e modernas. Essa característica multiprotocolo permitiu que redes antes fragmentadas — como as baseadas em ATM, Frame Relay ou SDH/SONET — fossem gradualmente integradas em infraestruturas unificadas, reduzindo custos operacionais e aumentando a eficiência.

Sua adoção massiva em redes de operadoras, datacenters e WANs corporativas deve-se à flexibilidade para suportar serviços distintos (voz, vídeo, dados) com QoS granular, além de viabilizar VPNs de camada 2 e 3 sobre a mesma topologia. Assim, o MPLS não apenas substituiu as tecnologias obsoletas, mas também pavimentou o caminho para arquiteturas dinâmicas, como:

- 5G (onde MPLS-TP garante transporte confiável entre células de rádio e núcleo da rede),
- Edge Computing (com LSPs priorizando tráfego crítico entre datacenters distribuídos),
- SDN/NFV (onde o MPLS fornece a abstração necessária para orquestração programável).

Assim, o MPLS superou seu papel originalmente proposto, indo além de um otimizador de roteamento IP, tornando-se o alicerce da convergência de serviços digitais. Mesmo em ambientes nativamente baseados em IP (como IPv6 e SD-WAN), a comutação por rótulos continua relevante em um mundo cada vez mais orientado a serviços sob demanda e baixa latência.



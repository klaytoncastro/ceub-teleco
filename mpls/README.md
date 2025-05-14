# Multiprotocol Label Switching (MPLS)

## 1. Visão Geral

O **Multiprotocol Label Switching (MPLS)** é uma tecnologia de comutação de pacotes que utiliza rótulos (*labels*) para otimizar o encaminhamento de dados, complementando (mas não substituindo) o roteamento IP tradicional. Por convenção, podemos dizer que ele atua na chamada **Camada 2.5** do modelo OSI, intermediando serviços de Camada 2 e 3 (L2 e L3) ao fornecer: 

- **Abstração de protocolos**: Opera sobre IPv4, IPv6, Ethernet, ATM, Frame Relay e até redes ópticas (MPLS-TP).
- **Eficiência**: Encaminhamento mais rápido via rótulos pré-definidos (*Label Switched Paths - LSPs*).
- **Flexibilidade**: Suporta serviços diversificados (voz, vídeo, dados) com QoS granular.

### Integração com Tecnologias Legadas

| Tecnologia          | Antes do MPLS                            | Com MPLS                                            |
|---------------------|------------------------------------------|-----------------------------------------------------|
| **SDH/SONET**       | Circuitos comutados rígidos              | Infraestrutura reutilizada para túneis MPLS         |
| **Frame Relay**     | Circuitos virtuais (PVCs/SVCs) limitados | Substituído por LSPs com QoS e escalabilidade       |
| **ATM**             | Células de 53 bytes, complexo e caro     | Transporte unificado de voz/vídeo/dados             |
| **Metro Ethernet**  | QoS limitado, baixa escalabilidade       | VPNs L2/L3 (VPLS, L3VPN) com serviços gerenciados   |
| **IP over Ethernet**| Roteamento lento, QoS básico             | Encaminhamento acelerado por rótulos + QoS granular |

>O MPLS atua como uma camada de abstração, permitindo a coexistência de redes legadas e modernas através de encapsulamento universal.

---

## 2. Como o MPLS Funciona?

### Princípios de Operação

1. **Classificação por Rótulos**:
   - Pacotes recebem um **rótulo MPLS** no *ingress router* (LER - Label Edge Router).
   - Bits **EXP (Experimental)** definem a **Classe de Serviço (CoS)** para QoS.

2. **Encaminhamento em LSPs**:
   - *Label Switch Routers (LSRs)* trocam rótulos (não consultam tabelas IP) via:
     - **PUSH** (adicionar), **POP** (remover), **SWAP** (substituir rótulo).
   - Túneis **LSP** priorizam tráfego crítico (VoIP, vídeo) sobre dados comuns.

3. **Tabelas de Encaminhamento**:
   | Tabela | Função                                | Populada por                     |
   |--------|---------------------------------------|-----------------------------------|
   | **FIB** (Forwarding Info Base) | Encaminha pacotes IP tradicionais | RIB (rotas OSPF/BGP)             |
   | **LFIB** (Label FIB)          | Gerencia pacotes MPLS              | LDP, RSVP-TE, BGP (VPNs)         |

### Classes de Serviço (CoS)

| Classe | Bits EXP (Bin/Dec) | Prioridade       | Aplicação Típica                  |
|--------|--------------------|------------------|----------------------------------|
| CoS 0  | `000` (0)          | Baixa            | Web, e-mail                      |
| CoS 1  | `001` (1)          | Média-Baixa      | FTP, apps corporativos           |
| CoS 2  | `010` (2)          | Média            | Streaming (Vídeo sob Demanda)    |
| CoS 3  | `011` (3)          | Média-Alta

# Multiprotocol Label Switching (MPLS)

## 1. Visão Geral

O **Multiprotocol Label Switching (MPLS)** é uma tecnologia de comutação que permite endereçar dados com base em rótulos (labels) ao invés de atuar unicamente sobre cabeçalhos IP, células ou circuitos. Embora não substitua o roteamento IP (Layer 3, o MPLS otimiza o encaminhamento ao agregar rótulos aos pacotes, estabelecendo caminhos pré-definidos (Label Switched Paths - LSPs) com base em rotas descobertas por protocolos que atuam em camada 3, como OSPF e BGP. Ou seja, MPLS não é um protocolo de roteamento autônomo mas, convencionalmente, podemos dizer que ele atua entre as camadas 2 e 3 do modelo OSI (Layer 2.5). 

Isso permite maior eficiência e flexibilidade em redes de ampla escala ou com serviços variados em operação, pois o MPLS é capaz de compatibilizar a transmissão de serviços de voz, vídeo e dados operando sobre diferentes infraestruturas e mecanimos de encapsulamento e endereçamento, uma vez que não está vinculado a um protocolo de camada de rede específico. Assim sendo, pode transportar IPv4 e IPv6 (pacotes IP tradicionais), Ethernet (frames L2, como em redes Metro Ethernet), Células ATM e Pacotes Frame Relay (tecnologias de redes legadas, com roteadores capazes de fazer a adaptação), assim como outros protocolos. Como MPLS pode encapsular praticamente qualquer payload, é usado até em redes ópticas – MPLS-TP. 

Essa versatilidade é extremamente útil em ambientes de redes corporativas, operadoras de telecomunicações e datacenters. Nesse contexto, o MPLS desempenhou um papel fundamental na transição e integração de tecnologias legadas, usando diversas infraestruturas de rede WAN como camada física, mas conferindo mais flexibilidade e eficiência no transporte, rotulado segundo estratégias de priorização de tráfego. Dentre as principais tecnologias que o MPLS substituiu ou integrou destacam-se: 

### Frame Relay (FR):

- Antes do MPLS: O Frame Relay era amplamente utilizado para interconectar redes de longa distância (WAN), oferecendo um serviço de comutação de pacotes em uma infraestrutura compartilhada. Ele era baseado em circuitos virtuais (PVCs e SVCs) e apresentava limitação em termos de escalabilidade e suporte a diferentes tipos de tráfego.

- Com o MPLS: A arquitetura de MPLS permitiu substituir o Frame Relay ao oferecer suporte a diferentes classes de serviço (CoS) e alta escalabilidade, mantendo a eficiência no encaminhamento de pacotes.

### Asynchronous Transfer Mode (ATM):

- Antes do MPLS: O ATM era amplamente utilizado em redes de telecomunicações para transporte de voz, vídeo e dados, utilizando pequenas células de 53 bytes. Apesar de sua eficiência para transporte de tráfego de tempo real, como voz, o ATM era complexo e caro de gerenciar.

- Com o MPLS: O MPLS substituiu o ATM ao permitir o transporte de diversos tipos de tráfego, com maior flexibilidade e capacidade de suporte a diferentes protocolos (voz, vídeo, dados), além de reduzir a complexidade de configuração e gerenciamento.

### Redes SDH/SONET:

- Antes do MPLS: As redes SDH (Synchronous Digital Hierarchy) e SONET (Synchronous Optical Network) substituiram as redes PDH (Plesio-Synchronous Digital Hierarchy) e eram usadas para transporte de dados em alta velocidade em enlaces ópticos, com foco em circuitos comutados. 

- Depois do MPLS: O MPLS foi implementado sobre redes SDH/SONET, permitindo que estas infraestruturas tradicionais continuassem operando, mas com maior flexibilidade para o transporte de múltiplos tipos de tráfego e serviços (dados, voz, vídeo), através de túneis MPLS. 

### Redes Metro Ethernet:

- Antes do MPLS: As redes Metro Ethernet eram utilizadas para interconectar clientes em uma área metropolitana, mas eram limitadas em termos de suporte a QoS e escalabilidade. 

- Depois do MPLS: O MPLS introduziu o conceito de VPNs L2 (Camada 2) e L3 (Camada 3: VPLS e L3VPN), permitindo que as redes Metro Ethernet oferecessem serviços gerenciados de maneira eficiente e escalável. 

### Redes Ethernet (IP over Ethernet):

- Antes do MPLS: As redes IP tradicionais eram usadas para roteamento de pacotes, mas apresentavam limitações em termos de QoS (Qualidade de Serviço), balanceamento de carga e encaminhamento eficiente. 

- Depois do MPLS: O MPLS permitiu que redes IP continuassem operando com maior eficiência, graças ao uso de rótulos (labels) que aceleram o encaminhamento de pacotes e permitem a aplicação de QoS granular.

>Em suma, o MPLS opera independentemente do protocolo de camada 3 (IPv4/IPv6) ou de camada 2 (Ethernet, ATM) escolhido, atuando como uma camada de abstração que encapsula qualquer payload. Isso permite integração com redes legadas (ATM/FR) e modernas (IPv6, Ethernet).

## 2. Como o MPLS Funciona?

O MPLS opera como uma camada intermediária entre o roteamento IP tradicional e o encaminhamento de pacotes, agregando eficiência e controle à rede. Enquanto protocolos como OSPF e BGP descobrem rotas e preenchem a tabela de roteamento (**RIB**), o MPLS utiliza rótulos para direcionar tráfego de forma ágil, suportando IPv4, IPv6, Ethernet, VPNs L2 (VPLS), VPNs L3 (L3VPN) e outros serviços, sem exigir alterações profundas na infraestrutura.

### Princípios de Operação:

**Classificação e Rótulos**:
   - Ao ingressar na rede MPLS, um pacote (seja tráfego web, VoIP ou vídeo) recebe um **rótulo MPLS**, que define seu caminho e prioridade.
   - O rótulo inclui os bits **EXP (Experimental)**, que determinam a **Classe de Serviço (CoS)** e garantem **QoS** (Qualidade de Serviço).

**Encaminhamento por Prioridade**:
   - Os **LSRs (Label Switch Routers)** encaminham pacotes através de **Túneis LSP (Label Switched Paths)**, caminhos pré-definidos que priorizam tráfego crítico (ex.: voz, vídeo) sobre dados menos sensíveis (ex.: e-mails).
   - Isso minimiza **latência**, **jitter** e **perda de pacotes**, essencial para aplicações em tempo real como VoIP e videoconferência.

**Tabelas de Encaminhamento**:
   - **FIB (Forwarding Information Base)**: Usada para pacotes IP tradicionais (sem rótulos), derivada da RIB. Contém destino, interface de saída e próximo salto (*next-hop*).
   - **LFIB (Label Forwarding Information Base)**: Exclusiva para MPLS, define ações como:
     - **PUSH** (adicionar rótulo), **POP** (remover rótulo), **SWAP** (substituir rótulo).
   - Populada por protocolos como **LDP**, **RSVP-TE** (para engenharia de tráfego) e **BGP** (em L3VPNs).

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

## 3. Configuração da Topologia no GNS3

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

O MPLS é "multiprotocolo" porque desacopla o mecanismo de comutação (rótulos) do protocolo subjacente, permitindo integração com diversas tecnologias legadas e modernas. Isso foi crucial para sua adoção em redes heterogêneas (operadoras, datacenters, WAN corporativa). O MPLS se estabeleceu como uma tecnologia generalista e flexível, capaz de substituir ou integrar diversas tecnologias legadas, simplificando a infraestrutura de rede e ampliando sua capacidade de suporte a diferentes serviços e protocolos.
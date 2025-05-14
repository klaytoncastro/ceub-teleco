# Multiprotocol Label Switching (MPLS)

## 1. Visão Geral

O **Multiprotocol Label Switching (MPLS)** é uma tecnologia de comutação que permite endereçar dados com base em rótulos (labels) ao invés cabeçalhos IP, células ou circuitos. Assim sendo, o MPLS não é um protocolo de roteamento autônomo, mas convencionalmente atua entre as camadas 2 e 3 do modelo OSI (Layer 2.5). Ou seja, apesar de não substituir integralmente o roteamento IP (Layer 3), ele otimiza o tráfego, agilizando o processo de encaminhamento com a aplicação de rótulos para estabelecer caminhos de comutação (Label Switched Paths - LSPs), definidos a partir das rotas descobertas pelos protocolos de roteamento como OSPF e BGP. Isso permite maior eficiência e flexibilidade em redes de ampla escala e serviços variados em operação. 

Por essa razão, a implementação de MPLS é capaz de compatibilizar a transmissão de serviços de voz, vídeo e dados, operando sobre diferentes tecnologias de encapsulamento e endereçamento, uma vez que não está vinculado a um protocolo de camada de rede específico, podendo transportar IPv4 e IPv6 (pacotes IP tradicionais), Ethernet (frames L2, como em redes Metro Ethernet), Células ATM e Pacotes Frame Relay (tecnologias de redes legadas, com roteadores capazes de fazer a adaptação), assim como outros protocolos. Como MPLS pode encapsular praticamente qualquer payload, é usado até em redes ópticas – MPLS-TP. Essa versatilidade é extremamente útil em ambientes de redes corporativas, operadoras de telecomunicações e datacenters. 

Nesse contexto, o MPLS desempenhou um papel fundamental na transição e integração de tecnologias legadas, usando diversas infraestruturas de rede WAN como camada física, mas conferindo mais flexibilidade e eficiência no transporte, rotulado segundo estratégias de priorização de tráfego. Dentre as principais tecnologias que o MPLS substituiu ou integrou destacam-se: 

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

## 2. Como o MPLS Funciona? 

O MPLS atua como uma camada de abstração entre L2 e L3:

- Rótulos (Labels) são independentes do protocolo → Um pacote IPv4, IPv6 ou Ethernet recebe um rótulo MPLS, que é usado para comutação (não importa o conteúdo interno).
- Flexibilidade de transporte → O mesmo backbone MPLS pode carregar tráfego IP, VPNs L2 (VPLS), VPNs L3 (L3VPN), etc., sem modificações profundas na infraestrutura.
- Por sua vez, os protocolos de roteamento (OSPF, BGP) são responsáveis por descobrir os melhores caminhos na rede e preencher a tabela de roteamento **(RIB)** com essas rotas. O MPLS usa rótulos **(labels)** para identificar os pacotes e aplicar políticas de **QoS** (Qualidade de Serviço) de acordo com o tipo de tráfego e sua classificação de serviço (**CoS**). 
- Parte do cabeçalho MPLS que permite definir a prioridade do pacote. Cada rótulo contém os bits **Exp** (Experimental bits), que definem a prioridade do pacote. 
- Nos roteadores da rede MPLS **(Label Switch Routers - LSR)**, os pacotes são encaminhados de acordo com sua prioridade. 
- **Túneis LSP (Label Switched Paths)**: Caminhos específicos criados para garantir que o tráfego crítico (voz e vídeo) siga rotas otimizadas.
- **Voz (VoIP)**: O MPLS suporta o transporte de tráfego de voz em redes IP, implementando **Qualidade de Serviço (QoS)** por meio da priorização dos pacotes de voz. Isso é essencial para manter a qualidade da chamada, evitando atrasos (latência), perdas de pacotes e jitter (variação de atraso). A classe de serviço (CoS) do MPLS permite priorizar o tráfego de voz em relação ao tráfego de dados comum. Por exemplo, o tráfego recebe o rótutlo de **CoS 4 (Alta Prioridade)**. 
- **Vídeo**: O MPLS também é amplamente utilizado para transmissão de vídeo em tempo real (videoconferências, streaming), garantindo baixa latência e alta qualidade. Por exemplo, o tráfego recebe o rótutlo de **CoS 3 (Média-Alta Prioridade)**. 
- **Dados**: O MPLS permite transportar diferentes tipos de dados (tráfego web, arquivos, aplicativos) com roteamento eficiente e suporte a múltiplas classes de serviço. Ele pode segmentar o tráfego de acordo com a importância e garantir que o tráfego crítico (como voz e vídeo) tenha prioridade sobre o tráfego menos importante (como downloads). Por exemplo, o tráfego de acesso a conteúdo web e emails é configurado como **CoS 0 (Baixa Prioridade)**.

| Classe de Serviço | Bits EXP (Decimal) | Prioridade         | Uso Comum                                    |
|-------------------|---------------------|-------------------|----------------------------------------------|
| CoS 0             | 000 (0)             | Baixa             | Tráfego de Dados Comum (Web, Email)          |
| CoS 1             | 001 (1)             | Média-Baixa       | Tráfego Corporativo (FTP, Aplicativos)       |
| CoS 2             | 010 (2)             | Média             | Vídeo sob Demanda (Streaming)                |
| CoS 3             | 011 (3)             | Média-Alta        | Videoconferência                             |
| CoS 4             | 100 (4)             | Alta              | Voz (VoIP), Tráfego Sensível a Latência      |
| CoS 5             | 101 (5)             | Alta Prioridade   | Tráfego Crítico (Gerenciamento de Rede)      |
| CoS 6             | 110 (6)             | Muito Alta        | Tráfego de Controle (Sinalização)            |
| CoS 7             | 111 (7)             | Máxima            | Tráfego de Emergência (Aplicações de Resgate)|

Para efetivar essas condições, os roteadores implementam a **FIB (Forwarding Information Base)**, uma tabela de encaminhamento que armazena as rotas ativas que o roteador usa para encaminhar pacotes. Ela é derivada da tabela de roteamento (**RIB - Routing Information Base**), que contém todas as rotas conhecidas pelo roteador. É usada principalmente para pacotes que não possuem rótulos MPLS, ou seja, pacotes IP tradicionais. Cada entrada na FIB contém o endereço de destino (IP) do pacote, a interface de saída (por onde o pacote será encaminhado) e o próximo salto (next-hop), que é o endereço do roteador seguinte. Por sua vez, a **LFIB (Label Forwarding Information Base)** é uma tabela de encaminhamento específica para pacotes MPLS, ou seja, para pacotes que possuem rótulos (labels). Ela contém as instruções de como tratar os pacotes com rótulos MPLS, tais como: 

- Adicionar um novo rótulo (PUSH).
- Remover um rótulo (POP).
- Substituir um rótulo (SWAP).

A FIB é usada para encaminhamento de pacotes IP tradicionais, enquanto a LFIB é uma extensão específica para pacotes com rótulos MPLS. A LFIB é populada automaticamente por protocolos de distribuição de rótulos, como:

- LDP (Label Distribution Protocol): Protocolo padrão para distribuição de rótulos em redes MPLS.
- RSVP-TE (Resource Reservation Protocol - Traffic Engineering): Para redes MPLS com engenharia de tráfego.
- BGP (Border Gateway Protocol): Para VPNs MPLS L3 (L3VPN).

Em suma, em uma rede corporativa com MPLS, o tráfego de voz (VoIP) recebe a maior prioridade (Classe de Serviço Alta). O tráfego de vídeo (videoconferência) é priorizado logo abaixo do tráfego de voz. O tráfego de dados comuns (acesso à web, e-mails) é configurado com prioridade menor.  Se o pacote não possui um rótulo (IP puro), ele é encaminhado com base na FIB. Se o pacote possui um rótulo (MPLS), ele é encaminhado com base na LFIB. 

## 2. Objetivo

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
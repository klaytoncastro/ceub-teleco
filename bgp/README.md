# Border Gateway Protocol (BGP)

## 1. Visão Geral

O **Border Gateway Protocol (BGP)**, definido pela [RFC 4271](https://www.rfc-editor.org/rfc/rfc4271) é o principal protocolo adotado na Internet para gerenciar como os pacotes de dados são roteados por diferentes redes ou **Sistemas Autônomos (AS)**. Um AS é um grupo de endereços IP sob controle de uma única entidade, como um provedor de serviços de internet (ISP), uma grande empresa ou uma universidade, uma espécie de coleção de redes IP que compartilham uma política de roteamento comum e que são controladas por uma única organização ou entidade. 

Cada AS é identificado por um número único, chamado **Número de Sistema Autônomo (ASN)**. Um bom site para fazer consultas sobre os AS é o [bph.he.net](https://bph.he.net). Enquanto protocolos de roteamento como o **OSPF (Open Shortest Path First)** e **RIP (Routing Information Protocol)** funcionam dentro de um único AS, o BGP é usado para roteamento entre diferentes AS, tornando-o essencial para a infraestrutura global da Internet.

Imagine que um grande provedor de serviços de internet (ISP) controle várias redes internas. Essas redes formam um AS e têm suas próprias políticas de roteamento, como preferir certos caminhos ou evitar certas rotas por motivos econômicos ou de desempenho. Quando o tráfego sai desse AS para a internet global, ele usa o BGP para se comunicar com outros AS, como o de outro ISP.

## 2. Como funciona o BGP?

O **BGP (Border Gateway Protocol)** é um protocolo de roteamento de grande escala usado para trocar informações de roteamento entre sistemas autônomos (AS) na internet. Ele decide o caminho mais eficiente para os pacotes de dados seguirem com base em políticas e atributos.

### Principais Atributos do BGP

- **AS Path**: uma lista de AS que os pacotes devem atravessar para chegar ao destino.
- **Next-hop**: o próximo salto no caminho até o destino.
- **Local Preference**: indica a preferência por uma determinada rota dentro de um AS.
- **MED (Multi-Exit Discriminator)**: utilizado para influenciar o roteamento quando existem múltiplas saídas para um AS.

### Exemplo de Configuração BGP

Aqui está um exemplo simples de uma configuração de BGP em um roteador Mikrotik CHR com o sistema RouterOS:

1. Habilite o BGP: No MikroTik RouterOS, você deve configurar o BGP através de comandos no terminal. 

```bash
# Adicionar uma instância BGP com ASN 65001
/routing bgp instance
add name=default as=65001 router-id=192.168.1.1

# Adicionar o vizinho BGP (AS 65002)
/routing bgp peer
add name=peer1 remote-address=192.168.1.2 remote-as=65002 update-source=lo0

# Anunciar a rede 10.0.0.0/24
/routing bgp network
add network=10.0.0.0/24
```

- BGP Instance: Definimos o ASN local (65001) e o router-id para o roteador.
- BGP Peer: Criamos o peer BGP que se conecta ao vizinho 192.168.1.2 no ASN 65002. O update-source aqui se refere à interface que será usada para a troca de atualizações de roteamento (neste caso, lo0 é a interface loopback).
- BGP Network: Anunciamos a rede 10.0.0.0/24 para o peer.

- **Nota**: Certifique-se de que a interface Loopback0 ou a interface correta esteja configurada e disponível no dispositivo MikroTik.
 
<!--
```bash
router bgp 65001
  neighbor 192.168.1.2 remote-as 65002
  network 10.0.0.0 mask 255.255.255.0
  neighbor 192.168.1.2 update-source Loopback0
```
-->

## 3. Comparação com outros protocolos de roteamento

| Característica         | RIP                                          | OSPF                                      | BGP                                                      |
|------------------------|----------------------------------------------|-------------------------------------------|----------------------------------------------------------|
| Tipo de Protocolo       | Roteamento baseado em vetor de distância     | Roteamento baseado em estado de link      | Roteamento entre sistemas autônomos (path-vector)         |
| Métrica                | Número de saltos                             | Custo baseado em largura de banda         | Atributos de política de rotas                           |
| Limite de Saltos        | 15 saltos                                    | Ilimitado                                 | Ilimitado                                                |
| Convergência            | Lenta                                        | Rápida                                    | Lenta                                                    |
| Escalabilidade          | Baixa (adequado para redes pequenas)         | Alta (adequado para grandes redes)        | Muito alta (adequado para a internet)                    |

## 4. Atividade Prática

O objetivo desta atividade é estabelecer a comunicação entre múltiplos segmentos de rede em uma topologia mais complexa, utilizando os protocolos de roteamento dinâmico OSPF e BGP. Você irá configurar uma rede de campus composta por dois blocos que utilizam OSPF para roteamento interno e dois novos roteadores conectados via BGP, ampliando a topologia para incluir redes externas. Essa configuração permite observar a integração entre OSPF e BGP, redistribuindo rotas entre os dois protocolos. 

<!--A atividade visa desenvolver habilidades práticas na implementação de roteamento dinâmico para suportar ambientes em expansão e simular cenários reais em que diferentes protocolos de roteamento trabalham em conjunto para proporcionar conectividade eficiente e escalável entre diferentes redes e áreas de uma organização.

Ao final, será possível validar a conectividade entre dispositivos de diferentes blocos e sub-redes, reforçando o entendimento de conceitos de convergência, redistribuição de rotas e topologias de redes complexas.
-->

A topologia desta atividade envolve uma rede de campus composta por vários roteadores e sub-redes conectadas para simular um ambiente de rede em larga escala. Aqui está uma descrição detalhada da configuração:

### Bloco 1 e Bloco 2:

Os blocos representam duas redes distintas, como diferentes departamentos ou prédios de um campus, interconectados via os roteadores R1 e R2, que utilizam o protocolo de roteamento OSPF. No Bloco 1, o roteador R1 está conectado a uma sub-rede 192.168.0.0/24, onde reside o PC1. No Bloco 2, o R2 conecta-se a outra sub-rede, 10.0.0.0/24, onde está o PC3. Esta topologia já foi configurada no laboratório de OSPF. 

### Conexão entre as redes roteadas por OSPF e a nova rede roteada por BGP. 

- Um switch central conecta os roteadores R1, R2 e R3 por meio de suas interfaces (ether7 em R1 e R3). Esse switch permite que R3 troque rotas diretamente com R1 e R2, aprendendo e propagando rotas da rede via OSPF para outras partes da topologia.

- O R3 desempenha o papel de ponto de redistribuição entre o OSPF e o BGP. Ele está conectado ao switch central e possui uma interface na mesma sub-rede de R1 (192.168.0.0/24), o que permite que ele participe da rede OSPF e aprenda as rotas de R1 e R2.

- Adicionalmente, o R3 está conectado a R4 em outra interface, utilizando a sub-rede 172.20.0.0/30, onde é estabelecida a comunicação via BGP com o R4, permitindo a troca de rotas externas entre eles. R4 também está conectado a outra sub-rede (192.168.10.0/24), onde está localizado o PC5, que simula um dispositivo final em uma rede externa que deseja acessar serviços e recursos disponíveis nas redes de R1 e R2.


### Comunicação com novos dispositivos e redistribuição de rotas:

O R3 redistribui as rotas aprendidas pelo OSPF para o BGP e vice-versa, garantindo que as redes dos blocos (Bloco 1 e Bloco 2) sejam acessíveis para o R4 e o PC5. Com essa configuração, o PC5 pode se comunicar com os demais PCs e vice-versa, simulando uma rede escalável e integrada com múltiplos segmentos e protocolos de roteamento. O R3 vai atuar como ponto de interconexão entre as redes OSPF e BGP, então precisamos de uma configuração que redistribua rotas entre os dois protocolos. No R4, configuramos o BGP para anunciar a rede diretamente conectada onde está o PC5 e para estabelecer uma sessão BGP com o R3. Configure o PC5 para obter um endereço IP compatível e garantir a comunicação com R4.

```bash
# Endereços IP no R3
/ip address add address=192.168.0.2/24 interface=ether7    # Conexão com R1 na mesma sub-rede para troca de rotas OSPF
/ip address add address=172.20.0.1/30 interface=ether1     # Conexão BGP com R4

# Configuração do OSPF no R3
/routing ospf instance set [find default=yes] router-id=3.3.3.3
/routing ospf area add name=backbone area-id=0.0.0.0 instance=default
/routing ospf interface-template add interfaces=ether7 area=backbone

# Redistribuir rotas BGP no OSPF
/routing ospf redistribute add protocol=bgp

# Configuração do BGP no R3
/routing bgp instance add name=default as=65001 router-id=3.3.3.3
/routing bgp peer add name=peer_to_R4 remote-address=172.20.0.2 remote-as=65002

# Redistribuir redes OSPF no BGP
/routing bgp network add network=192.168.0.0/24
/routing bgp network add network=10.0.0.0/24

# Configuração do R4 (BGP)
/ip address add address=172.20.0.2/30 interface=ether1     # Conexão BGP com R3
/ip address add address=192.168.10.1/24 interface=ether7   # Rede de PC5

# Configuração do BGP no R4
/routing bgp instance add name=default as=65002 router-id=4.4.4.4
/routing bgp peer add name=peer_to_R3 remote-address=172.20.0.1 remote-as=65001

# Anunciar a rede do PC5 no BGP
/routing bgp network add network=192.168.10.0/24

# Configuração do PC5
ip 192.168.10.2/24
gateway 192.168.10.1
```

<!--

R3: 

[admin@MikroTik] > /ip address add address=192.168.0.2/24 interface=ether7
[admin@MikroTik] > /ip address add address=172.20.0.1/30 interface=ether1
[admin@MikroTik] > /routing ospf instance set [find default=yes] router-id=3.3.3.3
[admin@MikroTik] > /routing ospf area add name=backbone area-id=0.0.0.0 instance=default
[admin@MikroTik] > /routing ospf instance add name=default router-id=3.3.3.3
[admin@MikroTik] > /routing ospf area add name=backbone area-id=0.0.0.0 instance=default
[admin@MikroTik] > /routing ospf interface-template add interfaces=ether7 area=backbone
[admin@MikroTik] /routing/bgp> /routing/bgp/connection add name=peer_to_R4 remote.address=172.20.0.2 remote.as=65002 local.role=ebgp
[admin@MikroTik] /routing/bgp/template> /routing/bgp/template set 0 output.filter=bgp-out
[admin@MikroTik] /routing/bgp/template> /routing/bgp/connection enable peer_to_R3
[admin@MikroTik] /routing/bgp/template> /routing/bgp/connection disable peer_to_R4
[admin@MikroTik] /routing/bgp/template> /routing/bgp/connection enable peer_to_R4
[admin@MikroTik] /routing/bgp/template> /routing/bgp/connection/print


R4:

[admin@MikroTik] > /ip address add address=172.20.0.2/30 interface=ether1
[admin@MikroTik] > /ip address add address=192.168.10.1/24 interface=ether7
[admin@MikroTik] > /routing/bgp/connection add name=peer_to_R3 remote.address=172.20.0.1 remote.as=65001 local.role=ebgp
[admin@MikroTik] > /routing/bgp/connection disable peer_to_R3
[admin@MikroTik] > /routing/bgp/connection enable peer_to_R3
[admin@MikroTik] > /routing/bgp/connection/print

-->

### Verificação de Conectividade

Essas configurações permitirão a comunicação entre todas as redes e dispositivos na topologia, com o R3 redistribuindo rotas entre OSPF e BGP para que todas as sub-redes estejam acessíveis mutuamente. Após configurar as redes, primeiramente verifique a conectividade e os anúncios de rota. Efetue o ping entre os PCs:

- Do PC5, realize o ping para PC1 (192.168.0.x) e PC3 (10.0.0.x).
- Do PC1 e PC3, realize o pingue para o PC5 (192.168.10.2).
- Em R1, R2, R3 e R4, verifique se todas as rotas foram aprendidas adequadamente via OSPF ou BGP:

```bash
/ip route print
```

- Em R3 e R4, confirme que a sessão BGP está estabelecida e as rotas estão sendo trocadas:

```bash
/routing bgp peer print
/routing bgp advertisements print
```

## 5. Conclusão

O BGP desempenha um papel crucial no gerenciamento do tráfego de dados entre redes independentes, garantindo uma internet interconectada e funcional. Através de atributos e políticas flexíveis, ele permite que cada AS decida o melhor caminho para o tráfego, de forma eficiente e escalável. Como resultado, o BGP, apesar de sua convergência mais lenta, é a escolha natural para garantir a escalabilidade e resiliência da infraestrutura global de rede.
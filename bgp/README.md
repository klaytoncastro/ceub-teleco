# Border Gateway Protocol (BGP)

## 1. Visão Geral

O **Border Gateway Protocol (BGP)**, definido pela [RFC 4271](https://www.rfc-editor.org/rfc/rfc4271) é o principal protocolo adotado na Internet para gerenciar como os pacotes de dados são roteados por diferentes redes ou **Sistemas Autônomos (AS)**. Um AS é um grupo de endereços IP sob controle de uma única entidade, como um provedor de serviços de internet (ISP), uma grande empresa ou uma universidade, uma espécie de coleção de redes IP que compartilham uma política de roteamento comum e que são controladas por uma única organização ou entidade. 

Cada AS é identificado por um número único, chamado **Número de Sistema Autônomo (ASN)**. Um bom site para fazer consultas sobre os AS é o [bph.he.net](https://bgp.he.net). Enquanto protocolos de roteamento como o **OSPF (Open Shortest Path First)** e **RIP (Routing Information Protocol)** funcionam dentro de um único AS, o BGP é usado para roteamento entre diferentes AS, tornando-o essencial para a infraestrutura global da Internet.

Imagine que um grande provedor de serviços de internet (ISP) controle várias redes internas. Essas redes formam um AS e têm suas próprias políticas de roteamento, como preferir certos caminhos ou evitar certas rotas por motivos econômicos ou de desempenho. Quando o tráfego sai desse AS para a internet global, ele usa o BGP para se comunicar com outros AS, como o de outro ISP.

## 2. Como funciona o BGP?

O **BGP (Border Gateway Protocol)** é um protocolo de roteamento de grande escala usado para trocar informações de roteamento entre sistemas autônomos (AS) na internet. Ele decide o caminho mais eficiente para os pacotes de dados seguirem com base em políticas e atributos.

### Principais Atributos do BGP

- **AS Path**: uma lista de AS que os pacotes devem atravessar para chegar ao destino.
- **Next-hop**: o próximo salto no caminho até o destino.
- **Local Preference**: indica a preferência por uma determinada rota dentro de um AS.
- **MED (Multi-Exit Discriminator)**: utilizado para influenciar o roteamento quando existem múltiplas saídas para um AS.

## 3. Comparação com outros protocolos de roteamento

| Característica         | RIP                                          | OSPF                                      | BGP                                                      |
|------------------------|----------------------------------------------|-------------------------------------------|----------------------------------------------------------|
| Tipo de Protocolo       | Roteamento baseado em vetor de distância     | Roteamento baseado em estado de link      | Roteamento entre sistemas autônomos (path-vector)         |
| Métrica                | Número de saltos                             | Custo baseado em largura de banda         | Atributos de política de rotas                           |
| Limite de Saltos        | 15 saltos                                    | Ilimitado                                 | Ilimitado                                                |
| Convergência            | Lenta                                        | Rápida                                    | Lenta                                                    |
| Escalabilidade          | Baixa (adequado para redes pequenas)         | Alta (adequado para grandes redes)        | Muito alta (adequado para a internet)                    |

## 4. Atividade Prática

O objetivo desta atividade é estabelecer a comunicação entre múltiplos segmentos de rede em uma topologia mais complexa, integrando os protocolos de roteamento dinâmico OSPF e BGP. Nesta prática, você estenderá a configuração de uma rede de campus composta por dois blocos principais que utilizam OSPF para roteamento interno e adicionará dois novos roteadores conectados via BGP, criando um caminho para redes externas.

O R3 atuará como ponto de redistribuição entre OSPF e BGP, aprendendo as rotas internas da rede (OSPF) e propagando-as externamente via BGP. O R4 representará a rede da operadora e estará conectado a um site externo (PC5). Essa configuração simula um ambiente real de integração de redes LAN e WAN, mantendo a separação entre os dois domínios.

Ou seja, OSPF continuará gerenciando o roteamento interno no núcleo da rede para garantir rápida convergência e atualizações ágeis de estado de link, como fizemos em nosso laboratório anterior. Ao mesmo tempo, o BGP será responsável por transportar os intervalos de IP de clientes, mantendo as rotas do núcleo isoladas das rotas dos clientes. Assim, teremos configurado um ambiente híbrido, onde roteadores podem partilhar e redistribuir rotas usando OSPF e/ou BGP, simulando um ambiente real de rede em larga escala. Este é o mapa esperado para a topologia: 

![Conectividade entre a rede de acesso (Campus) ao Datacenter e à Internet](/img/topologyBGP.png)

Nas próximas seções vamos configurar a parte lógica. Segue a descrição detalhada da configuração:

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
/ip address add address=192.168.0.3/24 interface=ether7    # Conexão com R1 na mesma sub-rede para troca de rotas OSPF
/ip address add address=172.20.0.1/30 interface=ether1     # Conexão BGP com R4

# Configuração do OSPF no R3
/routing ospf instance add name=default router-id=3.3.3.3
/routing ospf area add name=backbone area-id=0.0.0.0 instance=default
/routing ospf interface-template add interfaces=ether7 area=backbone
/routing ospf instance disable [find name=default]
/routing ospf instance enable [find name=default]

# Configuração do BGP no R3
/routing/bgp/template set default as=65001 router-id=3.3.3.3
/routing/bgp/connection add name=peer_to_R4 remote.address=172.20.0.2 remote.as=65002 local.role=ebgp

# Redistribuir rotas BGP no OSPF
/routing ospf instance set [find name=default] redistribute=bgp

# Redistribuir redes conectadas e OSPF no BGP
/routing bgp connection set [find name=peer_to_R4] output.redistribute=connected,ospf

# Configuração do R4 (BGP)
/ip address add address=172.20.0.2/30 interface=ether1     # Conexão BGP com R3
/ip address add address=192.168.10.1/24 interface=ether7   # Rede de PC5

# Configuração do BGP no R4

/routing/bgp/template set default as=65002 router-id=4.4.4.4
/routing/bgp/connection add name=peer_to_R3 remote.address=172.20.0.1 remote.as=65001 local.role=ebgp

# Redistribuir a rede do PC5 (diretamente conectado) no BGP
/routing bgp connection set [find name=peer_to_R3] output.redistribute=connected

# Configuração do PC5
ip 192.168.10.2/24 gateway 192.168.10.1
```

### Verificação de Conectividade

Essas configurações permitirão a comunicação entre todas as redes e dispositivos na topologia, com o R3 redistribuindo rotas entre OSPF e BGP para que todas as sub-redes estejam acessíveis mutuamente. Após configurar as redes, primeiramente verifique a conectividade e os anúncios de rota. Efetue o ping entre os PCs:

- Do PC5, realize o ping para PC1 (192.168.0.x) e PC3 (10.0.0.x).
- Do PC1 e PC3, realize o ping para o PC5 (192.168.10.2).
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

O BGP desempenha um papel crucial no gerenciamento do tráfego de dados entre redes independentes, garantindo uma internet interconectada e funcional. Através de atributos e políticas flexíveis, ele permite que cada AS decida o melhor caminho para o tráfego, de forma eficiente e escalável. Como resultado, o BGP, apesar de sua convergência mais lenta se comparado ao OSPF ou RIP, é a escolha natural para garantir a escalabilidade e resiliência da infraestrutura global de rede.

Nesse sentido, a atividade prática visa desenvolver habilidades na implementação de roteamento dinâmico para suportar ambientes em expansão e simular cenários reais em que diferentes protocolos de roteamento trabalham em conjunto para proporcionar conectividade eficiente e escalável entre diferentes redes e áreas de uma organização. Ao validar a conectividade entre dispositivos de diferentes blocos e sub-redes, reforça-se o entendimento de conceitos de convergência, redistribuição de rotas e topologias de redes complexas, habilidades cruciais para um engenheiro de redes no mercado. 

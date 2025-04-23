# Border Gateway Protocol (BGP)

## 1. Visão Geral

O **Border Gateway Protocol (BGP)**, definido pela [RFC 4271](https://www.rfc-editor.org/rfc/rfc4271) é o principal protocolo adotado na Internet para gerenciar como os pacotes de dados são roteados por diferentes redes ou **Sistemas Autônomos (AS)**. Um AS é um grupo de endereços IP sob controle de uma única entidade, como um provedor de serviços de internet (ISP), uma grande empresa ou uma universidade, uma espécie de coleção de redes IP que compartilham uma política de roteamento comum e que são controladas por uma única organização ou entidade. 

Cada AS é identificado por um número único, chamado **Número de Sistema Autônomo (ASN)**. Um bom site para fazer consultas sobre os AS é o [bgp.he.net](https://bgp.he.net). Enquanto protocolos de roteamento como o **OSPF (Open Shortest Path First)** e **RIP (Routing Information Protocol)** funcionam dentro de um único AS, o BGP é usado para roteamento entre diferentes AS, tornando-o essencial para a infraestrutura global da Internet.

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

### Segue a configuração proposta para o roteador R3:

```bash
# Definindo a interface conectada à rede gerenciada por OSPF, na mesma sub-rede de R1 e R2
/ip address add address=172.16.0.3/29 interface=ether7

# Definindo a interface de comunicação ponto a ponto com R4, formando a rede gerenciada por BGP
/ip address add address=172.20.0.1/30 interface=ether1

# Inicializando o OSPF em R3 com o Router-ID 3.3.3.3
/routing ospf instance add name=default router-id=3.3.3.3

# Criando a área backbone (área 0) e associando à instância padrão
/routing ospf area add name=backbone area-id=0.0.0.0 instance=default

# Associando a interface ether7 à área backbone para troca de LSAs com R1 e R2
/routing ospf interface-template add interfaces=ether7 area=backbone

# Reiniciando a instância OSPF para aplicar as novas configurações
/routing ospf instance disable [find name=default]
/routing ospf instance enable [find name=default]

# Definindo o ASN e Router-ID de R3 para a instância BGP
/routing/bgp/template set default as=65001 router-id=3.3.3.3

# Estabelecendo a conexão eBGP com o peer R4 (ASN 65002) via rede 172.20.0.0/30
/routing/bgp/connection add name=peer_to_R4 remote.address=172.20.0.2 remote.as=65002 local.role=ebgp

# Redistribuindo rotas aprendidas via BGP para a instância OSPF (para que R1 e R2 possam alcançar redes externas)
/routing ospf instance set [find name=default] redistribute=bgp

# Redistribuindo rotas conectadas e aprendidas via OSPF para o peer BGP (permitindo que R4 alcance as redes internas)
/routing bgp connection set [find name=peer_to_R4] output.redistribute=connected,ospf
```

### Segue a configuração proposta para o roteador R4:

```bash
# Definindo a interface ponto a ponto para conexão BGP com R3
/ip address add address=172.20.0.2/30 interface=ether1

# Definindo a interface conectada à rede local onde está o PC5
/ip address add address=192.168.10.1/24 interface=ether7   

# Definindo o ASN e o Router-ID de R4 para a instância BGP
/routing/bgp/template set default as=65002 router-id=4.4.4.4

# Estabelecendo a sessão eBGP com o peer R3 (ASN 65001) via rede 172.20.0.0/30
/routing/bgp/connection add name=peer_to_R3 remote.address=172.20.0.1 remote.as=65001 local.role=ebgp

# Redistribuindo a rede diretamente conectada (192.168.10.0/24) via BGP para que R3 e os demais dispositivos possam alcançá-la
/routing bgp connection set [find name=peer_to_R3] output.redistribute=connected
```

### Por fim, segue a configuração proposta para o roteador PC5, que simula um site da web:

```bash
# Atribuindo IP fixo e gateway padrão no PC5
ip 192.168.10.2/24 gateway 192.168.10.1
```

### Convergência de Protocolos

Protocolos de roteamento como OSPF e BGP levam alguns instantes para estabelecer vizinhanças e propagar rotas. Esse comportamento é esperado e reflete o funcionamento real desses protocolos em ambientes de produção.

Nos laboratórios simulados, como no GNS3, isso significa que a conectividade nem sempre será imediata após aplicar as configurações. É necessário dar tempo para que as rotas sejam anunciadas, processadas e refletidas na tabela de roteamento.

Você pode utilizar os comandos abaixo para acompanhar o progresso da convergência:

```bash
# Execute em R1, R2, R3 e R4 – Exibe a tabela de rotas atual
/ip route print                        

# Execute em R1, R2 e R3 – Verifica os vizinhos OSPF estabelecidos
/routing ospf neighbor print           

# Execute em R3 e R4 – Mostra o status das sessões BGP (estabelecida ou não)
/routing bgp peer print                

# Execute em R3 e R4 – Exibe os prefixos atualmente anunciados via BGP
/routing bgp advertisements print      
```

Para confirmar que tudo está funcionando como esperado, aguarde de 1 a 3 minutos após configurar os roteadores e execute os comandos acima. Isso garante que as rotas estejam devidamente estabelecidas e que os protocolos tenham formado as vizinhanças esperadas. Depois, siga com os testes de conectividade entre os PCs. 

### Verificação de Conectividade

As configurações estão validadas e devem permitir a comunicação entre todas as redes e dispositivos na topologia, com o R3 redistribuindo rotas entre OSPF e BGP para que todas as sub-redes estejam acessíveis e mutuamente alcançadas. Após configurar o ambiente, primeiramente verifique a conectividade e os anúncios de rota, e depois efetue o ping entre os PCs. 

- Do PC5, realize o ping para PC1 (192.168.0.x) e PC3 (10.0.0.x).
- Do PC1 e PC3, realize o ping para o PC5 (192.168.10.2).
- Em R1, R2, R3 e R4, verifique se todas as rotas foram aprendidas adequadamente via OSPF ou BGP:

```bash
# Exibindo a tabela de roteamento atual
/ip route print
```

- Em R3 e R4, confirme que a sessão BGP está estabelecida e as rotas estão sendo trocadas:

```bash
# Verificando o status das sessões BGP estabelecidas (estado, uptime, ASN remoto)
/routing bgp peer print

# Listando os prefixos anunciados via BGP para os peers configurados
/routing bgp advertisements print
```

## 5. Conclusão

O BGP desempenha um papel fundamental no gerenciamento do tráfego entre redes independentes, estabelecendo as bases para a Internet — uma infraestrutura global composta por redes interconectadas, escalável e de operação descentralizada. Por meio de atributos e políticas flexíveis, cada AS pode definir os melhores caminhos para o tráfego com base em critérios próprios, promovendo eficiência e controle. Embora apresente convergência mais lenta em comparação com protocolos como OSPF ou RIP, o BGP é a escolha natural para garantir resiliência e expansão sustentável na infraestrutura global de rede.

Nesta atividade prática, implementamos roteamento dinâmico para simular ambientes em expansão, integrando diferentes protocolos com o objetivo de garantir conectividade eficiente e escalável entre redes e áreas organizacionais. A validação da comunicação entre dispositivos de diferentes blocos e sub-redes reforçou o entendimento de conceitos como convergência, redistribuição de rotas e topologias complexas — aspectos fundamentais para a atuação prática em engenharia de redes.

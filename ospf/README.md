# Open Shortest Path First (OSPF)

## 1. Visão Geral

O **Open Shortest Path First (OSPF)**, definido pela [RFC 2328](https://www.rfc-editor.org/rfc/rfc2328), é um protocolo de roteamento dinâmico baseado no conceito de **estado de link**. Diferente de protocolos mais simples, como o RIP, que utiliza a contagem de saltos, o OSPF calcula as rotas considerando a largura de banda e outras características dos links, permitindo maior precisão e eficiência na escolha do caminho mais curto para o tráfego.

O OSPF é amplamente utilizado em redes grandes e complexas, como redes corporativas, provedores de serviços de internet (ISPs) e datacenters, devido à sua capacidade de rápida convergência e suporte para redes de grande escala. Nessas redes, a quantidade de dispositivos e a complexidade da infraestrutura tornam impraticável o uso de roteamento estático ou de protocolos dinâmicos menos escaláveis, como o RIP.

Além disso, o OSPF é compatível com diferentes tipos de tecnologias e topologias, como redes Ethernet, Frame Relay e redes ponto a ponto, oferecendo flexibilidade para variadas infraestruturas.

## 2. Por que precisamos de protocolos de roteamento dinâmico? 

### Roteamento Estático

Antes de discutirmos em maiores detalhes o OSPF e outros protocolos dinâmicos de roteamento, é importante entender o conceito de roteamento estático, um método mais simples de definir rotas em uma rede. Nele, as rotas são configuradas manualmente pelo administrador de rede e permanecem fixas, a menos que sejam deliberadamente alteradas. Isso significa que, independentemente de alterações na topologia, como falhas ou adições de novos dispositivos, as rotas estáticas não irão se ajustar automaticamente.

Ou seja, apesar de oferecer algumas vantagens, como facilidade de configuração inicial em redes menores e possibilitar o controle total ao administrador, esta abordagem possui desvantagens significativas quando se trata de escalabilidade e necessidade de manutenção, tornando-se impraticável para redes maiores ou em constante mudança, visto que cada nova rota ou alteração precisaria ser atualizada manualmente. Além disso, em caso de falha em um link, o roteamento estático não consegue redirecionar o tráfego automaticamente para um caminho alternativo. 

### Routing Information Protocol (RIP)

Em redes pequenas, onde as rotas são poucas e as mudanças são raras, o roteamento estático pode ser suficiente. No entanto, à medida que a rede cresce, é cada vez mais relevante a adoção de protocolos de roteamento dinâmico, pois eles automatizam o processo de descoberta e ajuste de rotas, permitindo que a rede se adapte automaticamente a mudanças, como falhas de link ou expansões de infraestrutura. Nas redes de menor escala, o Routing Information Protocol (RIP) é uma alternativa de roteamento dinâmico mais simples ao OSPF. RIP utiliza um algoritmo de vetor de distância para escolher rotas, considerando o número de saltos (hops) entre roteadores. Para isso, ele calcula rotas com base no número de saltos (máximo de 15) e envia atualizações a cada 30 segundos, o que pode sobrecarregar redes maiores. 

Sua simplicidade é uma vantagem para redes menores, mas a convergência lenta e o limite de saltos tornam-no inadequado para ambientes corporativos ou acadêmicos mais complexos. Por essa razão, se há tendência de crescimento da rede, tornar-se interessante utilizar o OSPF desde o princípio, visto que ele utiliza o estado de link como métrica, considerando a largura de banda para determinar o melhor caminho. Além disso, é altamente escalável, possui convergência mais rápida e sem limite de saltos, sendo ideal para redes maiores. OSPF também é mais eficiente, já que envia atualizações apenas quando ocorrem mudanças na rede, reduzindo o tráfego.

<!--
- Exemplo de Configuração do RIP no MikroTik CHR:

```bash
#Configure o IP do roteador R1
/ip address add address=192.168.0.1/24 interface=ether1

#Configure o IP do roteador R2
/ip address add address=10.0.0.1/24 interface=ether1

# Ative o RIP nas interfaces desejadas (neste caso, `ether1` e `ether2`)
/routing rip interface add interface=ether1 receive=v2 send=v2
/routing rip interface add interface=ether2 receive=v2 send=v2

#Especifique as redes que devem ser anunciadas
/routing rip network add network=192.168.1.0/24
/routing rip network add network=10.0.0.0/8

#Redistribua rotas estáticas e rotas diretamente conectadas
/routing rip redistribute add protocol=static
/routing rip redistribute add protocol=connected

#Verifique as rotas aprendidas via RIP e o estado das interfaces.
/ip route print where protocol=rip
/routing rip interface print

#Salve as configurações para garantir que elas sejam mantidas após reinicializações.
/system script save
```
-->

<!--
RIP v1: Esta é a versão original, que suporta roteamento classful, ou seja, ele não envia informações sobre máscaras de sub-rede, o que limita sua flexibilidade em redes modernas.

RIP v2: Introduzido para resolver algumas das limitações do RIP v1, suporta roteamento classless (CIDR), o que permite o uso de máscaras de sub-rede variáveis (VLSM).
RIPng: Versão do RIP que suporta IPv6.
-->

## 3. Como funciona o OSPF?

<!-- **Área 0 (Backbone Area)** é o núcleo de uma rede OSPF e todas as outras áreas devem se conectar a ela. -->

Antes de nos aprofundarmos no OSPF, é importante entender o conceito de Sistema Autônomo (AS). Um AS é uma coleção de redes que compartilham uma política de roteamento comum, geralmente sob a administração de uma única organização, como uma empresa ou provedor de Internet. Dentro de um AS, utilizamos protocolos de roteamento como o OSPF para garantir que os roteadores troquem informações de rota de forma eficiente. Esses protocolos são chamados de intra-AS, pois lidam com o roteamento dentro de um único sistema autônomo. Para a comunicação entre diferentes AS (inter-AS), utilizamos protocolos como o BGP (Border Gateway Protocol), que permite a troca de rotas entre diferentes sistemas autônomos e veremos em maiores detalhes posteriormete. 

Dessa forma, podemos dizer que, enquanto o OSPF cuida do roteamento interno de uma organização, o BGP gerencia o tráfego que cruza as fronteiras organizacionais. O OSPF é um protocolo bastante utilizado para governar redes intra-AS, viabilizanod o roteamento dentro de uma única organização, como uma grande empresa, provedores de serviço de internet (ISP) ou campus universitários. Para alcançar escalabilidade e eficiência, OSPF organiza redes em áreas e considera o **estado de link**. Para definir este estado, o OSPF baseia suas decisões de roteamento no algoritmo de **Dijkstra**, com objetivo de calcular o caminho mais curto entre roteadores. Ele usa uma métrica chamada custo, que é baseada principalmente na largura de banda do link, mas pode ser ajustada manualmente. Assim, o OSPF constrói um mapa completo de todos os roteadores dentro de uma área, o que permite decisões rápidas e eficientes sobre o caminho ideal para o tráfego.

### Principais Conceitos e Componentes do OSPF

O OSPF organiza redes em áreas para reduzir a carga de roteamento. A Área 0 é a espinha dorsal (backbone) da rede OSPF, e todas as outras áreas devem se conectar a ela.

- **Custo**: Métrica baseada na largura de banda de um link. Links de maior largura de banda têm menor custo, e a configuração pode ser ajustada com o comando auto-cost reference-bandwidth para influenciar os cálculos de roteamento.
- **Link-State Advertisements (LSAs)**: Mensagens trocadas entre roteadores OSPF para informar o estado de seus links.
- **Hello Protocol**: Usado para estabelecer e manter adjacências entre roteadores OSPF.
- **DR e BDR**: OSPF utiliza um Designated Router (DR) e um Backup Designated Router (BDR) em redes multiacesso (como Ethernet) para reduzir a quantidade de trocas de mensagens.

- **ABR (Area Border Router)** e **ASBR (Autonomous System Boundary Router)**: Roteadores que conectam diferentes áreas OSPF ou conectam OSPF a outros sistemas autônomos.


<!--

### Exemplo de Configuração OSPF

Aqui está um exemplo de configuração de OSPF em um roteador MikroTik CHR com RouterOS:

```bash
# Habilitar OSPF e definir uma área
/routing ospf instance set [ find default=yes ] router-id=192.168.1.1

/routing ospf area add name=backbone area-id=0.0.0.0

# Adicionar interface à área OSPF
/routing ospf interface add interface=ether1 network-type=broadcast

# Anunciar uma rede
/routing ospf network add network=192.168.1.0/24 area=backbone
```
- OSPF Instance: Define o OSPF e o Router-ID.
- OSPF Area: Define a área backbone (Área 0), que é essencial em uma rede OSPF.
- OSPF Interface: Adiciona uma interface à área configurada.
- OSPF Network: Anuncia uma rede dentro da área OSPF.

-->

## 4. Desafio Prático: estabelecer a comunicação entre dois edifícios


### Roteamento Dinâmico com OSPF

Imagine que estamos em um campus que possui dois blocos de edifícios. Cada bloco abriga diferentes departamentos ou áreas administrativas e acadêmicas, e eles estão interconectados por uma rede local, mas fisicamente separados. A comunicação entre esses dois blocos precisa ser rápida, confiável e eficiente para suportar o tráfego de dados entre os departamentos, como o compartilhamento de documentos, serviços de rede, e sistemas de gestão.

- **Bloco 1** (Departamento Administrativo): No primeiro bloco, está localizado o Departamento Administrativo, onde ocorrem todas as operações financeiras administrativas e de gestão do campus. Este bloco precisa estar constantemente em comunicação com o bloco de Tecnologia para acessar sistemas, dados e serviços.  

- **Bloco 2 (Departamento de Tecnologia)**: Este bloco abriga o Departamento de Tecnologia, que fornece suporte para a infraestrutura de TI do campus. Todos os computadores, servidores e sistemas críticos estão conectados a este bloco. Ele é o responsável por hospedar serviços essenciais como sistemas de autenticação, servidores de arquivos e outros recursos de rede que devem estar acessíveis a todos os outros departamentos.


O objetivo da nossa simulação é configurar a comunicação entre esses dois blocos usando o protocolo de roteamento OSPF. Os dois roteadores (R1 e R2) representam os roteadores que conectam o Bloco 1 ao Bloco 2. Os PCs conectados a cada roteador simulam os usuários e servidores de cada bloco que precisam acessar serviços e recursos de ambos os lados.

Ao utilizar OSPF, os roteadores são capazes de trocar informações de rota dinamicamente, garantindo que, mesmo em caso de mudanças na rede (como falhas ou atualizações de infraestrutura), a comunicação entre os dois blocos continue sem interrupções.

### Vantagens do OSPF no Campus
- **Escalabilidade**: OSPF é ideal para esse tipo de rede, pois pode ser facilmente expandido caso o campus cresça e novos blocos sejam adicionados.
- **Convergência Rápida**: Em caso de falhas na rede ou alterações, o OSPF recalcula rapidamente as melhores rotas para garantir que a comunicação entre os blocos continue funcionando.
- **Otimização do Tráfego**: OSPF usa a métrica de custo, que leva em conta a largura de banda dos links, para garantir que o tráfego siga o caminho mais eficiente, proporcionando melhor desempenho na rede.

### Adicione o roteador à sua biblioteca de dispositivos no GNS3

- Para instalar o roteador Mikrotik CHR no GNS3, baixe o arquivo `chr-7.11.2.img.zip` neste [link](https://drive.google.com/drive/folders/1d7FwTLtnRSnjJ5k-YRZlORNlY3c1ygQZ?usp=sharing)
- Descompacte o arquivo na pasta desejada (`unzip chr-7.11.2.img.zip`) e importe a imagem do roteador no GNS3 conforme instruções do professor. 

### Topologia

Crie um novo projeto no GNS3 e configure a seguinte topologia: 

- Adicione 2 roteadores (R1 e R2); 
- Adicione 4 VPCs (PC1, PC2, PC3 e PC4) 
- Adicione 2 hubs e ligue 2 PCs em cada. 
- Ligue cada um dos hubs a roteadores diferentes;
- Ligue os roteadores entre si;

### Configure o R1

```bash
/ip address add address=192.168.0.1/24 interface=ether7  # Rede de PCs
/ip address add address=172.16.0.1/30 interface=ether1   # Interconexão com R2
/routing ospf instance add name=default router-id=1.1.1.1
/routing ospf area add name=backbone area-id=0.0.0.0
/routing ospf interface-template add interfaces=ether1 area=backbone
```

### Configure o R2

```bash
/ip address add address=10.0.0.1/24 interface=ether7    # Rede de PCs
/ip address add address=172.16.0.2/30 interface=ether1  # Interconexão com R1
/routing ospf instance add name=default router-id=2.2.2.2
/routing ospf area add name=backbone area-id=0.0.0.0
/routing ospf interface-template add interfaces=ether1 area=backbone
```

### Configure o PC1

```bash
ip 192.168.0.2 255.255.255.0
gateway 192.168.0.1
```

### Configure o PC2

```bash
ip 192.168.0.3 255.255.255.0
gateway 192.168.0.1
```

### Configure o PC3

```bash
ip 10.0.0.2 255.255.255.0
gateway 10.0.0.1
```

### Configure o PC4

```bash
ip 10.0.0.3 255.255.255.0
gateway 10.0.0.1
```

## 5. Verificação e Teste de OSPF:

### Verifique os vizinhos OSPF:

Nos dois roteadores (R1 e R2), execute o comando:

```bash
/routing ospf neighbor print

#Você deve ver o outro roteador listado como vizinho, indicando que OSPF está funcionando corretamente.
```

### Verifique as rotas OSPF:

Nos dois roteadores, verifique se as rotas OSPF foram aprendidas:

```bash
#O R1 deve aprender a rota para a rede 10.0.0.0/24, e o R2 deve aprender a rota para 192.168.0.0/24.
/ip route print where protocol=ospf

#Verifique os LSAs e tabelas de roteamento de maneira mais detalhada
/routing ospf lsa print
/ip route print
```

### Teste de Conectividade:

Agora que OSPF está configurado e os roteadores estão trocando rotas, os PCs de diferentes redes devem poder se comunicar. Faça o teste de ping de PC3 para PC2. Se os pings forem bem-sucedidos, a configuração está correta e os roteadores estão permitindo a comunicação entre as redes dos PCs.

## 5. Conclusão

Em resumo, o OSPF é ideal para redes que exigem alta disponibilidade, eficiência e escalabilidade, como em grandes corporações, universidades e provedores de internet (ISPs). Sua capacidade de organizar a rede em áreas, convergir rapidamente e calcular rotas com base na largura de banda o torna uma escolha preferida para ambientes complexos e dinâmicos.

Enquanto o RIP pode ser suficiente para redes menores devido à sua simplicidade, ele apresenta limitações em termos de escalabilidade e convergência. O OSPF, por outro lado, oferece maior controle, eficiência e flexibilidade em redes maiores. Já para comunicação entre diferentes sistemas autônomos (inter-AS), o BGP é a opção recomendada.

Para conferir mais detalhes sobre os comandos utilizados na nossa sessão de prática, você pode acessar a documentação [CLI do RouterOS](https://help.mikrotik.com/docs/display/ROS/Command+Line+Interface). 

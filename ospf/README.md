# Open Shortest Path First (OSPF)

## 1. Visão Geral

O **Open Shortest Path First (OSPF)**, definido pela [RFC 2328](https://www.rfc-editor.org/rfc/rfc2328), é um protocolo de roteamento dinâmico baseado em **estado de link**. Ele é amplamente utilizado em redes grandes e complexas, como redes corporativas e datacenters, devido à sua capacidade de rápida convergência e suporte a redes de grande escala.

OSPF é um protocolo de intra-AS, usado para roteamento dentro de uma única organização, como uma grande empresa, provedores de serviço de internet (ISP) ou campus universitários. Para maior escalabilidade e eficiência, OSPF organiza redes em áreas.

## 2. Como funciona o OSPF?

<!-- **Área 0 (Backbone Area)** é o núcleo de uma rede OSPF e todas as outras áreas devem se conectar a ela. -->

Para definir o **estado de link**, a implementação do OSPF é baseada no algoritmo de **Dijkstra** para calcular o caminho mais curto entre roteadores. Ele usa uma métrica chamada custo, que é baseada principalmente na largura de banda do link, mas pode ser ajustada manualmente. Assim, o OSPF constrói um mapa completo de todos os roteadores dentro de uma área, o que permite decisões rápidas e eficientes sobre o caminho ideal para o tráfego.

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

## 3. Comparação com o RIP (Routing Information Protocol)

O RIP é um protocolo de roteamento baseado em vetor de distância, usado principalmente em redes pequenas. Ele calcula rotas com base no número de saltos (máximo de 15) e envia atualizações a cada 30 segundos, o que pode sobrecarregar redes maiores. Sua simplicidade é uma vantagem para redes menores, mas a convergência lenta e o limite de saltos tornam-no inadequado para redes grandes.

O OSPF, por outro lado, utiliza o estado de link como métrica, considerando a largura de banda para determinar o melhor caminho. Ele é altamente escalável, com convergência rápida e sem limite de saltos, sendo ideal para grandes redes. OSPF também é mais eficiente, já que envia atualizações apenas quando ocorrem mudanças na rede, reduzindo o tráfego.

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

O OSPF é uma excelente escolha para redes internas grandes devido à sua rápida convergência e capacidade de escalar em redes com múltiplos roteadores. Em contraste, o RIP é mais simples e adequado para redes menores, mas encontra limitações severas em termos de escalabilidade e convergência. 

Para redes pequenas, o RIP pode ser suficiente, mas o OSPF oferece maior controle e eficiência para redes complexas. Já para comunicação entre sistemas autônomos (AS) e redes externas, o BGP continua sendo a escolha preferida. 

Para conferir mais detalhes sobre os comandos utilizados, você pode acessar a documentação [CLI do RouterOS](https://help.mikrotik.com/docs/display/ROS/Command+Line+Interface). 

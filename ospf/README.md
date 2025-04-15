# Open Shortest Path First (OSPF)

## 1. Visão Geral

O **Open Shortest Path First (OSPF)**, definido pela [RFC 2328](https://www.rfc-editor.org/rfc/rfc2328), é um protocolo de roteamento dinâmico baseado no conceito de **estado de link**. Diferente de protocolos mais simples, como o RIP, que utiliza a **contagem de saltos**, o OSPF calcula as rotas com outras métricas, que auxiliam a observação de fatores como largura de banda e outras características dos links, o que permite uma maior precisão e eficiência na escolha do caminho a ser considerado o mais curto para o tráfego.

Por essa razão, o OSPF é amplamente utilizado em redes grandes e complexas, que sustentam ambientes corporativos, provedores de serviços de internet (ISPs) e datacenters, devido à sua capacidade de rápida convergência e suporte a grande quantidade de dispositivos, onde a complexidade ou demanda da infraestrutura tornam impraticável o uso de roteamento estático ou de outros protocolos dinâmicos menos escaláveis, como o RIP (Routing Information Protocol).

Além disso, o OSPF se destaca por ser compatível com diferentes tipos de tecnologias de rede, como Ethernet, Frame Relay e topologias ponto a ponto, oferecendo flexibilidade para as mais variadas infraestruturas.

## 2. Por que precisamos de protocolos de roteamento dinâmico? 

### 2.1 Roteamento Estático

Antes de abordar o OSPF em maiores detalhes, é importante compreender os conceitos de roteamento estático, uma forma mais rudimentar de definir rotas em uma rede. Nessa abordagem, as rotas são configuradas manualmente pelo administrador de rede e permanecem fixas, a menos que sejam deliberadamente alteradas novamente. Isso significa que, independentemente de alterações na topologia, como falhas ou adições de novos dispositivos, rotas estáticas não irão se ajustar automaticamente.

Assim sendo, apesar de oferecer algumas vantagens, como facilidade de configuração inicial em redes menores e controle total do administrador, esta abordagem possui desvantagens significativas quando se trata de escalabilidade e necessidade de manutenção, tornando-se impraticável para redes maiores ou em constante mudança, visto que cada nova rota ou necessidade de alteração repercutiria em uma nova demanda de atualização manual. Além disso, em caso de falha em um link, o roteamento estático não conseguiria redirecionar o tráfego automaticamente para um caminho alternativo, trazendo prejuízos à operação da rede. 

### 2.2 Routing Information Protocol (RIP)

Em redes pequenas, onde há poucas rotas e as mudanças são mais raras, o roteamento estático pode ser suficiente. No entanto, à medida que a rede cresce, é cada vez mais relevante a adoção de protocolos de roteamento dinâmico, pois eles automatizam o processo de descoberta e ajuste de rotas, permitindo que a rede se adapte automaticamente a mudanças, como falhas de link ou expansões de infraestrutura. 

Nesse caso, em redes de menor escala, o Routing Information Protocol (RIP) é uma alternativa mais simples ao OSPF. o RIP utiliza um algoritmo de **vetor de distância** para escolher as melhores rotas, considerando o número de saltos (hops) entre roteadores. Para isso, ele calcula os melhores caminhos com base no menor número de saltos (cujo número máximo suportado é 15) e envia atualizações aos roteadores da malha a cada 30 segundos. Este mecanisco, não raro, pode trazer algum nível de sobrecarga, especialmente em redes maiores. 

Entretanto, sua simplicidade apresenta-se como uma vantagem para redes menores, apesar da convergência mais lenta e limitada em saltos, que o tornam inadequado quando se trata de ambientes corporativos ou acadêmicos mais complexos. Por essa razão, se há tendência de crescimento da rede, torna-se interessante utilizar o OSPF desde o princípio, visto que ele utiliza o estado de link como métrica, o que enriquece sobremaneira as possibilidades de configuração da topologia. 

Além disso, o OSPF é altamente escalável, possui convergência mais rápida e sem limite de saltos, sendo ideal para redes maiores. Por essa razão o OSPF também é considerado mais eficiente, já que envia atualizações apenas quando ocorrem mudanças na rede, reduzindo o tráfego de gerenciamento.

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

### Ententendo os Sistemas Autônomos

Antes de nos aprofundarmos no BGP, é importante entender o conceito de Sistema Autônomo (AS). Um AS é uma coleção de redes que compartilham uma política de roteamento comum, geralmente sob a administração de uma única organização, como uma empresa ou provedor de Internet. 

Dentro de um AS, utilizamos protocolos de roteamento como o OSPF para garantir que os roteadores troquem informações de rota de forma eficiente. Esses protocolos são chamados de intra-AS, pois lidam com o roteamento dentro de um único sistema autônomo. Para a comunicação entre diferentes AS (inter-AS), utilizamos protocolos como o BGP (Border Gateway Protocol), que permite a troca de rotas entre diferentes sistemas autônomos e veremos em maiores detalhes posteriormete. 

Dessa forma, podemos dizer que, enquanto o OSPF cuida do roteamento interno de uma organização, o BGP gerencia o tráfego que cruza as fronteiras organizacionais. O OSPF é um protocolo bastante utilizado para governar redes intra-AS, viabilizanod o roteamento dentro de uma única organização, como uma grande empresa, provedores de serviço de internet (ISP) ou campus universitários.

<!-- **Área 0 (Backbone Area)** é o núcleo de uma rede OSPF e todas as outras áreas devem se conectar a ela. -->

### 3.2 Principais Conceitos e Componentes do OSPF

Para alcançar escalabilidade e eficiência, OSPF organiza redes em áreas e considera o **estado de link**. Para definir este estado, o OSPF baseia suas decisões de roteamento no algoritmo de **Dijkstra**, com objetivo de calcular o caminho mais curto entre roteadores. Ele usa uma métrica chamada custo, que é baseada principalmente na largura de banda do link, mas pode ser ajustada manualmente. Assim, o OSPF constrói um mapa completo de todos os roteadores dentro de uma área, o que permite decisões rápidas e eficientes sobre o caminho ideal para o tráfego.

A Área 0 é a espinha dorsal (backbone) da rede OSPF, e todas as outras áreas devem se conectar a ela.

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

### 4.1 Roteamento Dinâmico com OSPF

Imagine que estamos em um campus que possui dois blocos de edifícios. Cada bloco abriga diferentes departamentos ou áreas administrativas e acadêmicas, e eles estão interconectados por uma rede local, mas fisicamente separados. A comunicação entre esses dois blocos precisa ser rápida, confiável e eficiente para suportar o tráfego de dados entre os departamentos, como o compartilhamento de documentos, serviços de rede, e sistemas de gestão.

- **Bloco 1** (Departamento Administrativo): No primeiro bloco, está localizado o Departamento Administrativo, onde ocorrem todas as operações financeiras administrativas e de gestão do campus. Este bloco precisa estar constantemente em comunicação com o bloco de Tecnologia para acessar sistemas, dados e serviços.  

- **Bloco 2 (Departamento de Tecnologia)**: Este bloco abriga o Departamento de Tecnologia, que fornece suporte para a infraestrutura de TI do campus. Todos os computadores, servidores e sistemas críticos estão conectados a este bloco. Ele é o responsável por hospedar serviços essenciais como sistemas de autenticação, servidores de arquivos e outros recursos de rede que devem estar acessíveis a todos os outros departamentos.

O objetivo da nossa simulação é configurar a comunicação entre esses dois blocos usando o protocolo de roteamento OSPF. Os dois roteadores (R1 e R2) representam os roteadores que conectam o Bloco 1 ao Bloco 2. Os PCs conectados a cada roteador simulam os usuários e servidores de cada bloco que precisam acessar serviços e recursos de ambos os lados.

Ao utilizar OSPF, os roteadores são capazes de trocar informações de rota dinamicamente, garantindo que, mesmo em caso de mudanças na rede (como falhas ou atualizações de infraestrutura), a comunicação entre os dois blocos continue sem interrupções.

### 4.2 Vantagens do OSPF no Campus

- **Escalabilidade**: OSPF é ideal para esse tipo de rede, pois pode ser facilmente expandido caso o campus cresça e novos blocos sejam adicionados.
- **Convergência Rápida**: Em caso de falhas na rede ou alterações, o OSPF recalcula rapidamente as melhores rotas para garantir que a comunicação entre os blocos continue funcionando.
- **Otimização do Tráfego**: OSPF usa a métrica de custo, que leva em conta a largura de banda dos links, para garantir que o tráfego siga o caminho mais eficiente, proporcionando melhor desempenho na rede.

### 4.3 Adicionando o roteador à sua biblioteca de dispositivos no GNS3

- Acesse o GNS3 em seu navegador em `http://localhost:3080`. 

- Para instalar o roteador no GNS3, crie um novo projeto e clique em `New Template`. Em `Install appliance from server`, procure por **Mikrotik CHR** e clique em `Install`.

- Verifique qual versão está disponível no simulador (ex.: `7.11.2` ou `7.14.3`). Dependendo da versão disponível, você precisará fornecer a imagem virtual correta do equipamento, que pode ser baixada neste [link](https://drive.google.com/drive/folders/1d7FwTLtnRSnjJ5k-YRZlORNlY3c1ygQZ?usp=sharing). Escolha o arquivo correspondente à versão desejada: `chr-7.11.2.img.zip` ou `chr-7.14.3.img.zip`. Alternativamente vc pode rodar o comando `docker compose pull` a partir da raiz do repositório (ex: `/opt/ceub-teleco`) e atualizar sua imagem do ambiente, podendo usar a versão mais atualizada do router. 

- Após baixar, descompacte o arquivo na pasta desejada usando a Interface Gráfica do seu Sistema Operacional (Windows, macOS, Linux) ou via Linha de Comando:
  
  ```bash
  unzip chr-7.11.2.img.zip
  ```

- Para efetuar seu primeiro acesso, ligue o Router no botão `play` do GNS3. Você será convidado a inserir usuário e senha (`admin` com senha em branco, conforme indicado abaixo). Depois recuse a leitura do regulamento com `n`, defina e confirme uma nova senha, que deverá ser utilizada nos próximos acessos. 

- **Usuário**: admin
- **Senha**: 

- Pronto, agora você tem na biblioteca do simulador um poderoso equipamento virtualizado para modelagem de ambientes intra-AS e inter-AS, com suporte a protocolos de roteamento como RIP, OSPF, BGP e capaz de realizar funções em topologias diversas, como Redes Ethernet e MPLS.


### 4.4 Topologia

Crie um novo projeto no GNS3 e configure a seguinte topologia: 

- Adicione 2 roteadores (R1 e R2); 
- Adicione 4 VPCs (PC1, PC2, PC3 e PC4) 
- Adicione 2 hubs e ligue 2 PCs em cada. 
- Ligue cada um dos hubs a roteadores diferentes;
- Ligue os roteadores entre si;

Agora que temos os dispositivos fisicamente interligados, vamos configurar a parte lógica nas próximas seções. Este é o mapa esperado para a topologia: 

![Conectividade entre os Blocos 1 e 2](/img/topologyOSPF.png)

A opção tradicional, via interface web no simulador (acessível via clique com botão direito em cada dispositivo, opção `web console`) irá funcionar, mas você precisará digitar os comandos na íntegra. Contudo, repare que **cada dispositivo possui uma porta atribuída**. Ex: `localhost:2001`. Para **facilitar a configuração lógica**, recomendo utilizar o protocolo de acesso remoto, utilizando o comando `telnet localhost <porta>` para configurar cada dispositivo. Assim você poderá copiar os comandos abaixo e colar diretamente no terminal. 

### 4.5 Configure em R1 a atuação do OSPF 

```bash
/ip address add address=192.168.0.1/24 interface=ether7  # Rede de PCs
/ip address add address=172.16.0.1/29 interface=ether1   # Interconexão com R2
/routing ospf instance add name=default router-id=1.1.1.1
/routing ospf area add name=backbone area-id=0.0.0.0 instance=default
/routing ospf interface-template add interfaces=ether1 area=backbone
```

### 4.6 Configure em R1 a atuação como DHCP Server

```bash
# Adicionar um pool de endereços IP para o DHCP
/ip pool add name=dhcp_pool_R1 ranges=192.168.0.100-192.168.0.200

# Configurar o servidor DHCP na interface ether7
/ip dhcp-server add interface=ether7 address-pool=dhcp_pool_R1 lease-time=1h name=dhcp_server_R1

# Adicionar o gateway e as opções do DHCP
/ip dhcp-server network add address=192.168.0.0/24 gateway=192.168.0.1
```

### 4.7 Configure em R2 a atuação do OSPF

```bash
/ip address add address=10.0.0.1/24 interface=ether7    # Rede de PCs
/ip address add address=172.16.0.2/29 interface=ether1  # Interconexão com R1
/routing ospf instance add name=default router-id=2.2.2.2
/routing ospf area add name=backbone area-id=0.0.0.0 instance=default
/routing ospf interface-template add interfaces=ether1 area=backbone
```

### 4.8 Configure em R2 a atuação como DHCP Server

```bash
# Adicionar um pool de endereços IP para o DHCP
/ip pool add name=dhcp_pool_R2 ranges=10.0.0.100-10.0.0.200

# Configurar o servidor DHCP na interface ether7
/ip dhcp-server add interface=ether7 address-pool=dhcp_pool_R2 lease-time=1h name=dhcp_server_R2

# Adicionar o gateway e as opções do DHCP
/ip dhcp-server network add address=10.0.0.0/24 gateway=10.0.0.1
```

### 4.9 Ativação das Instâncias OSPF e Propagação de Rotas (R1 e R2) 

Agora adicione as redes locais de cada roteador ao OSPF para que elas sejam propagadas e recarreguem as novas configurações. Dessa forma, os roteadores irão aprender e propagar os caminhos entre as redes dos blocos 1 e 2. 

- Primeiro, em R1: 

```bash
# No R1, configure:
/routing ospf interface-template add networks=192.168.0.0/24 area=backbone
/routing ospf interface-template add networks=172.16.0.0/29 area=backbone
/routing ospf instance disable [find name=default]
/routing ospf instance enable [find name=default]
```

- Depois, em R2: 

```bash
#No R2, configure:
/routing ospf interface-template add networks=10.0.0.0/24 area=backbone
/routing ospf interface-template add networks=172.16.0.0/29 area=backbone
/routing ospf instance disable [find name=default]
/routing ospf instance enable [find name=default]
```

Configurados R1 e R2, passemos para os VPCS, nossos dispositivos clientes. 

### 4.10 Configure os PCs 

Primeiro, o PC1: 

```bash
ip dhcp   #Atribui o IP via DHCP
show      #Mostra as configurações obtidas (IP, máscara, gateway)
```
<!--
#ip 192.168.0.2 255.255.255.0
#gateway 192.168.0.1
-->

### Configure o PC2

```bash
ip dhcp   #Atribui o IP via DHCP
show      #Mostra as configurações obtidas (IP, máscara, gateway)
```
<!--
#ip 192.168.0.3 255.255.255.0
#gateway 192.168.0.1
-->

### Configure o PC3

```bash
ip dhcp   #Atribui o IP via DHCP
show      #Mostra as configurações obtidas (IP, máscara, gateway)
```
<!--
#ip 10.0.0.2 255.255.255.0
#gateway 10.0.0.1
-->

### Configure o PC4

```bash
ip dhcp   #Atribui o IP via DHCP
show      #Mostra as configurações obtidas (IP, máscara, gateway)
```
<!--
#ip 10.0.0.3 255.255.255.0
#gateway 10.0.0.1
-->

## 5. Verificação e Teste:

### 5.1 Verifique o fornecimento de IPs via DHCP

Nos dois roteadores (R1 e R2), execute o comando:

```bash
/ip dhcp-server lease print
```

### 5.2 Verifique os vizinhos OSPF:

A partir dos roteadores (R1 e R2), execute o comando:

```bash
#A partir do R1 faça um ping para R2
ping 172.16.0.2
```

```bash
#A partir do R2 faça um ping para R1
ping 172.16.0.1
```

```bash
# Em cada roteador, você deve ver o outro parceiro OSPF listado como vizinho, indicando que o protocolo está atuando corretamente.
/routing ospf neighbor print
```

### 5.3 Teste de Conectividade dos PCs:

Agora que OSPF está configurado e os roteadores estão trocando rotas, os PCs de diferentes redes devem poder se comunicar. Verifique os IPs em cada PC com o comando `show` e utilize-os para fazer os testes abaixo. 

<!--Faça o teste de ping de PC3 para PC2. Se os pings forem bem-sucedidos, a configuração está correta e os roteadores estão permitindo a comunicação entre as redes dos PCs.-->

```bash
#Exemplo de ping a partir do PC1 para o PC2 (mesma rede):
ping 192.168.0.199
```

```bash
#Exemplo de ping a partir do PC1 para o PC3 (rede distinta):
ping 10.0.0.199
```

### 5.4 Verifique as rotas OSPF:

Novamente a partir dos roteadores, verifique se as rotas OSPF foram aprendidas. O R1 deve aprender a rota para a rede `10.0.0.0/24`, e o R2 deve aprender a rota para `192.168.0.0/24`. 

<!--
/ip route print where protocol=ospf
-->

```bash
# Verifique os LSAs e tabelas de roteamento
/routing ospf lsa print
/ip route print
```

## 6. Conclusão

Enquanto o RIP pode ser suficiente para redes menores devido à sua simplicidade, ele apresenta algumas limitações em termos de eficiência e escalabilidade. 
Por outro lado, o OSPF é o protocolo ideal para ambientes de alta disponibilidade e tolerância à falha, uma vez que ele tem a capacidade de organizar a rede em áreas, convergir mais rapidamente que o RIP e calcular rotas com base no custo, que pode ser modelado de acordo com métricas como a largura de banda, dentre outros fatores.  
Isso o torna uma escolha preferida para organizações públicas e privadas de médio e grande porte, incluindo instituições governamentais e acadêmicas, provedores de serviço de Internet (ISPs), dentre outras organizações que necessitem de recursos de rede mais sofisticados e demandam maior controle e flexibilidade. 
Já para comunicação entre diferentes sistemas autônomos (inter-AS), o BGP é a opção *de-facto* utilizada, sendo o padrão estabelecido na hierarquia da Internet. O dispositivo que utilizamos como roteador em nosso simulador, o MikroTik CHR (Cloud Hosted Router), também oferece suporte para o BGP, que trataremos em nosso próximo laboratório. 
Para obter maiores detalhes sobre os comandos utilizados em nossa sessão de prática, você pode acessar a documentação da CLI (Command-Line Interface) do [RouterOS](https://help.mikrotik.com/docs/display/ROS/Command+Line+Interface). 
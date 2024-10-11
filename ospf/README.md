# Open Shortest Path First (OSPF)

## 1. Visão Geral

O **Open Shortest Path First (OSPF)**, definido pela [RFC 2328](https://www.rfc-editor.org/rfc/rfc2328), é um protocolo de roteamento dinâmico baseado em **estado de link**. Ele é amplamente utilizado dentro de redes grandes e complexas, como redes corporativas e datacenters, devido à sua capacidade de rápida convergência e suporte a redes de grande escala.

O OSPF é um protocolo de **intra-AS**, utilizado para roteamento dentro de uma única organização, como uma grande empresa, provedores de serviço de internet (ISP) ou campus de universidades. Ele costuma ser utilizado para organizar as redes dentro de um AS em **áreas** para maior escalabilidade e eficiência.

<!-- **Área 0 (Backbone Area)** é o núcleo de uma rede OSPF e todas as outras áreas devem se conectar a ela. -->

## 2. Como funciona o OSPF?

O OSPF utiliza o **estado de link**  baseado no algoritmo de **Dijkstra** para calcular o caminho mais curto entre roteadores. Ele usa uma métrica chamada **custo**, que é baseada na largura de banda do link. O OSPF constrói um mapa completo de todos os roteadores dentro de uma área, permitindo que ele tome decisões rápidas e eficientes sobre o caminho ideal para endereçamento dos pacotes. 

### Principais Conceitos e Componentes do OSPF

O OSPF organiza redes em áreas para reduzir a carga de roteamento. A **Área 0** é a espinha dorsal (backbone) da rede OSPF.

- **Custo**: Métrica baseada na largura de banda de um link. Links de maior largura de banda têm menor custo, o que influencia o cálculo do caminho mais curto.
- **Link-State Advertisements (LSAs)**: São mensagens enviadas entre roteadores OSPF para informar o estado de um link.
- **Hello Protocol**: Usado para estabelecer e manter adjacências entre roteadores OSPF.
- **DR e BDR**: OSPF utiliza um **Designated Router (DR)** e um **Backup Designated Router (BDR)** em redes multiacesso (como Ethernet) para reduzir a quantidade de trocas de mensagens.

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

## 3. Comparação com o RIP

### RIP (Routing Information Protocol)

O RIP é um protocolo de roteamento baseado em vetor de distância, usado principalmente em redes pequenas. Ele calcula rotas com base no número de saltos (máximo de 15), enviando atualizações a cada 30 segundos, o que pode sobrecarregar redes maiores. Sua simplicidade é uma vantagem para redes menores, mas a convergência lenta e o limite de saltos tornam-no inadequado para redes grandes.

O OSPF, por outro lado, utiliza o estado de link como métrica, considerando a largura de banda para determinar o melhor caminho. Ele é altamente escalável, com convergência rápida e sem limite de saltos, sendo ideal para grandes redes. O OSPF também é mais eficiente, já que envia atualizações apenas quando ocorrem mudanças na rede, o que reduz o tráfego em comparação com o RIP.


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


## 4. Prática: Configuração do roteamento dinâmico com OSPF

### Adicione o roteador à sua biblioteca de dispositivos no GNS3

- Para instalar o roteador Mikrotik CHR no GNS3, baixe o arquivo `chr-7.11.2.img.zip` neste [link](https://drive.google.com/drive/folders/1d7FwTLtnRSnjJ5k-YRZlORNlY3c1ygQZ?usp=sharing)
- Descompacte o arquivo na pasta desejada (`unzip chr-7.11.2.img.zip`) e importe a imagem do roteador no GNS3 conforme instruções do professor. 

### Topologia

Crie um novo projeto e configure a seguinte topologia: 

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


Verificação e Teste de OSPF:
1. Verifique os vizinhos OSPF:
Nos dois roteadores (R1 e R2), execute o comando:

bash
Copiar código
/routing ospf neighbor print
Você deve ver o outro roteador listado como vizinho, indicando que OSPF está funcionando corretamente.

2. Verifique as rotas OSPF:
Nos dois roteadores, verifique se as rotas OSPF foram aprendidas:

bash
Copiar código
/ip route print where protocol=ospf
O R1 deve aprender a rota para a rede 10.0.0.0/24, e o R2 deve aprender a rota para 192.168.0.0/24.

Teste de Conectividade:
Agora que OSPF está configurado e os roteadores estão trocando rotas, os PCs de diferentes redes devem poder se comunicar.

Teste de ping de PC3 para PC2:
bash
Copiar código
ping 192.168.0.3
Teste de ping de PC1 para PC4:
bash
Copiar código
ping 10.0.0.3
Se os pings forem bem-sucedidos, a configuração está correta e os roteadores estão permitindo a comunicação entre as redes dos PCs.





## 5. Conclusão

O OSPF é uma excelente escolha para redes internas grandes devido à sua rápida convergência e capacidade de escalar em redes com múltiplos roteadores. Em contraste, o RIP é mais simples, mas encontra limitações severas em termos de escalabilidade e convergência. Para redes de menor escala, o RIP ainda pode ser utilizado, mas o OSPF oferece maior controle e eficiência. Já para comunicação entre sistemas autônomos (AS) e redes externas, o BGP continua sendo a escolha preferida Para conferir a sintaxe dos comandos, você pode acessar o link [RouterOS - CLI](https://help.mikrotik.com/docs/display/ROS/Command+Line+Interface). 

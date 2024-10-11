# Border Gateway Protocol (BGP) e Sistemas Autônomos (AS)

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

## 4. Conclusão

O BGP desempenha um papel crucial no gerenciamento do tráfego de dados entre redes independentes, garantindo uma internet interconectada e funcional. Através de atributos e políticas flexíveis, ele permite que cada AS decida o melhor caminho para o tráfego, de forma eficiente e escalável. Como resultado, o BGP, apesar de sua convergência mais lenta, é a escolha natural para garantir a escalabilidade e resiliência da infraestrutura global de rede.
<!--
https://www.linkedin.com/pulse/ixbr-atinge-40-tbps-e-convida-%C3%A0-reflex%C3%A3o-sobre-o-futuro-moreiras-nv8hf/?trackingId=5yKB%2FpNbemoXUIh%2BgYU3dQ%3D%3D
-->

# Simulação de Redes com GNS3

## Introdução

O GNS3 (Graphical Network Simulator 3) é uma ferramenta robusta para simular redes em um ambiente virtual. Ele permite configurar e testar dispositivos como roteadores, switches, firewalls e PCs, aplicando de forma prática os conceitos de redes estudados em sala de aula — sem depender de hardware físico. Além disso, utilizando ambientes baseados em containers, podemos simular serviços essenciais de rede, como **Mail eXchanger (MX)**, **DNS (Domain Name System)**, **DHCP (Dynamic Host Configuration Protocol)**, entre outros, permitindo a criação de ambientes de rede completamente funcionais e complexos.

## História e Comunidade

O GNS3 surgiu em 2008 como uma evolução de ferramentas de simulação de redes mais simples, como o **Dynamips**, com o objetivo de oferecer uma interface gráfica amigável para a configuração de redes simuladas. Inicialmente, o foco estava na emulação de roteadores Cisco, utilizando o **IOS (Internetwork Operating System)**, mas a ferramenta expandiu rapidamente para suportar uma ampla variedade de dispositivos e fabricantes. O GNS3 é mantido por uma comunidade ativa de desenvolvedores e entusiastas de redes ao redor do mundo, que contribuem com atualizações regulares, tutoriais, fóruns de discussão e projetos colaborativos, ajudando novos usuários a dominar a plataforma.

## O que você aprenderá

Este repositório fornece as bases para a configuração e uso do **GNS3** em simulações de rede. Utilizaremos o GNS3 para criar redes simuladas, **configurar protocolos de roteamento** e **testar topologias de rede**, compreendendo o funcionamento e as interações entre dispositivos. Além disso, exploraremos a configuração de **serviços essenciais de rede**, como **DNS** e **DHCP**, aprofundando o entendimento sobre como as redes se mantêm e se configuram automaticamente. Com este projeto, você será capaz de:

- **Simular** roteadores, switches e serviços como SMTP, DNS, DHCP.
- **Configurar** protocolos de roteamento: OSPF, RIP, EIGRP, BGP.
- **Montar** topologias em ambiente virtual seguro.
- **Testar e validar** servidores DHCP e DNS.
- **Explorar** a interação entre camadas e dispositivos.
- **Solucionar** problemas de conectividade e desempenho.


## Aplicações do GNS3

O GNS3 pode ser utilizado para uma ampla gama de simulações e experimentos de redes, incluindo:

- **Configuração de dispositivos de rede**: Simular roteadores, switches, firewalls e até mesmo computadores para testar cenários reais de rede.
- **Protocolos de Roteamento**: Testar e configurar diversos protocolos de roteamento (OSPF, RIP, EIGRP, BGP).
- **Segurança de Rede**: Simular cenários de segurança, como firewalls e controle de acesso.
- **Monitoramento e Solução de Problemas**: Monitorar o tráfego de rede e identificar gargalos ou problemas de configuração.
- **Serviços de Rede**: Simular e testar a implementação de **DNS**, **DHCP**, **FTP**, **HTTP** e outros serviços de rede.
- **Automatização e Infraestrutura**: Explorar como redes modernas automatizam a configuração de dispositivos com **DHCP**, e como serviços como **DNS** são essenciais para a comunicação em redes complexas.

## Instruções para Instalação e Configuração do Ambiente para Simulação

### 1. Pré-Requisitos

- Docker instalado (para rodar o ambiente servidor do GNS3 e outras aplicações)
- Familiaridade com **conceitos de redes de computadores**, como **roteamento**, **switching**, **serviços** e **protocolos de rede**.

Com o **WSL** e o **Docker Desktop** instalados, siga os passos abaixo para configurar o ambiente completo.

### 2. Clone o repositório

Abra o terminal do WSL e execute:

```bash
cd /opt
git clone https://github.com/klaytoncastro/ceub-teleco
```

### 3. Suba o simulador GNS3

Acesse a pasta do projeto e suba os containers:

```bash
cd ceub-teleco/gns3
docker compose up -d
```

### 4. Acesse o GNS3 via navegador

Após iniciar os containers, abra o navegador e acesse:

```
http://localhost:3080
```

### 5. Importação do Roteador

Para realizar as simulações em nosso ambiente de laboratório, é necessário importar para o GNS3 o roteador virtual **MikroTik CHR (Cloud Hosted Router)** — dispositivo compatível com múltiplos protocolos e serviços de rede.

5.1. **Baixe o arquivo de imagem `.img` compactado**:

> [Download do `chr-7.16.img.zip`](https://drive.google.com/drive/folders/1d7FwTLtnRSnjJ5k-YRZlORNlY3c1ygQZ?usp=sharing)

<img src="/img/001-Download.png" alt="Baixar Imagem" style="max-width: 500px;">

5.2. **Ignore o alerta de segurança do navegador**. Se for exibido, clique em **"Fazer o download mesmo assim"**.

<img src="/img/002-Ignore_Alert.png" alt="Ignorar Alerta" style="max-width: 400px;">

5.3. **Descompacte o arquivo `.zip`** para obter o `.img`.

<img src="/img/003-Unzip.png" alt="Descompactar Arquivo" style="max-width: 500px;">

5.4. **Acesse a URL do GNS3 no navegador**:  
   > http://localhost:3080  
   Faça login com **usuário** `admin` e **senha** `admin`, se solicitado.

<img src="/img/004-Login.png" alt="Acesso ao GNS3" style="max-width: 500px;">

5.5. **Crie um novo projeto** no GNS3.

<img src="/img/005-Add_Project.png" alt="Novo Projeto" style="max-width: 500px;">

5.6. **Clique em `New Template` no menu lateral**.

<img src="/img/006-New_Template.png" alt="Novo Template" style="max-width: 500px;">

5.7. **Escolha a opção `Install new appliance from the GNS controller`**.

<img src="/img/007-Import_Appliance.png" alt="Instalar do Controller" style="max-width: 500px;">

5.8. **Filtre** os dispositivos compatíveis com a expressão **"CHR"** e selecione o `MikroTik CHR`.

<img src="/img/008-Filter_CHR.png" alt="Filtrar CHR" style="max-width: 500px;">

5.9. **Clique em Import** na versão `chr-7.16.img`. Lembre-se de **selecionar o arquivo `.img` que foi descompactado**. 

<img src="/img/009-Select_CHR.png" alt="Selecionar CHR" style="max-width: 500px;">

Aguarde a importação e clique em `Create` quando solicitado.

<img src="/img/010-Import_Success_Create.png" alt="Importação Bem-sucedida" style="max-width: 500px;">

5.10. **Nomeie o template como `Router` e confirme**.

<img src="/img/011-Router.png" alt="Nomear Template" style="max-width: 500px;">

5.11. **Confirme que o roteador aparece na biblioteca de dispositivos**.

<img src="/img/012-Router_Available.png" alt="Roteador Disponível" style="max-width: 500px;">

5.12. Monte sua topologia e **consulte os mapeamentos de portas** para configurar cada dispositivo via terminal. 

<img src="/img/013-Telnet_Hosts.png" alt="Hosts Telnet" style="max-width: 500px;">

Os dispositivos gerenciáveis no GNS3 listados em **Map Topology** — como os **VPCS** (Virtual PCs) e os **roteadores** MikroTik CHR — podem ser acessados via terminal interno do navegador ou, alternativamente, via protocolo de gerenciamento **Telnet**, por meio do comando abaixo:

```bash
telnet localhost XXXX
```

- Substitua `XXXX` pela porta correspondente ao dispositivo, conforme exibido na aba **Map Topology** do GNS3. 
- Por exemplo: para acessar o PC1, use o comando: `telnet localhost 2013`
- Este método facilita a configuração, permitindo copiar e colar comandos diretamente no terminal de cada equipamento. 

---

## Conclusão

Com o ambiente pronto e o MikroTik CHR disponível, você já pode iniciar as simulações e implementação dos desafios práticos, explorando protocolos como RIP, OSPF, BGP e demais tópicos abordados no curso. Em caso de dúvidas, entre em contato com o [Professor](mailto:klayton.castro@ceub.edu.br).
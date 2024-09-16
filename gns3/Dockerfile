FROM pmietlicki/gns3-server:latest

# Instalar as dependências necessárias
RUN apk add --no-cache \
    iptables \
    dnsmasq \
    bridge-utils \
    gns3-server \
    docker

# Expor as portas necessárias para o GNS3 Server
EXPOSE 3080
EXPOSE 80
EXPOSE 8000
EXPOSE 5000-5010

# Comando para iniciar o GNS3 Server
CMD ["gns3server", "--host", "0.0.0.0", "--port", "3080"]

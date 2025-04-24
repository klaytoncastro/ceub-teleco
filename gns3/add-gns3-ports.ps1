# ==============================================================================================
# Script PowerShell para criação de regras NAT no VirtualBox
# Uso exlusivo para ambientes Windows com VM e NAT (sem WSL)
# Compatível com cenários como GNS3 Server ou aplicações Docker expostas em portas específicas
# ==============================================================================================

# Defina o nome exato da sua máquina virtual no VirtualBox
$vmName = "NOME_DA_VM"

# Criação de redirecionamentos de portas individuais (porta do host → porta da VM)
# Essas portas devem estar explicitamente definidas no docker-compose.yml
VBoxManage modifyvm $vmName --natpf1 "gns3-3080,tcp,,3080,,$(3080)"
VBoxManage modifyvm $vmName --natpf1 "gns3-80,tcp,,80,,$(80)"
VBoxManage modifyvm $vmName --natpf1 "gns3-8000,tcp,,8000,,$(8000)"

# Criação de redirecionamentos para o intervalo de portas 5000-5010
# Comum para múltiplos serviços ou aplicações paralelas (como múltiplas instâncias Flask)
for ($port = 5000; $port -le 5010; $port++) {
    VBoxManage modifyvm $vmName --natpf1 "gns3-$port,tcp,,$port,,$port"
}

# Criação de redirecionamentos para o intervalo de portas 2000-2050
# Utilizado por GNS3 para comunicação entre nós, dinamips, uBridge, etc.
for ($port = 2000; $port -le 2050; $port++) {
    VBoxManage modifyvm $vmName --natpf1 "gns3-$port,tcp,,$port,,$port"
}

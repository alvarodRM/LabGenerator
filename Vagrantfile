# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.ssh.insert_key = false

  # Obtenemos el valor del DNI y de la dificultad de las variables de entorno.
  dni = ENV['DNI']
  dificultad = ENV['SELECCION']

  # Obtenemos el valor de las banderas de las variables de entorno.
  bandera1 = ENV['BANDERA1']
  bandera2 = ENV['BANDERA2']
  bandera3 = ENV['BANDERA3']
  bandera4 = ENV['BANDERA4']
  bandera5 = ENV['BANDERA5']
  bandera6 = ENV['BANDERA6']
  bandera7 = ENV['BANDERA7']
  bandera8 = ENV['BANDERA8']
  bandera9 = ENV['BANDERA9']

  # Obtenemos el valor de las IPs de las variables de entorno.
  ip_vm1 = ENV['IP_VM1']
  ip_vm2 = ENV['IP_VM2']
  ip_vm3 = ENV['IP_VM3']
  ip_vm4 = ENV['IP_VM4']
  ip_vm5_1 = ENV['IP_VM5_1']
  ip_vm5_2 = ENV['IP_VM5_2']
  ip_vm6 = ENV['IP_VM6']
  ip_vm7 = ENV['IP_VM7']
  ip_vm8 = ENV['IP_VM8']
  ip_vm9_1 = ENV['IP_VM9_1']
  ip_vm9_2 = ENV['IP_VM9_2']
  ip_vm10 = ENV['IP_VM10']

  # Obtenemos el nombre de los usuarios de las variables de entorno.
  vm1_username = ENV['VM1_USERNAME']
  vm3_username1 = ENV['VM3_USERNAME1']
  vm4_username1 = ENV['VM4_USERNAME1']
  vm4_username2 = ENV['VM4_USERNAME2']
  vm5_username1 = ENV['VM5_USERNAME1']
  vm5_username2 = ENV['VM5_USERNAME2']
  vm6_ftp_pass = ENV['VM6_FTP_PASS']

  # Obtenemos las contraseñas de los usuarios de las variables de entorno.
  vm1_password = ENV['VM1_PASSWORD']
  vm3_password1 = ENV['VM3_PASSWORD1']
  vm4_password1 = ENV['VM4_PASSWORD1']
  vm5_password1 = ENV['VM5_PASSWORD1']
  vm5_password2 = ENV['VM5_PASSWORD2']
  vm6_ftp_user = ENV['VM6_FTP_USER']

  # Generamos un string con la dificultad asociada.
  if dificultad == '1' then
    dif = "difFacil"
  elsif dificultad == '2' then
    dif = "difMedia"
  elsif dificultad == '3' then
    dif = "difAvanzada"
  end

############################################################################################################################################################################################################################################

  # Machine1 -kalilinux- setup
  config.vm.define "vm1_#{dni}_#{dif}" do |vm1|
    # Vagrant box and version from vm1
    vm1.vm.box = "kalilinux/rolling"
    vm1.vm.box_version = "2024.1.0"
    # Hostname configuration
    vm1.vm.hostname = "vm1-KaliLinux-Atacante-#{dni}-#{dif}"
    # Virtualbox vm1 machine configuration
    vm1.vm.provider "virtualbox" do |vb_vm1|
      vb_vm1.gui = true
      vb_vm1.memory = 1024
      vb_vm1.cpus = 1
      vb_vm1.customize ["modifyvm", :id,"--name", "vm1-KaliLinux-Atacante_#{dni}_#{dif}"]
    end
    vm1.ssh.insert_key = false
    # Network configuration
    vm1.vm.network "private_network", ip: ip_vm1, :netmask => "255.255.255.248", virtualbox__intnet: "RED_PRUEBAS"
    # Port configuration
    vm1.vm.network "forwarded_port", guest: 22, host: 2220 #SSH
    # Provisioning configuration
    vm1.vm.provision :shell, :inline => "ulimit -n 4048"
    vm1.vm.provision "shell", inline: "echo 'export DNI=#{dni}' >> /etc/profile.d/dni.sh", privileged: true
    vm1.vm.provision "shell", inline: "echo 'export SELECCION=#{dificultad}' >> /etc/profile.d/dificultad.sh", privileged: true
    vm1.vm.provision "shell", inline: "echo 'export IP_VM1=#{ip_vm1}' >> /etc/profile.d/ip_vm1.sh", privileged: true
    vm1.vm.provision "shell", inline: "echo 'export IP_VM2=#{ip_vm2}' >> /etc/profile.d/ip_vm2.sh", privileged: true
    vm1.vm.provision "shell", inline: "echo 'export IP_VM3=#{ip_vm3}' >> /etc/profile.d/ip_vm3.sh", privileged: true
    vm1.vm.provision "shell", inline: "echo 'export IP_VM4=#{ip_vm4}' >> /etc/profile.d/ip_vm4.sh", privileged: true
    vm1.vm.provision "shell", inline: "echo 'export IP_VM5_1=#{ip_vm5_1}' >> /etc/profile.d/ip_vm5_1.sh", privileged: true
    vm1.vm.provision "shell", inline: "echo 'export IP_VM5_2=#{ip_vm5_2}' >> /etc/profile.d/ip_vm5_2.sh", privileged: true
    vm1.vm.provision "shell", inline: "echo 'export IP_VM6=#{ip_vm6}' >> /etc/profile.d/ip_vm6.sh", privileged: true
    vm1.vm.provision "shell", inline: "echo 'export IP_VM7=#{ip_vm7}' >> /etc/profile.d/ip_vm7.sh", privileged: true
    vm1.vm.provision "shell", inline: "echo 'export IP_VM8=#{ip_vm8}' >> /etc/profile.d/ip_vm8.sh", privileged: true
    vm1.vm.provision "shell", inline: "echo 'export IP_VM9_1=#{ip_vm9_1}' >> /etc/profile.d/ip_vm9_1.sh", privileged: true
    vm1.vm.provision "shell", inline: "echo 'export IP_VM9_2=#{ip_vm9_2}' >> /etc/profile.d/ip_vm9_2.sh", privileged: true
    vm1.vm.provision "shell", inline: "echo 'export IP_VM10=#{ip_vm10}' >> /etc/profile.d/ip_vm10.sh", privileged: true
    vm1.vm.provision "shell", path: "Aprovisionamiento/vm1/vm1.bootstrap.sh", env: {"DNI" => dni, "SELECCION" => dificultad, "IP_VM1" => ip_vm1, "IP_VM2" => ip_vm2, "IP_VM3" => ip_vm3, "IP_VM4" => ip_vm4, "IP_VM5_1" => ip_vm5_1, "IP_VM5_2" => ip_vm5_2, "IP_VM6" => ip_vm6, "IP_VM7" => ip_vm7, "IP_VM8" => ip_vm8, "IP_VM9_1" => ip_vm9_1, "IP_VM9_2" => ip_vm9_2, "IP_VM10" => ip_vm10, "VM1_USERNAME" => vm1_username, "VM1_PASSWORD" => vm1_password}
  end

############################################################################################################################################################################################################################################

  # Machine2 -ubuntu/precise64- setup
  config.vm.define "vm2_#{dni}_#{dif}" do |vm2|
    # Vagrant box from vm2
    vm2.vm.box = "kyledampier/DVWA"
    # Hostname configuration
    vm2.vm.hostname = "vm2-WebServer-#{dni}-#{dif}"
    # Virtualbox vm2 machine configuration 
    vm2.vm.provider "virtualbox" do |vb_vm2|
      vb_vm2.gui = false
      vb_vm2.memory = 512
      vb_vm2.cpus = 1
      vb_vm2.customize ["modifyvm", :id,"--name", "vm2-WebServer_#{dni}_#{dif}"]
      vb_vm2.check_guest_additions = false
    end
    vm2.ssh.insert_key = false
    # Network configuration
    vm2.vm.network "private_network", ip: ip_vm2, :netmask => "255.255.255.248", virtualbox__intnet: "RED_PRUEBAS"
    # Port configuration
    vm2.ssh.port = 2221
    vm2.vm.network "forwarded_port", guest: 22, host: 2221 #SSH
    vm2.vm.network "forwarded_port", guest: 80, host: 8080 #HTTP
    # Provisioning configuration
    vm2.vm.provision :shell, :inline => "ulimit -n 4048"
    vm2.vm.provision "shell", inline: "echo 'export DNI=#{dni}' >> /etc/profile.d/dni.sh", privileged: true
    vm2.vm.provision "shell", inline: "echo 'export SELECCION=#{dificultad}' >> /etc/profile.d/dificultad.sh", privileged: true
    vm2.vm.provision "shell", inline: "echo 'export IP_VM1=#{ip_vm1}' >> /etc/profile.d/ip_vm1.sh", privileged: true
    vm2.vm.provision "shell", inline: "echo 'export IP_VM2=#{ip_vm2}' >> /etc/profile.d/ip_vm2.sh", privileged: true
    vm2.vm.provision "shell", inline: "echo 'export IP_VM3=#{ip_vm3}' >> /etc/profile.d/ip_vm3.sh", privileged: true
    vm2.vm.provision "shell", inline: "echo 'export IP_VM4=#{ip_vm4}' >> /etc/profile.d/ip_vm4.sh", privileged: true
    vm2.vm.provision "shell", inline: "echo 'export IP_VM5_1=#{ip_vm5_1}' >> /etc/profile.d/ip_vm5_1.sh", privileged: true
    vm2.vm.provision "shell", inline: "echo 'export IP_VM5_2=#{ip_vm5_2}' >> /etc/profile.d/ip_vm5_2.sh", privileged: true
    vm2.vm.provision "shell", inline: "echo 'export IP_VM6=#{ip_vm6}' >> /etc/profile.d/ip_vm6.sh", privileged: true
    vm2.vm.provision "shell", inline: "echo 'export IP_VM7=#{ip_vm7}' >> /etc/profile.d/ip_vm7.sh", privileged: true
    vm2.vm.provision "shell", inline: "echo 'export IP_VM8=#{ip_vm8}' >> /etc/profile.d/ip_vm8.sh", privileged: true
    vm2.vm.provision "shell", inline: "echo 'export IP_VM9_1=#{ip_vm9_1}' >> /etc/profile.d/ip_vm9_1.sh", privileged: true
    vm2.vm.provision "shell", inline: "echo 'export IP_VM9_2=#{ip_vm9_2}' >> /etc/profile.d/ip_vm9_2.sh", privileged: true
    vm2.vm.provision "shell", inline: "echo 'export IP_VM10=#{ip_vm10}' >> /etc/profile.d/ip_vm10.sh", privileged: true
    vm2.vm.provision "shell", path: "Aprovisionamiento/vm2/vm2.bootstrap.sh", env: {"BANDERA1" => bandera1, "VM3_PASSWORD1" => vm3_password1, "DNI" => dni, "SELECCION" => dificultad, "IP_VM1" => ip_vm1, "IP_VM2" => ip_vm2, "IP_VM3" => ip_vm3, "IP_VM4" => ip_vm4, "IP_VM5_1" => ip_vm5_1, "IP_VM5_2" => ip_vm5_2, "IP_VM6" => ip_vm6, "IP_VM7" => ip_vm7, "IP_VM8" => ip_vm8, "IP_VM9_1" => ip_vm9_1, "IP_VM9_2" => ip_vm9_2, "IP_VM10" => ip_vm10}
  end

############################################################################################################################################################################################################################################

  # Machine3 -ubuntu/xenial64- setup
  config.vm.define "vm3_#{dni}_#{dif}" do |vm3|
    # Vagrant box from vm3
    vm3.vm.box = "ubuntu/xenial64"
    # Hostname configuration
    vm3.vm.hostname = "vm3-WebServer-#{dni}-#{dif}"
    # Virtualbox vm3 machine configuration
    vm3.vm.provider "virtualbox" do |vb_vm3|
      vb_vm3.gui = false
      vb_vm3.memory = 512
      vb_vm3.cpus = 1
      vb_vm3.customize ["modifyvm", :id,"--name", "vm3-WebServer_#{dni}_#{dif}"]
    end
    vm3.ssh.insert_key = false
    # Network configuration
    vm3.vm.network "private_network", ip: ip_vm3, :netmask => "255.255.255.248", virtualbox__intnet: "RED_PRUEBAS"
    # Port configuration
    vm3.ssh.port = 2248
    vm3.vm.network "forwarded_port", guest: 22, host: 2248 #SSH
    vm3.vm.network "forwarded_port", guest: 80, host: 8081 #HTTP
    #Shared Folders
    vm3.vm.synced_folder '.', '/vagrant', disabled: false
    # Provisioning configuration
    vm3.vm.provision "file", source: "Ansible", destination: "."
    vm3.vm.provision :shell, :inline => "ulimit -n 4048"
    vm3.vm.provision "shell", inline: "echo 'export DNI=#{dni}' >> /etc/profile.d/dni.sh", privileged: true
    vm3.vm.provision "shell", inline: "echo 'export SELECCION=#{dificultad}' >> /etc/profile.d/dificultad.sh", privileged: true
    vm3.vm.provision "shell", inline: "echo 'export IP_VM1=#{ip_vm1}' >> /etc/profile.d/ip_vm1.sh", privileged: true
    vm3.vm.provision "shell", inline: "echo 'export IP_VM2=#{ip_vm2}' >> /etc/profile.d/ip_vm2.sh", privileged: true
    vm3.vm.provision "shell", inline: "echo 'export IP_VM3=#{ip_vm3}' >> /etc/profile.d/ip_vm3.sh", privileged: true
    vm3.vm.provision "shell", inline: "echo 'export IP_VM4=#{ip_vm4}' >> /etc/profile.d/ip_vm4.sh", privileged: true
    vm3.vm.provision "shell", inline: "echo 'export IP_VM5_1=#{ip_vm5_1}' >> /etc/profile.d/ip_vm5_1.sh", privileged: true
    vm3.vm.provision "shell", inline: "echo 'export IP_VM5_2=#{ip_vm5_2}' >> /etc/profile.d/ip_vm5_2.sh", privileged: true
    vm3.vm.provision "shell", inline: "echo 'export IP_VM6=#{ip_vm6}' >> /etc/profile.d/ip_vm6.sh", privileged: true
    vm3.vm.provision "shell", inline: "echo 'export IP_VM7=#{ip_vm7}' >> /etc/profile.d/ip_vm7.sh", privileged: true
    vm3.vm.provision "shell", inline: "echo 'export IP_VM8=#{ip_vm8}' >> /etc/profile.d/ip_vm8.sh", privileged: true
    vm3.vm.provision "shell", inline: "echo 'export IP_VM9_1=#{ip_vm9_1}' >> /etc/profile.d/ip_vm9_1.sh", privileged: true
    vm3.vm.provision "shell", inline: "echo 'export IP_VM9_2=#{ip_vm9_2}' >> /etc/profile.d/ip_vm9_2.sh", privileged: true
    vm3.vm.provision "shell", inline: "echo 'export IP_VM10=#{ip_vm10}' >> /etc/profile.d/ip_vm10.sh", privileged: true
    vm3.vm.provision "file", source: "Aprovisionamiento/vm3/default.conf", destination: "/tmp/juice-shop/default.conf"
    vm3.vm.provision "shell", path: "Aprovisionamiento/vm3/vm3.bootstrap.sh", env: {"BANDERA2" => bandera2, "VM3_USERNAME1" => vm3_username1, "VM3_PASSWORD1" => vm3_password1, "DNI" => dni, "SELECCION" => dificultad, "IP_VM1" => ip_vm1, "IP_VM2" => ip_vm2, "IP_VM3" => ip_vm3, "IP_VM4" => ip_vm4, "IP_VM5_1" => ip_vm5_1, "IP_VM5_2" => ip_vm5_2, "IP_VM6" => ip_vm6, "IP_VM7" => ip_vm7, "IP_VM8" => ip_vm8, "IP_VM9_1" => ip_vm9_1, "IP_VM9_2" => ip_vm9_2, "IP_VM10" => ip_vm10}
    vm3.vm.provision "ansible_local" do |ansible|
      ansible.limit = "vm3"
      ansible.inventory_path = "/home/vagrant/hosts.yml"
      ansible.playbook = "/home/vagrant/playbook.yml"
      ansible.install = true
      ansible.extra_vars = {
        "DNI" => dni,
        "SELECCION" => dificultad,
        "IP_VM1" => ip_vm1,
        "IP_VM2" => ip_vm2,
        "IP_VM3" => ip_vm3,
        "IP_VM4" => ip_vm4,
        "IP_VM5_1" => ip_vm5_1,
        "IP_VM5_2" => ip_vm5_2,
        "IP_VM6" => ip_vm6,
        "IP_VM7" => ip_vm7,
        "IP_VM8" => ip_vm8,
        "IP_VM9_1" => ip_vm9_1,
        "IP_VM9_2" => ip_vm9_2,
        "IP_VM10" => ip_vm10,
        "VM3_USERNAME1" => vm3_username1,
        "VM3_PASSWORD1" => vm3_password1
      }
    end
    vm3.vm.provision "shell", path: "Aprovisionamiento/vm3/vm3.bootstrap2.sh", env: {"BANDERA2" => bandera2, "VM3_PASSWORD1" => vm3_password1, "DNI" => dni, "SELECCION" => dificultad, "IP_VM1" => ip_vm1, "IP_VM2" => ip_vm2, "IP_VM3" => ip_vm3, "IP_VM4" => ip_vm4, "IP_VM5_1" => ip_vm5_1, "IP_VM5_2" => ip_vm5_2, "IP_VM6" => ip_vm6, "IP_VM7" => ip_vm7, "IP_VM8" => ip_vm8, "IP_VM9_1" => ip_vm9_1, "IP_VM9_2" => ip_vm9_2, "IP_VM10" => ip_vm10}
  end

############################################################################################################################################################################################################################################

  # Machine4 -Ubuntu/Metasploitable2- Client1 setup
  config.vm.define "vm4_#{dni}_#{dif}" do |vm4|
    # Vagrant box from vm4
    vm4.vm.box = "ifly53e/metasploitable2updateable"
    vm4.vm.box_version = "0.0.4"
    # Hostname configuration
    vm4.vm.hostname = "vm4-Client1-#{dni}-#{dif}"
    # Virtualbox vm4 machine configuration
    vm4.vm.provider "virtualbox" do |vb_vm4|
      vb_vm4.gui = false
      vb_vm4.memory = 512
      vb_vm4.cpus = 1
      vb_vm4.customize ["modifyvm", :id,"--name", "vm4-Client1_#{dni}_#{dif}"]
      vb_vm4.check_guest_additions = false
    end
    vm4.ssh.insert_key = false
    # Network configuration
    vm4.vm.network "private_network", ip: ip_vm4, :netmask => "255.255.255.248", virtualbox__intnet: "RED_PRUEBAS"
    # Port configuration
    vm4.vm.network "forwarded_port", guest: 22, host: 2224 #SSH
    # Provisioning configuration
    vm4.vm.provision :shell, :inline => "ulimit -n 4048"
    vm4.vm.provision "shell", inline: "echo 'export DNI=#{dni}' >> /etc/profile.d/dni.sh", privileged: true
    vm4.vm.provision "shell", inline: "echo 'export SELECCION=#{dificultad}' >> /etc/profile.d/dificultad.sh", privileged: true
    vm4.vm.provision "shell", inline: "echo 'export IP_VM1=#{ip_vm1}' >> /etc/profile.d/ip_vm1.sh", privileged: true
    vm4.vm.provision "shell", inline: "echo 'export IP_VM2=#{ip_vm2}' >> /etc/profile.d/ip_vm2.sh", privileged: true
    vm4.vm.provision "shell", inline: "echo 'export IP_VM3=#{ip_vm3}' >> /etc/profile.d/ip_vm3.sh", privileged: true
    vm4.vm.provision "shell", inline: "echo 'export IP_VM4=#{ip_vm4}' >> /etc/profile.d/ip_vm4.sh", privileged: true
    vm4.vm.provision "shell", inline: "echo 'export IP_VM5_1=#{ip_vm5_1}' >> /etc/profile.d/ip_vm5_1.sh", privileged: true
    vm4.vm.provision "shell", inline: "echo 'export IP_VM5_2=#{ip_vm5_2}' >> /etc/profile.d/ip_vm5_2.sh", privileged: true
    vm4.vm.provision "shell", inline: "echo 'export IP_VM6=#{ip_vm6}' >> /etc/profile.d/ip_vm6.sh", privileged: true
    vm4.vm.provision "shell", inline: "echo 'export IP_VM7=#{ip_vm7}' >> /etc/profile.d/ip_vm7.sh", privileged: true
    vm4.vm.provision "shell", inline: "echo 'export IP_VM8=#{ip_vm8}' >> /etc/profile.d/ip_vm8.sh", privileged: true
    vm4.vm.provision "shell", inline: "echo 'export IP_VM9_1=#{ip_vm9_1}' >> /etc/profile.d/ip_vm9_1.sh", privileged: true
    vm4.vm.provision "shell", inline: "echo 'export IP_VM9_2=#{ip_vm9_2}' >> /etc/profile.d/ip_vm9_2.sh", privileged: true
    vm4.vm.provision "shell", inline: "echo 'export IP_VM10=#{ip_vm10}' >> /etc/profile.d/ip_vm10.sh", privileged: true
    vm4.vm.provision "shell", path: "Aprovisionamiento/vm4/vm4.bootstrap.sh", env: {"BANDERA3" => bandera3, "VM4_USERNAME1" => vm4_username1, "VM4_PASSWORD1" => vm4_password1, "VM4_USERNAME2" => vm4_username2, "VM5_USERNAME2" => vm5_username2, "DNI" => dni, "SELECCION" => dificultad, "IP_VM1" => ip_vm1, "IP_VM2" => ip_vm2, "IP_VM3" => ip_vm3, "IP_VM4" => ip_vm4, "IP_VM5_1" => ip_vm5_1, "IP_VM5_2" => ip_vm5_2, "IP_VM6" => ip_vm6, "IP_VM7" => ip_vm7, "IP_VM8" => ip_vm8, "IP_VM9_1" => ip_vm9_1, "IP_VM9_2" => ip_vm9_2, "IP_VM10" => ip_vm10}
  end

############################################################################################################################################################################################################################################

  # Machine5 -KaliLinux- Client2 setup
  config.vm.define "vm5_#{dni}_#{dif}" do |vm5|
    # Vagrant box from vm5
    vm5.vm.box = "kalilinux/rolling"
    # Hostname configuration
    vm5.vm.hostname = "vm5-Client2-#{dni}-#{dif}"
    # Virtualbox vm5 machine configuration
    vm5.vm.provider "virtualbox" do |vb_vm5|
      vb_vm5.gui = false
      vb_vm5.memory = 1024
      vb_vm5.cpus = 1
      vb_vm5.customize ["modifyvm", :id,"--name", "vm5-Client2_#{dni}_#{dif}"]
    end
    vm5.ssh.insert_key = false
    # Network configuration
    vm5.vm.network "private_network", ip: ip_vm5_1, :netmask => "255.255.255.248", virtualbox__intnet: "RED_PRUEBAS"
    vm5.vm.network "private_network", ip: ip_vm5_2, :netmask => "255.255.255.248", virtualbox__intnet: "RED_PRE_PRODUCCION"
    # Port configuration
    vm5.vm.network "forwarded_port", guest: 22, host: 2235 #SSH
    # Provisioning configuration
    vm5.vm.provision :shell, :inline => "ulimit -n 4048"
    vm5.vm.provision "shell", inline: "echo 'export DNI=#{dni}' >> /etc/profile.d/dni.sh", privileged: true
    vm5.vm.provision "shell", inline: "echo 'export SELECCION=#{dificultad}' >> /etc/profile.d/dificultad.sh", privileged: true
    vm5.vm.provision "shell", inline: "echo 'export IP_VM1=#{ip_vm1}' >> /etc/profile.d/ip_vm1.sh", privileged: true
    vm5.vm.provision "shell", inline: "echo 'export IP_VM2=#{ip_vm2}' >> /etc/profile.d/ip_vm2.sh", privileged: true
    vm5.vm.provision "shell", inline: "echo 'export IP_VM3=#{ip_vm3}' >> /etc/profile.d/ip_vm3.sh", privileged: true
    vm5.vm.provision "shell", inline: "echo 'export IP_VM4=#{ip_vm4}' >> /etc/profile.d/ip_vm4.sh", privileged: true
    vm5.vm.provision "shell", inline: "echo 'export IP_VM5_1=#{ip_vm5_1}' >> /etc/profile.d/ip_vm5_1.sh", privileged: true
    vm5.vm.provision "shell", inline: "echo 'export IP_VM5_2=#{ip_vm5_2}' >> /etc/profile.d/ip_vm5_2.sh", privileged: true
    vm5.vm.provision "shell", inline: "echo 'export IP_VM6=#{ip_vm6}' >> /etc/profile.d/ip_vm6.sh", privileged: true
    vm5.vm.provision "shell", inline: "echo 'export IP_VM7=#{ip_vm7}' >> /etc/profile.d/ip_vm7.sh", privileged: true
    vm5.vm.provision "shell", inline: "echo 'export IP_VM8=#{ip_vm8}' >> /etc/profile.d/ip_vm8.sh", privileged: true
    vm5.vm.provision "shell", inline: "echo 'export IP_VM9_1=#{ip_vm9_1}' >> /etc/profile.d/ip_vm9_1.sh", privileged: true
    vm5.vm.provision "shell", inline: "echo 'export IP_VM9_2=#{ip_vm9_2}' >> /etc/profile.d/ip_vm9_2.sh", privileged: true
    vm5.vm.provision "shell", inline: "echo 'export IP_VM10=#{ip_vm10}' >> /etc/profile.d/ip_vm10.sh", privileged: true
    vm5.vm.provision "shell", path: "Aprovisionamiento/vm5/vm5.bootstrap.sh", env: {"BANDERA4" => bandera4, "VM5_USERNAME1" => vm5_username1, "VM5_PASSWORD1" => vm5_password1, "VM5_USERNAME2" => vm5_username2, "VM5_PASSWORD2" => vm5_password2, "VM6_FTP_USER" => vm6_ftp_user, "DNI" => dni, "SELECCION" => dificultad, "IP_VM1" => ip_vm1, "IP_VM2" => ip_vm2, "IP_VM3" => ip_vm3, "IP_VM4" => ip_vm4, "IP_VM5_1" => ip_vm5_1, "IP_VM5_2" => ip_vm5_2, "IP_VM6" => ip_vm6, "IP_VM7" => ip_vm7, "IP_VM8" => ip_vm8, "IP_VM9_1" => ip_vm9_1, "IP_VM9_2" => ip_vm9_2, "IP_VM10" => ip_vm10}
    vm5.vm.provision "shell", path: "Aprovisionamiento/vm5/vm5.bootstrap2.sh", env: {"BANDERA4" => bandera4, "VM5_USERNAME1" => vm5_username1, "VM5_PASSWORD1" => vm5_password1, "VM5_USERNAME2" => vm5_username2, "VM5_PASSWORD2" => vm5_password2, "VM6_FTP_USER" => vm6_ftp_user, "DNI" => dni, "SELECCION" => dificultad, "IP_VM1" => ip_vm1, "IP_VM2" => ip_vm2, "IP_VM3" => ip_vm3, "IP_VM4" => ip_vm4, "IP_VM5_1" => ip_vm5_1, "IP_VM5_2" => ip_vm5_2, "IP_VM6" => ip_vm6, "IP_VM7" => ip_vm7, "IP_VM8" => ip_vm8, "IP_VM9_1" => ip_vm9_1, "IP_VM9_2" => ip_vm9_2, "IP_VM10" => ip_vm10}
  end

############################################################################################################################################################################################################################################

  # Machine6 -ubuntu/trusty64- FTPServer setup
  config.vm.define "vm6_#{dni}_#{dif}" do |vm6|
    # Vagrant box from vm6
    vm6.vm.box = "ubuntu/trusty64"
    # Hostname configuration
    vm6.vm.hostname = "vm6-FTPServer-#{dni}-#{dif}"
    # Virtualbox vm6 machine configuration
    vm6.vm.provider "virtualbox" do |vb_vm6|
      vb_vm6.gui = false
      vb_vm6.memory = 512
      vb_vm6.cpus = 1
      vb_vm6.customize ["modifyvm", :id,"--name", "vm6-FTPServer_#{dni}_#{dif}"]
      vb_vm6.check_guest_additions = false
    end
    vm6.ssh.insert_key = false
    # Network configuration
    vm6.vm.network "private_network", ip: ip_vm6, :netmask => "255.255.255.248", virtualbox__intnet: "RED_PRE_PRODUCCION", gw: "192.168.56.97"
    # Port configuration
    vm6.ssh.port = 2225
    vm6.vm.network "forwarded_port", guest: 21, host: 5678 #FTP
    vm6.vm.network "forwarded_port", guest: 22, host: 2225 #SSH
    vm6.vm.network "forwarded_port", guest: 80, host: 8083 #HTTP
    # Provisioning configuration
    vm6.vm.provision "file", source: "Ansible", destination: "/vagrant"
    vm6.vm.provision :shell, :inline => "ulimit -n 4048"
    vm6.vm.provision "shell", inline: "echo 'export DNI=#{dni}' >> /etc/profile.d/dni.sh", privileged: true
    vm6.vm.provision "shell", inline: "echo 'export SELECCION=#{dificultad}' >> /etc/profile.d/dificultad.sh", privileged: true
    vm6.vm.provision "shell", inline: "echo 'export IP_VM1=#{ip_vm1}' >> /etc/profile.d/ip_vm1.sh", privileged: true
    vm6.vm.provision "shell", inline: "echo 'export IP_VM2=#{ip_vm2}' >> /etc/profile.d/ip_vm2.sh", privileged: true
    vm6.vm.provision "shell", inline: "echo 'export IP_VM3=#{ip_vm3}' >> /etc/profile.d/ip_vm3.sh", privileged: true
    vm6.vm.provision "shell", inline: "echo 'export IP_VM4=#{ip_vm4}' >> /etc/profile.d/ip_vm4.sh", privileged: true
    vm6.vm.provision "shell", inline: "echo 'export IP_VM5_1=#{ip_vm5_1}' >> /etc/profile.d/ip_vm5_1.sh", privileged: true
    vm6.vm.provision "shell", inline: "echo 'export IP_VM5_2=#{ip_vm5_2}' >> /etc/profile.d/ip_vm5_2.sh", privileged: true
    vm6.vm.provision "shell", inline: "echo 'export IP_VM6=#{ip_vm6}' >> /etc/profile.d/ip_vm6.sh", privileged: true
    vm6.vm.provision "shell", inline: "echo 'export IP_VM7=#{ip_vm7}' >> /etc/profile.d/ip_vm7.sh", privileged: true
    vm6.vm.provision "shell", inline: "echo 'export IP_VM8=#{ip_vm8}' >> /etc/profile.d/ip_vm8.sh", privileged: true
    vm6.vm.provision "shell", inline: "echo 'export IP_VM9_1=#{ip_vm9_1}' >> /etc/profile.d/ip_vm9_1.sh", privileged: true
    vm6.vm.provision "shell", inline: "echo 'export IP_VM9_2=#{ip_vm9_2}' >> /etc/profile.d/ip_vm9_2.sh", privileged: true
    vm6.vm.provision "shell", inline: "echo 'export IP_VM10=#{ip_vm10}' >> /etc/profile.d/ip_vm10.sh", privileged: true
    vm6.vm.provision "shell", path: "Aprovisionamiento/vm6/vm6.bootstrap.sh", env: {"BANDERA5" => bandera5, "VM6_FTP_USER" => vm6_ftp_user, "VM6_FTP_PASS" => vm6_ftp_pass, "DNI" => dni, "SELECCION" => dificultad, "IP_VM1" => ip_vm1, "IP_VM2" => ip_vm2, "IP_VM3" => ip_vm3, "IP_VM4" => ip_vm4, "IP_VM5_1" => ip_vm5_1, "IP_VM5_2" => ip_vm5_2, "IP_VM6" => ip_vm6, "IP_VM7" => ip_vm7, "IP_VM8" => ip_vm8, "IP_VM9_1" => ip_vm9_1, "IP_VM9_2" => ip_vm9_2, "IP_VM10" => ip_vm10}
    vm6.vm.provision "ansible_local" do |ansible|
      ansible.limit = "vm6"
      ansible.inventory_path = "Ansible/hosts.yml"
      ansible.playbook = "Ansible/playbook.yml"
      ansible.extra_vars = {
        "DNI" => dni,
        "SELECCION" => dificultad,
        "IP_VM1" => ip_vm1,
        "IP_VM2" => ip_vm2,
        "IP_VM3" => ip_vm3,
        "IP_VM4" => ip_vm4,
        "IP_VM5_1" => ip_vm5_1,
        "IP_VM5_2" => ip_vm5_2,
        "IP_VM6" => ip_vm6,
        "IP_VM7" => ip_vm7,
        "IP_VM8" => ip_vm8,
        "IP_VM9_1" => ip_vm9_1,
        "IP_VM9_2" => ip_vm9_2,
        "IP_VM10" => ip_vm10,
        "VM6_FTP_USER" => vm6_ftp_user,
        "VM6_FTP_PASS" => vm6_ftp_pass
      }
    end
    vm6.vm.provision "shell", path: "Aprovisionamiento/vm6/vm6.bootstrap2.sh", env: {"BANDERA5" => bandera5, "VM6_FTP_USER" => vm6_ftp_user, "VM6_FTP_PASS" => vm6_ftp_pass, "DNI" => dni, "SELECCION" => dificultad, "IP_VM1" => ip_vm1, "IP_VM2" => ip_vm2, "IP_VM3" => ip_vm3, "IP_VM4" => ip_vm4, "IP_VM5_1" => ip_vm5_1, "IP_VM5_2" => ip_vm5_2, "IP_VM6" => ip_vm6, "IP_VM7" => ip_vm7, "IP_VM8" => ip_vm8, "IP_VM9_1" => ip_vm9_1, "IP_VM9_2" => ip_vm9_2, "IP_VM10" => ip_vm10}
  end

############################################################################################################################################################################################################################################

  # Machine7 -rapid7/metasploitable3-win2k8- setup
  config.vm.define "vm7_#{dni}_#{dif}" do |vm7|
    # Vagrant box from vm7
    vm7.vm.box = "rapid7/metasploitable3-win2k8"
    # Hostname configuration
    vm7.vm.hostname = "vm7-Client3-#{dni}-#{dif}"
    # Virtualbox vm7 machine configuration
    vm7.vm.provider "virtualbox" do |vb_vm7|
      vb_vm7.gui = false
      vb_vm7.memory = 1024
      vb_vm7.cpus = 1
      vb_vm7.customize ["modifyvm", :id,"--name", "vm7-Client3_#{dni}_#{dif}"]
    end
    vm7.ssh.insert_key = false
    # Network configuration
    vm7.vm.network "private_network", ip: ip_vm7, :netmask => "255.255.255.248", virtualbox__intnet: "RED_PRE_PRODUCCION"
    # Port configuration
    vm7.ssh.port = 2228
    vm7.vm.network "forwarded_port", guest: 22, host: 2228 #SSH
    #Shared Folders
    vm7.vm.synced_folder '.', '/vagrant', disabled: false
    # Provisioning configuration
    vm7.vm.provision :shell, :inline => "ulimit -n 4048"
    vm7.vm.provision "shell", path: "Aprovisionamiento/vm7/vm7.bootstrap.ps1", env: {"BANDERA6" => bandera6, "DNI" => dni, "SELECCION" => dificultad, "IP_VM1" => ip_vm1, "IP_VM2" => ip_vm2, "IP_VM3" => ip_vm3, "IP_VM4" => ip_vm4, "IP_VM5_1" => ip_vm5_1, "IP_VM5_2" => ip_vm5_2, "IP_VM6" => ip_vm6, "IP_VM7" => ip_vm7, "IP_VM8" => ip_vm8, "IP_VM9_1" => ip_vm9_1, "IP_VM9_2" => ip_vm9_2, "IP_VM10" => ip_vm10}
  end

############################################################################################################################################################################################################################################

  # Machine8 -ubuntu/metasploitable2- setup
  config.vm.define "vm8_#{dni}_#{dif}" do |vm8|
    # Vagrant box from vm8
    vm8.vm.box = "ifly53e/metasploitable2updateable"
    # Hostname configuration
    vm8.vm.hostname = "vm8-Client4-#{dni}-#{dif}"
    # Virtualbox vm8 machine configuration
    vm8.vm.provider "virtualbox" do |vb_vm8|
      vb_vm8.gui = false
      vb_vm8.memory = 512
      vb_vm8.cpus = 1
      vb_vm8.customize ["modifyvm", :id,"--name", "vm8-Client4_#{dni}_#{dif}"]
    end
    vm8.ssh.insert_key = false
    # Network configuration
    vm8.vm.network "private_network", ip: ip_vm8, :netmask => "255.255.255.248", virtualbox__intnet: "RED_PRE_PRODUCCION"
    # Port configuration
    vm8.ssh.port = 2227
    vm8.vm.network "forwarded_port", guest: 22, host: 2227 #SSH
    # Shared Folders
    vm8.vm.synced_folder '.', '/vagrant', disabled: false
    # Provisioning configuration
    vm8.vm.provision "shell", inline: "echo 'export DNI=#{dni}' >> /etc/profile.d/dni.sh", privileged: true
    vm8.vm.provision "shell", inline: "echo 'export SELECCION=#{dificultad}' >> /etc/profile.d/dificultad.sh", privileged: true
    vm8.vm.provision "shell", inline: "echo 'export IP_VM1=#{ip_vm1}' >> /etc/profile.d/ip_vm1.sh", privileged: true
    vm8.vm.provision "shell", inline: "echo 'export IP_VM2=#{ip_vm2}' >> /etc/profile.d/ip_vm2.sh", privileged: true
    vm8.vm.provision "shell", inline: "echo 'export IP_VM3=#{ip_vm3}' >> /etc/profile.d/ip_vm3.sh", privileged: true
    vm8.vm.provision "shell", inline: "echo 'export IP_VM4=#{ip_vm4}' >> /etc/profile.d/ip_vm4.sh", privileged: true
    vm8.vm.provision "shell", inline: "echo 'export IP_VM5_1=#{ip_vm5_1}' >> /etc/profile.d/ip_vm5_1.sh", privileged: true
    vm8.vm.provision "shell", inline: "echo 'export IP_VM5_2=#{ip_vm5_2}' >> /etc/profile.d/ip_vm5_2.sh", privileged: true
    vm8.vm.provision "shell", inline: "echo 'export IP_VM6=#{ip_vm6}' >> /etc/profile.d/ip_vm6.sh", privileged: true
    vm8.vm.provision "shell", inline: "echo 'export IP_VM7=#{ip_vm7}' >> /etc/profile.d/ip_vm7.sh", privileged: true
    vm8.vm.provision "shell", inline: "echo 'export IP_VM8=#{ip_vm8}' >> /etc/profile.d/ip_vm8.sh", privileged: true
    vm8.vm.provision "shell", inline: "echo 'export IP_VM9_1=#{ip_vm9_1}' >> /etc/profile.d/ip_vm9_1.sh", privileged: true
    vm8.vm.provision "shell", inline: "echo 'export IP_VM9_2=#{ip_vm9_2}' >> /etc/profile.d/ip_vm9_2.sh", privileged: true
    vm8.vm.provision "shell", inline: "echo 'export IP_VM10=#{ip_vm10}' >> /etc/profile.d/ip_vm10.sh", privileged: true
    vm8.vm.provision "shell", path: "Aprovisionamiento/vm8/vm8.bootstrap.sh", env: {"BANDERA7" => bandera7, "DNI" => dni, "SELECCION" => dificultad, "IP_VM1" => ip_vm1, "IP_VM2" => ip_vm2, "IP_VM3" => ip_vm3, "IP_VM4" => ip_vm4, "IP_VM5_1" => ip_vm5_1, "IP_VM5_2" => ip_vm5_2, "IP_VM6" => ip_vm6, "IP_VM7" => ip_vm7, "IP_VM8" => ip_vm8, "IP_VM9_1" => ip_vm9_1, "IP_VM9_2" => ip_vm9_2, "IP_VM10" => ip_vm10}
  end

############################################################################################################################################################################################################################################

  # Machine9 -bento/ubuntu-16.04- setup
  config.vm.define "vm9_#{dni}_#{dif}" do |vm9|
    # Vagrant box from vm9
    vm9.vm.box = "bento/ubuntu-16.04"
    # Hostname configuration
    vm9.vm.hostname = "vm9-WebServer-#{dni}-#{dif}"
    # Virtualbox vm9 machine configuration
    vm9.vm.provider "virtualbox" do |vb_vm9|
      vb_vm9.gui = false
      vb_vm9.memory = 512
      vb_vm9.cpus = 1
      vb_vm9.customize ["modifyvm", :id,"--name", "vm9-WebServer_#{dni}_#{dif}"]
    end
    vm9.ssh.insert_key = false
    # Network configuration
    vm9.vm.network "private_network", ip: ip_vm9_1, :netmask => "255.255.255.248", virtualbox__intnet: "RED_PRE_PRODUCCION"
    vm9.vm.network "private_network", ip: ip_vm9_2, :netmask => "255.255.255.248", virtualbox__intnet: "RED_PRODUCCION"
    # Port configuration
    vm9.ssh.port = 2226
    vm9.vm.network "forwarded_port", guest: 22, host: 2226 #SSH
    vm9.vm.network "forwarded_port", guest: 80, host: 8084 #HTTP
    # Provisioning configuration
    vm9.vm.provision "file", source: "Ansible", destination: "/home/vagrant"
    vm9.vm.provision :shell, :inline => "ulimit -n 4048"
    vm9.vm.provision "shell", inline: "echo 'export DNI=#{dni}' >> /etc/profile.d/dni.sh", privileged: true
    vm9.vm.provision "shell", inline: "echo 'export SELECCION=#{dificultad}' >> /etc/profile.d/dificultad.sh", privileged: true
    vm9.vm.provision "shell", inline: "echo 'export IP_VM1=#{ip_vm1}' >> /etc/profile.d/ip_vm1.sh", privileged: true
    vm9.vm.provision "shell", inline: "echo 'export IP_VM2=#{ip_vm2}' >> /etc/profile.d/ip_vm2.sh", privileged: true
    vm9.vm.provision "shell", inline: "echo 'export IP_VM3=#{ip_vm3}' >> /etc/profile.d/ip_vm3.sh", privileged: true
    vm9.vm.provision "shell", inline: "echo 'export IP_VM4=#{ip_vm4}' >> /etc/profile.d/ip_vm4.sh", privileged: true
    vm9.vm.provision "shell", inline: "echo 'export IP_VM5_1=#{ip_vm5_1}' >> /etc/profile.d/ip_vm5_1.sh", privileged: true
    vm9.vm.provision "shell", inline: "echo 'export IP_VM5_2=#{ip_vm5_2}' >> /etc/profile.d/ip_vm5_2.sh", privileged: true
    vm9.vm.provision "shell", inline: "echo 'export IP_VM6=#{ip_vm6}' >> /etc/profile.d/ip_vm6.sh", privileged: true
    vm9.vm.provision "shell", inline: "echo 'export IP_VM7=#{ip_vm7}' >> /etc/profile.d/ip_vm7.sh", privileged: true
    vm9.vm.provision "shell", inline: "echo 'export IP_VM8=#{ip_vm8}' >> /etc/profile.d/ip_vm8.sh", privileged: true
    vm9.vm.provision "shell", inline: "echo 'export IP_VM9_1=#{ip_vm9_1}' >> /etc/profile.d/ip_vm9_1.sh", privileged: true
    vm9.vm.provision "shell", inline: "echo 'export IP_VM9_2=#{ip_vm9_2}' >> /etc/profile.d/ip_vm9_2.sh", privileged: true
    vm9.vm.provision "shell", inline: "echo 'export IP_VM10=#{ip_vm10}' >> /etc/profile.d/ip_vm10.sh", privileged: true
    vm9.vm.provision "shell", path: "Aprovisionamiento/vm9/vm9.bootstrap.sh", env: {"BANDERA8" => bandera8, "DNI" => dni, "SELECCION" => dificultad, "IP_VM1" => ip_vm1, "IP_VM2" => ip_vm2, "IP_VM3" => ip_vm3, "IP_VM4" => ip_vm4, "IP_VM5_1" => ip_vm5_1, "IP_VM5_2" => ip_vm5_2, "IP_VM6" => ip_vm6, "IP_VM7" => ip_vm7, "IP_VM8" => ip_vm8, "IP_VM9_1" => ip_vm9_1, "IP_VM9_2" => ip_vm9_2, "IP_VM10" => ip_vm10}
    vm9.vm.provision "ansible_local" do |ansible|
      ansible.limit = "vm9"
      ansible.inventory_path = "/home/vagrant/hosts.yml"
      ansible.playbook = "/home/vagrant/playbook.yml"
      ansible.extra_vars = {
        "DNI" => dni,
        "SELECCION" => dificultad,
        "IP_VM1" => ip_vm1,
        "IP_VM2" => ip_vm2,
        "IP_VM3" => ip_vm3,
        "IP_VM4" => ip_vm4,
        "IP_VM5_1" => ip_vm5_1,
        "IP_VM5_2" => ip_vm5_2,
        "IP_VM6" => ip_vm6,
        "IP_VM7" => ip_vm7,
        "IP_VM8" => ip_vm8,
        "IP_VM9_1" => ip_vm9_1,
        "IP_VM9_2" => ip_vm9_2,
        "IP_VM10" => ip_vm10
      }
    end
    vm9.vm.provision "shell", path: "Aprovisionamiento/vm9/vm9.bootstrap2.sh", env: {"BANDERA8" => bandera8, "DNI" => dni, "SELECCION" => dificultad, "IP_VM1" => ip_vm1, "IP_VM2" => ip_vm2, "IP_VM3" => ip_vm3, "IP_VM4" => ip_vm4, "IP_VM5_1" => ip_vm5_1, "IP_VM5_2" => ip_vm5_2, "IP_VM6" => ip_vm6, "IP_VM7" => ip_vm7, "IP_VM8" => ip_vm8, "IP_VM9_1" => ip_vm9_1, "IP_VM9_2" => ip_vm9_2, "IP_VM10" => ip_vm10}
    vm9.vm.provision "shell",
    inline: "sudo systemctl restart apache2"
  end

############################################################################################################################################################################################################################################

  # Machine10 -bento/ubuntu-16.04- setup
  config.vm.define "vm10_#{dni}_#{dif}" do |vm10|
    # Vagrant box from vm10
    vm10.vm.box = "bento/ubuntu-16.04"
    # Hostname configuration
    vm10.vm.hostname = "vm10-DNSServer-#{dni}-#{dif}"
    # Virtualbox vm10 machine configuration
    vm10.vm.provider "virtualbox" do |vb_vm10|
      vb_vm10.gui = false
      vb_vm10.memory = 512
      vb_vm10.cpus = 1
      vb_vm10.customize ["modifyvm", :id,"--name", "vm10-DNSServer_#{dni}_#{dif}"]
    end
    vm10.ssh.insert_key = false
    # Network configuration
    vm10.vm.network "private_network", ip: ip_vm10, :netmask => "255.255.255.248", virtualbox__intnet: "RED_PRODUCCION"
    # Port configuration
    vm10.ssh.port = 2231
    vm10.vm.network "forwarded_port", guest: 22, host: 2231 #SSH
    # Shared Folders
    vm10.vm.synced_folder '.', '/vagrant', disabled: false
    # Provisioning configuration
    vm10.vm.provision "file", source: "Ansible", destination: "."
    vm10.vm.provision :shell, :inline => "ulimit -n 4048"
    vm10.vm.provision "shell", inline: "echo 'export DNI=#{dni}' >> /etc/profile.d/dni.sh", privileged: true
    vm10.vm.provision "shell", inline: "echo 'export SELECCION=#{dificultad}' >> /etc/profile.d/dificultad.sh", privileged: true
    vm10.vm.provision "shell", inline: "echo 'export IP_VM1=#{ip_vm1}' >> /etc/profile.d/ip_vm1.sh", privileged: true
    vm10.vm.provision "shell", inline: "echo 'export IP_VM2=#{ip_vm2}' >> /etc/profile.d/ip_vm2.sh", privileged: true
    vm10.vm.provision "shell", inline: "echo 'export IP_VM3=#{ip_vm3}' >> /etc/profile.d/ip_vm3.sh", privileged: true
    vm10.vm.provision "shell", inline: "echo 'export IP_VM4=#{ip_vm4}' >> /etc/profile.d/ip_vm4.sh", privileged: true
    vm10.vm.provision "shell", inline: "echo 'export IP_VM5_1=#{ip_vm5_1}' >> /etc/profile.d/ip_vm5_1.sh", privileged: true
    vm10.vm.provision "shell", inline: "echo 'export IP_VM5_2=#{ip_vm5_2}' >> /etc/profile.d/ip_vm5_2.sh", privileged: true
    vm10.vm.provision "shell", inline: "echo 'export IP_VM6=#{ip_vm6}' >> /etc/profile.d/ip_vm6.sh", privileged: true
    vm10.vm.provision "shell", inline: "echo 'export IP_VM7=#{ip_vm7}' >> /etc/profile.d/ip_vm7.sh", privileged: true
    vm10.vm.provision "shell", inline: "echo 'export IP_VM8=#{ip_vm8}' >> /etc/profile.d/ip_vm8.sh", privileged: true
    vm10.vm.provision "shell", inline: "echo 'export IP_VM9_1=#{ip_vm9_1}' >> /etc/profile.d/ip_vm9_1.sh", privileged: true
    vm10.vm.provision "shell", inline: "echo 'export IP_VM9_2=#{ip_vm9_2}' >> /etc/profile.d/ip_vm9_2.sh", privileged: true
    vm10.vm.provision "shell", inline: "echo 'export IP_VM10=#{ip_vm10}' >> /etc/profile.d/ip_vm10.sh", privileged: true
    vm10.vm.provision "shell", path: "Aprovisionamiento/vm10/vm10.bootstrap.sh", env: {"BANDERA9" => bandera9, "DNI" => dni, "SELECCION" => dificultad, "IP_VM1" => ip_vm1, "IP_VM2" => ip_vm2, "IP_VM3" => ip_vm3, "IP_VM4" => ip_vm4, "IP_VM5_1" => ip_vm5_1, "IP_VM5_2" => ip_vm5_2, "IP_VM6" => ip_vm6, "IP_VM7" => ip_vm7, "IP_VM8" => ip_vm8, "IP_VM9_1" => ip_vm9_1, "IP_VM9_2" => ip_vm9_2, "IP_VM10" => ip_vm10}
    vm10.vm.provision "ansible_local" do |ansible|
      ansible.limit = "vm10"
      ansible.inventory_path = "/home/vagrant/hosts.yml"
      ansible.playbook = "/home/vagrant/playbook.yml"
      ansible.install = true
      ansible.extra_vars = {
        "DNI" => dni,
        "SELECCION" => dificultad,
        "IP_VM1" => ip_vm1,
        "IP_VM2" => ip_vm2,
        "IP_VM3" => ip_vm3,
        "IP_VM4" => ip_vm4,
        "IP_VM5_1" => ip_vm5_1,
        "IP_VM5_2" => ip_vm5_2,
        "IP_VM6" => ip_vm6,
        "IP_VM7" => ip_vm7,
        "IP_VM8" => ip_vm8,
        "IP_VM9_1" => ip_vm9_1,
        "IP_VM9_2" => ip_vm9_2,
        "IP_VM10" => ip_vm10
      }
    end
    vm10.vm.provision "shell", path: "Aprovisionamiento/vm10/vm10.bootstrap2.sh", env: {"BANDERA9" => bandera9, "DNI" => dni, "SELECCION" => dificultad, "IP_VM1" => ip_vm1, "IP_VM2" => ip_vm2, "IP_VM3" => ip_vm3, "IP_VM4" => ip_vm4, "IP_VM5_1" => ip_vm5_1, "IP_VM5_2" => ip_vm5_2, "IP_VM6" => ip_vm6, "IP_VM7" => ip_vm7, "IP_VM8" => ip_vm8, "IP_VM9_1" => ip_vm9_1, "IP_VM9_2" => ip_vm9_2, "IP_VM10" => ip_vm10}
  end

############################################################################################################################################################################################################################################

end
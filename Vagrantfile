# -*- mode: ruby -*-
# vi: set ft=ruby :

require_relative "src/ConfigReader"

# Vagrantfile API/syntax version. Don't touch unless you know what
# you're doing!
VAGRANTFILE_API_VERSION = "2"

boxes = ConfigReader.load

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    boxes.each do |box|
        config.vm.define box.name do |vm|
            # Box to use
            vm.vm.box = box.box

            # Path to box
            if (box.url) then
                vm.vm.box_url = box.url
            end

            # Configure ssh
            vm.ssh.username = box.username
            if (box.password) then
                vm.ssh.password = box.password
            end
            vm.ssh.private_key_path = box.priv_keys
            vm.ssh.forward_x11 = true

            # Shared folders
            vm.vm.synced_folder(".", "/vagrant", disabled: true)
            box.shared.each do |folder, path|
                vm.vm.synced_folder(folder, path)
            end

            # Virtualbox settings
            vm.vm.provider "virtualbox" do |vb|
                vb.gui = !box.headless
                vb.name = box.name

                # Use VBoxManage to customize the VM.
                vb.customize ["modifyvm", :id, "--memory", box.memory]
                vb.customize ["modifyvm", :id, "--cpus", box.cpus]
                vb.customize ["modifyvm", :id, "--boot1", box.boot1]
                vb.customize ["modifyvm", :id, "--boot2", box.boot2]
                vb.customize ["modifyvm", :id, "--boot3", box.boot3]
                vb.customize ["modifyvm", :id, "--boot4", box.boot4]
                vb.customize ["modifyvm", :id, "--vram", box.vram]
                vb.customize [
                    "modifyvm",
                    :id,
                    "--accelerate3d",
                    box.accelerate3d
                ]
                vb.customize [
                    "modifyvm",
                    :id,
                    "--clipboard",
                    box.clipboard
                ]

                # Attach any specified iso files
                if (box.iso) then
                    vb.customize [
                        "storageattach",
                        :id,
                        "--storagectl",
                        "IDE",
                        "--port",
                        "1",
                        "--device",
                        "0",
                        "--type",
                        "dvddrive",
                        "--medium",
                        box.iso
                    ]
                end
            end

            # Provision private keys
            box.priv_keys.each do |key|
                if (key.end_with?(".upload"))
                    vm.vm.provision "file" do |f|
                        f.source = key
                        priv = key.split("/")[-1].split(".")[0]
                        f.destination = "~/.ssh/#{priv}"
                    end
                end
            end

            # Provision public keys
            box.pub_keys.each do |key|
                config.vm.provision "file" do |f|
                    f.source = key
                    f.destination = "~/.ssh/#{key.split("/")[-1]}"
                end
            end

            # Provision scripts in numerical order
            box.scripts.each do |script|
                config.vm.provision "shell" do |s|
                    s.path = script
                    s.args = [box.username]
                end
            end

            # Networking
            if (box.public) then
                vm.vm.network "public_network"
            end
            if (box.private_ip) then
                vm.vm.network "private_network", ip: box.private_ip
            end

            # Forward ports
            box.forward_ports.each do |guest, host|
                vm.vm.network "forwarded_port",
                              guest: guest,
                              host: host
            end
        end
    end
end

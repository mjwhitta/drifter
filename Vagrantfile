# -*- mode: ruby -*-
# vi: set ft=ruby :

require "pathname"

require_relative "DrifterConfig"

# Vagrantfile API/syntax version. Don't touch unless you know what
# you're doing!
VAGRANTFILE_API_VERSION = "2"

boxes = DrifterConfig.load

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    boxes.each do |box|
        config.vm.define box.name do |vm|
            # Box to use
            vm.vm.box = box.box

            # Path to box
            vm.vm.box_url = box.url

            # Configure ssh
            vm.ssh.username = box.username
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
        end
    end
end

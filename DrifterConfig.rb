require_relative "src/Box"

module DrifterConfig
    def self.get()
        boxes = Array.new

        # Create Manjaro box
        manjaro = Box.new("boxes/manjaro-openbox-0.8.10-x86_64.box",
                          "manjaro")
        manjaro.cpus = "2"
        manjaro.memory = "2048"
        boxes.push(manjaro)

        # Create Kali box
        kali = Box.new("mjwhitta/kali-linux-1.0.7-amd64", "kali")
        kali.cpus = "2"
        kali.memory = "2048"
        kali.username = "root"
        boxes.push(kali)

        # Create Nebula box
        nebula = Box.new("mjwhitta/exploit-exercises-nebula-5",
                         "nebula")
        nebula.headless = true
        nebula.memory = "512"
        nebula.password = "nebula"
        nebula.set_iso_only
        nebula.username = "nebula"
        boxes.push(nebula)

        # Create Protostar box
        protostar = Box.new("mjwhitta/exploit-exercises-protostar-2",
                            "protostar")
        protostar.headless = true
        protostar.memory = "512"
        protostar.password = "godmode"
        protostar.set_iso_only
        protostar.username = "root"
        boxes.push(protostar)

        # Create Fusion box
        fusion = Box.new("mjwhitta/exploit-exercises-fusion-2",
                         "fusion")
        fusion.headless = true
        fusion.memory = "512"
        fusion.password = "godmode"
        fusion.set_iso_only
        fusion.username = "fusion"
        boxes.push(fusion)

        # Create DevStack box
        devstack = Box.new("mjwhitta/openstack-dev-devstack",
                           "devstack")
        devstack.cpus = "2"
        devstack.forward_ports[80] = 8001
        devstack.memory = "2048"
        devstack.scripts.clear
        devstack.username = "user"
        boxes.push(devstack)

        # Create WebGoat box
        webgoat = Box.new("mjwhitta/owasp-webgoat", "webgoat")
        webgoat.forward_ports[8080] = 8002
        webgoat.headless = true
        webgoat.scripts.clear
        webgoat.username = "user"
        boxes.push(webgoat)

        return boxes
    end
end

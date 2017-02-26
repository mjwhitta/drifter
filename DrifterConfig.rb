require_relative "src/Box"

module DrifterConfig
    def self.get()
        boxes = Array.new

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

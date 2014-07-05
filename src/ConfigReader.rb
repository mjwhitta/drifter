require_relative "Box"
require "etc"
require "pathname"

module ConfigReader
    def self.existing_boxes(boxes)
        # Remove boxes that don't exist
        boxes.delete_if do |box|
            is_http = true
            exists_locally = false
            if (box.url) then
                is_http = box.url.start_with?("http")
                exists_locally = Pathname.new(box.url).exist?
            end
            (!is_http && !exists_locally)
        end

        return boxes
    end

    def self.load()
        if (Pathname.new("#{Etc.getlogin}Config.rb").exist?) then
            require_relative "../#{Etc.getlogin}Config"
        else
            require_relative "../DrifterConfig"
        end
        return existing_boxes(DrifterConfig.get)
    end
end

#!/usr/bin/env ruby

require "pathname"

DRIFTER_DIR = Pathname.new("~/.drifter").expand_path
Dir.chdir(DRIFTER_DIR) do
    system("vagrant #{ARGV.join(" ")}")
end

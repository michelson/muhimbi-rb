require "muhimbi/version"
require 'savon'

module Muhimbi
  autoload :VERSION, 'muhimbi/version.rb'
  autoload :Config, 'muhimbi/config.rb'
  autoload :Converter, 'muhimbi/converter.rb'
  autoload :Client, 'muhimbi/client.rb'
end
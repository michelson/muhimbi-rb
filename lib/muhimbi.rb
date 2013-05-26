require "muhimbi/version"
require 'savon'

module Muhimbi
  autoload :VERSION, 'muhimbi/version.rb'
  autoload :Config, 'muhimbi/config.rb'
  autoload :Client, 'muhimbi/client.rb'
  autoload :Converter, 'muhimbi/converter.rb'
end
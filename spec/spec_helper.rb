$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'debugger'
require File.join(File.dirname(__FILE__), '../lib', 'muhimbi')
require 'stringio'
require "pry"

RSpec.configure do |config|

  def fixture_key(filename)
    File.dirname(__FILE__) + "/fixtures/#{filename}"
  end

  def config_options
    config = YAML.load( File.open(fixture_key("config.yml")) )
    return config
  end

  def config_setup
    Ruby::Muhimbi::Config.setup do |config|
      config.wsdl = config_options["wsdl"]
    end
    Ruby::Muhimbi::Config
  end

end


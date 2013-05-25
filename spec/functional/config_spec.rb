require File.expand_path(File.dirname(__FILE__) + '../../spec_helper')

describe "Config class" do
  before(:all) do

    Muhimbi::Config.setup do |config|
      config.wsdl = config_options["wsdl"]
    end
  end

  it "should have all the required keys" do
    Muhimbi::Config.wsdl.should_not be_empty
  end

end
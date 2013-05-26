require File.expand_path(File.dirname(__FILE__) + '../../spec_helper')

describe "Client class" do
  before(:all) do
    Muhimbi::Config.setup do |config|
      config.wsdl = config_options["wsdl"]
    end
    @client = Muhimbi::Client.client
  end

  it "savon client" do
    @client.class.should == Savon::Client
  end

  it "should have operations" do
    @client.operations.class.should == Array
  end

  it "operations should include to convert" do
    @client.operations.include?(:convert).should be_true
  end

   context "Get Configuration" do
     before :each do
       @client = Muhimbi::Client
     end
     it "get_configuration" do
       @client.get_configuration.should_not be_blank
       @client.get_configuration.keys.should include(:conversion_server_address)
     end
   end

   context "Get Diagnostics" do
     before :each do
       @client = Muhimbi::Client
     end
     it "get_diagnostics" do
       @client.get_diagnostics(["WordProcessing", "InfoPath"]).should_not be_blank
     end
   end
end
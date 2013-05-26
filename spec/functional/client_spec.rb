require "base64"
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

  context "convert 2" do
    before :each do
      @file = File.open(File.dirname(__FILE__) + "/../fixtures/doc.doc")
      @client = Muhimbi::Client.new(@file)
      @client.convert
    end

    it "file should exists" do
      File.exist?(@file).should be_true
    end

    it "client" do
      @client.response.should_not be_blank
    end


  end

end
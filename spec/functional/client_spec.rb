require "base64"
require File.expand_path(File.dirname(__FILE__) + '../../spec_helper')

describe "Client class" do
  before(:all) do
    Muhimbi::Config.setup do |config|
      config.wsdl = config_options["wsdl"]
    end
    @client = Muhimbi.client
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

  context "stats" do
    it "description" do
      @client
    end
  end

  context "convert" do

    before :each do
      @file = File.open(File.dirname(__FILE__) + "/../fixtures/doc.docx")
      @sourceFile = Base64.encode64(@file.read)
    end

    it "file should exists" do
      File.exist?(@file).should be_true
    end

    it "should upload file" do
      #binding.pry
      open_options = {
        "ns1:fileExtension"=> "docx",
        "ns1:originalFileName"=> "doc.docx"
      }
      conversion_settings = {
        "ns1:format"=> "pdf",
        "ns1:fidelity"=> "Full",
        "ns1:openPassword"=> "",
        "ns1:ownerPassword"=> ""
      }

      response = @client.call(:convert , message: {
        "ns:sourceFile"=> @sourceFile,
        "ns:openOptions"=> open_options,
        "ns:conversionSettings"=> conversion_settings
        }
      )


    end


  end

end
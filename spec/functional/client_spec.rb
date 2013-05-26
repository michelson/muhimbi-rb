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
      @file = File.open(File.dirname(__FILE__) + "/../fixtures/doc.doc")
      @sourceFile = Base64.strict_encode64(@file.read)
    end

    it "file should exists" do
      File.exist?(@file).should be_true
    end

    it "should upload file" do

      open_options = {
        "ns1:FileExtension"=> "doc",
        "ns1:OriginalFileName"=> "doc.doc"
      }
      conversion_settings = {
        "ns1:Format"=> "PDF",
        "ns1:Fidelity"=> "Full"
      }

      response = @client.call(:convert , message: {
        "ns:sourceFile"=> @sourceFile,
        "ns:openOptions"=> open_options,
        "ns:conversionSettings"=> conversion_settings
        }
      )

      res = response.to_hash[:convert_response][:convert_result]
      res.should_not be_blank

      #res.should be Base64.strict_decode64(@sourceFile)

      decoded  = Base64.strict_decode64(res)

      File.open("FUFU.pdf", 'w') {|f| f.write(decoded) }

    end


  end

end
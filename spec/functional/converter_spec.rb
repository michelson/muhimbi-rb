require File.expand_path(File.dirname(__FILE__) + '../../spec_helper')

describe "Converter" do
  before(:all) do
    Muhimbi::Config.setup do |config|
      config.wsdl = config_options["wsdl"]
    end
    @client = Muhimbi::Client.client
  end

  context "conversion" do
    before :each do
      @file = File.open(File.dirname(__FILE__) + "/../fixtures/doc.doc")
      @client = Muhimbi::Converter.new(file: @file)
      @response = @client.convert
    end

    it "file should exists" do
      File.exist?(@file).should be_true
    end

    it "client" do
      @response.should_not be_blank
    end
  end

end
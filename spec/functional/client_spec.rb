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

  context "convert" do

    before :each do
      @file = File.open(File.dirname(__FILE__) + "/../fixtures/image.jpeg")
      @sourceFile = Base64.encode64(@file.read)
    end

    it "file should exists" do
      File.exist?(@file).should be_true
    end

    it "should upload file" do
      #convert = Convert.new(sourceFile, openOptions, conversionSettings)

      #sourceFile: @sourceFile
      open_options = {
        fileExtension: "jpeg",
        originalFileName: "image.jpeg"
      }
      conversion_settings = {
        format: "pdf",
        fidelity: "Full",
        openPassword: "",
        ownerPassword: ""
      }

      response = @client.call(:convert , message: {
        sourceFile: @sourceFile,
        conversionSettings: conversion_settings,
        openOptions: open_options
        }
      )

      binding.pry
    end


  end

end
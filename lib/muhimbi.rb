require "muhimbi/version"
require 'savon'

module Muhimbi
  autoload :VERSION, 'muhimbi/version.rb'
  autoload :Config, 'muhimbi/config.rb'
  autoload :Converter, 'muhimbi/converter.rb'
  #autoload :Client, 'muhimbi/client.rb'


  def self.client
    Savon.client do
      wsdl Muhimbi::Config.wsdl
      namespaces(
        "xmlns:ns" =>"http://services.muhimbi.com/2009/10/06",
        "xmlns:ns1"=>"http://types.muhimbi.com/2009/10/06",
        "xmlns:ns2"=>"http://types.muhimbi.com/2010/05/17"
      )
      namespace_identifier :ns
      #element_form_default :qualified
      env_namespace :soapenv
    end

    #Savon.client do |wsdl, http|
    #  wsdl.document = Muhimbi::Config.wsdl
    #  #http.proxy = "http://proxy.example.com"
    #end
  end

end

require "active_support/core_ext/class/subclasses"

module Muhimbi
  class Client

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
    end

    def self.get_configuration
      wsdl_res = Muhimbi::Client.client.call(:get_configuration )
      wsdl_res.to_hash[:get_configuration_response][:get_configuration_result]
    end

    def self.get_diagnostics(opts=[])

      arr = []

      opts.each do |opt|
        arr << {"ns1:DiagnosticRequestItem"=> { "ns1:ConverterName" => opt }}
      end

      msg_options = {"ns:convertersToDiagnose"=> arr  }

      wsdl_res = Muhimbi::Client.client.call(:get_diagnostics, message: msg_options )
      wsdl_res.to_hash[:get_diagnostics_response][:get_diagnostics_result]
    end

  end
end
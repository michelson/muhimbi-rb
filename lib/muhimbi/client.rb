
module Muhimbi
  class Client

    attr_accessor :file_content,
                  :file,
                  :open_options,
                  :conversion_settings,
                  :response

    def initialize(file, opts=nil)
      self.file_content = encode_file(file)
      self.file         = file
      default_options
    end

    def convert

      wsdl_res = Muhimbi::Client.client.call(:convert , message: {
        "ns:sourceFile"        => self.file_content,
        "ns:openOptions"       => self.open_options,
        "ns:conversionSettings"=> conversion_settings
        }
      )

      @response = wsdl_res.to_hash[:convert_response][:convert_result]
    end

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

private

    def encode_file(file)
      Base64.strict_encode64(file.read)
    end

    def default_options
      default_open_options
      default_conversion_settings
    end

    def default_open_options
      self.open_options = {
        "ns1:FileExtension"   => File.extname( self.file ).gsub(".", ""),
        "ns1:OriginalFileName"=> File.basename( self.file)
      }
    end

    def default_conversion_settings
      self.conversion_settings = {
        "ns1:Format"=> "PDF",
        "ns1:Fidelity"=> "Full"
      }
    end

  end
end
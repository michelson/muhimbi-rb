
module Muhimbi
  class Client

    attr_accessor :file_content,
                  :file,
                  #:open_options,
                  #:conversion_settings,
                  :options
                  :response

    def initialize(file, opts={})

      self.file_content = encode_file(file)

      self.file         = file

      self.tap do |client|
        client.options    ||= {}
        client.defaults_options(opts)
        client.options ||= opts
        yield client if block_given?
      end

    end

    def convert
      wsdl_res = Muhimbi::Client.client.call(:convert , message: self.options )
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

    def method_missing(meth, opts = {})
      merge_options meth, opts
    end

    def defaults_options(opts={})

      self.sourceFile(self.file_content)

      self.openOptions({
        "ns1:FileExtension"   => File.extname( self.file ).gsub(".", ""),
        "ns1:OriginalFileName"=> File.basename( self.file)
      })

      self.conversionSettings({
        "ns1:Format"=> "PDF",
        "ns1:Fidelity"=> "Full"
      })
    end

private

    def merge_options(name, opts)
      @options.merge! "ns:#{name}" => opts
    end

    def encode_file(file)
      Base64.strict_encode64(file.read)
    end

  end
end
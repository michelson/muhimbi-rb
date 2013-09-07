require "active_support/core_ext/class/subclasses"

module Muhimbi
  class Converter

    attr_accessor :file_content,
                  :file,
                  :options

    def initialize(opts={})

      unless opts[:file].blank?
        self.file_content = encode_file(opts[:file])
        self.file         = opts[:file]
      end

      self.tap do |client|
        client.options    ||= {}
        client.defaults_options(opts)
        client.options ||= opts
        yield client if block_given?
      end

    end

    def convert
      wsdl_res = Muhimbi::Client.client.call(:convert , message: self.options )
      wsdl_res.to_hash[:convert_response][:convert_result]
    end

    def method_missing(meth, opts = {})
      merge_options meth, opts
    end

    def defaults_options(opts={})

      self.sourceFile(self.file_content)

      self.openOptions({
        "FileExtension"   => File.extname( self.file ).gsub(".", ""),
        "OriginalFileName"=> File.basename( self.file)
      })

      self.conversionSettings({
        "Format"  => "PDF",
        "Fidelity"=> "Full"
      })
    end

private

    def allowed_methods
      ["sourceFile", "openOptions", "conversionSettings"]
    end

    def merge_options(name, opts)
      name = name.to_s.camelize(:lower)
      @options.merge! "ns:#{name}" => redo_opts(opts) if allowed_methods.include?(name)
    end

    def redo_opts(opts)
      return opts unless opts.class == Hash
      Hash[opts.map {|k, v| ["ns1:#{k}", v] }]
    end

    def encode_file(file)
      Base64.strict_encode64(file.read)
    end

  end
end
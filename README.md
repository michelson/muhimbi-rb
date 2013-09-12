# Muhimbi

This library implements a client for interact with muhimbi services.

This gem uses savon library to interface services.

## Installation

Add this line to your application's Gemfile:

    gem 'muhimbi'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install muhimbi

## Usage

### setup

    Muhimbi::Config.setup do |config|
      config.wsdl = "http://your_ip/Muhimbi.DocumentConverter.WebService/?wsdl"
      config.timeout = 200 #defaults to 30
    end

### Client

    @file = File.open(some_file)

    @client = Muhimbi::Converter.new(file: @file)
    @response = @client.convert

### Get configuration & options

    @client.get_configuration

    @client.get_diagnostics(["WordProcessing", "InfoPath"])


### TODO

  this needs some
  + More Specs
  + ProcessBatch implementation and Specs
  + Watermarking implementation and Specs

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

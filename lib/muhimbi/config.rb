require "active_support/core_ext/module/attribute_accessors"

module Muhimbi
  class Config

    def self.setup
      yield self
    end

    mattr_accessor  :wsdl, :timeout


  end
end
# encoding: utf-8

require 'uri'

module DataMapper
  module Validations
    module Format
      module Url

        def self.included(base)
          DataMapper::Validations::FormatValidator::FORMATS.merge!(
            :url => [
              Url,
              lambda { |field, value|
                '%s is not a valid URL'.t(value)
              }
            ]
          )
        end

        Url = begin
          URI.regexp(['http','https'])
        end

      end # module Url
    end # module Format
  end # module Validations
end # module DataMapper

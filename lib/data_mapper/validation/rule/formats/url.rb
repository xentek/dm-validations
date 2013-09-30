# encoding: utf-8

require 'uri'

module DataMapper
  module Validation
    class Rule
      module Formats

        Url = begin
          URI.regexp(['http','https'])
        end

      end # module Formats
    end # class Rule
  end # module Validation
end # module DataMapper

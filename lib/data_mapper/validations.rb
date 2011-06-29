require 'data_mapper/validations/validators'

module DataMapper
  module Validations

    def self.included(base)
      base.extend ClassMethods
      base.extend Validators
    end

    # Check if a resource is valid in a given context
    #
    # @api public
    def validate(context = :default)
      model = respond_to?(:model) ? self.model : self.class
      validation_context = model.validators.context(context)
      validation_context.validate(self)
    end

    # @api public
    # TODO: replace all internal uses of #valid? with #validate
    # TODO: deprecate #valid? in favor of #validate
    def valid?(*args)
      validate(*args)
    end

    # Alias for validate(:default)
    #
    # TODO: deprecate
    # 
    # @api public
    def valid_for_default?
      validate(:default)
    end

    # Return the ValidationErrors
    #
    # @api public
    def errors
      @errors ||= ValidationErrors.new(self)
    end

    # @api public
    def validation_property_value(name)
      __send__(name) if respond_to?(name, true)
    end

    # Mark this resource as validatable. When we validate associations of a
    # resource we can check if they respond to validatable? before trying to
    # recursively validate them
    #
    # @api public
    def validatable?
      true
    end

    # The default validation context for this Resource.
    # This Resource's default context can be overridden by implementing
    # #default_validation_context
    # 
    # @return [Symbol]
    #   the current validation context from the context stack
    #   (if valid for this model), or :default
    # 
    # @api public
    def default_validation_context
      model.validators.current_context || :default
    end

    module ClassMethods

      # Return the set of contextual validators or create a new one
      #
      # @api public
      def validators
        @validators ||= ContextualValidators.new(self)
      end

      # @api private
      def inherited(base)
        super
        self.validators.inherited(base.validators)
      end

    end # module ClassMethods
  end # module Validations
end # module DataMapper
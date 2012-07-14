module ValidatesFormattingOf
  module ValidationAddition
    attr_reader :validations

    def add(name, regex, message = nil)
      @validations ||= {}
      @validations[name.to_sym] = Validation.new(name.to_sym, regex, message)
    end

    def find(attribute, opts)
      method = opts[:using].nil? ? attribute : opts[:using]
      if !exists? method
        raise MissingValidation, "The method #{method.to_sym.inspect} is not a built-in validation."
      end
      self[method]
    end

    def [](name)
      if name.to_sym == :ip_address
        warn "[DEPRECATION] The :ip_address validation for `valdiates_formatting_of` is DEPRECATED. Please update your model validations to use :ip_address_v4. This method will be removed by version 0.7.0."
      end
      @validations[name.to_sym]
    end

    def exists?(name)
      !@validations[name.to_sym].nil?
    end
  end
end

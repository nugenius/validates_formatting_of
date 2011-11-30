module ValidatesFormattingOf
  module ModelAdditions
    def validates_formatting_of(attribute, opts = {})

      # Here is where the input is formatted before it is validated.
      # Not yet implemented.
      # 
      # unless opts[:preformat].nil?
      #   before_validation do
      #     # add formatting changes here
      #   end
      # end

      regex_for_validation = opts[:regex] || validate_with(opts[:using])

      allow_nil = opts[:allow_nil] || false
      allow_blank = opts[:allow_blank] || false

      validates attribute,  :format => {  :with => regex_for_validation,
                                          :message => opts[:message] },
                            :allow_blank => false
    end

    def validate_with(method)
      # Actually retrieve the regex to check against
      formatting.send(method)
    end

    def formatting
      # Grab the validating methods
      @formatting ||= ValidatingMethods.new
    end
  end
end
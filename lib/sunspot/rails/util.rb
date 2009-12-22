require 'escape'

module Sunspot #:nodoc:
  module Rails #:nodoc:
    class Util
      class << self
        def sunspot_options
          @sunspot_options ||= {}
        end
        
        def index_relevant_attribute_changed?( object )
          class_key = object.class.to_s.underscore.to_sym
          ignore_attributes = sunspot_options_for(object.class)[:ignore_attribute_changes_of] || []
          !(object.changes.symbolize_keys.keys - ignore_attributes).blank?
        end

        private

        def sunspot_options_for(clazz)
          class_key = clazz.to_s.underscore.to_sym
          if options = sunspot_options[class_key]
            options
          elsif superclass = clazz.superclass
            sunspot_options_for(superclass)
          end
        end
      end
    end
  end
end

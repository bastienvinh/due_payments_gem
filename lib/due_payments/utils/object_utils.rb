require 'pp'

module DuePayments::Utils
  class ObjectUtils
    class << self
      
      def symbols_set_obj(obj, attributes)
        attributes.each {|attribute, value| obj.send("#{attribute}=", value)}
        return nil
      end
      
    end
  end
end
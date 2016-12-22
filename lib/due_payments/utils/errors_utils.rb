LIB_ROOT ||= File.realpath("#{File.dirname(__FILE__)}/..")
require "#{LIB_ROOT}/exceptions"

module DuePayments

  module Default
    # Exceptions for landlords datas

    def self.landlord_cant_be_find
      return DuePayments::Exception.new("Can't find landlord.")
    end

    def self.invalid_landlord
      return DuePayments::Exception.new("Invalid landlord information")
    end

    # Exceptions for 
    def self.estate_cant_be_found
      return DuePayments::Exception.new("Can't find estate.")
    end

    # General Exceptions

    def self.cant_create_instance
      return DuePayments::Exception.new("Can't create new instance")
    end

    def self.unknown_error
      return DuePayments::Exception.new
    end

    def self.attribute_dont_exists
      return DuePayments::Exception.new("This attribute doesn't exist in the first place")
    end

  end
end
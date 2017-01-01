LIB_ROOT ||= File.realpath("#{File.dirname(__FILE__)}/..")
require "#{LIB_ROOT}/exceptions"

module DuePayments

  module Default
    # Exceptions for landlords datas

    def self.landlord_cant_be_find
      DuePayments::LandlordNotFoundException.new
    end

    def self.invalid_landlord
      DuePayments::Exception.new('Invalid landlord information.')
    end

    # Exceptions for estate
    def self.estate_cant_be_found
      DuePayments::EstatedNotFoundException.new
    end

    def self.estates_is_not_in_this_reminder
      DuePayments::EstateReminderNotFound.new
    end

    # Exception for reminder
    def self.reminder_cant_be_find
      DuePayments::ReminderNotFoundException.new
    end


    # General Exceptions

    def self.cant_create_instance
      DuePayments::Exception.new('Can\'t create new instance')
    end

    def self.unknown_error
      DuePayments::Exception.new
    end

    def self.problem_with_properties
      DuePayments::Exception.new('Properties doesn\'t exist or not filled corretly')
    end

    def self.attribute_dont_exists
      DuePayments::Exception.new('This attribute doesn\'t exist in the first place')
    end

  end
end

module DuePayments

  class Exception < StandardError
    def initialize(msg='Unknown errors ...')
      super
    end
  end

  # Well I choose specific error than generic error. Simply because I don't want
  # developer-user to know that I use database

  class LandlordNotFoundException < DuePayments::Exception
    def initialize(msg='Can\'t find landlord.')
      super
    end
  end

  class EstatedNotFoundException < DuePayments::Exception
    def initialize(msg='Can\'t find estate.')
      super
    end
  end

  class ReminderNotFoundException < DuePayments::Exception
    def initialize(msg='Can\'t find reminder.')
      super
    end
  end

  class EstateReminderNotFound < DuePayments::Exception
    def initialize(msg='Estate is not found in this reminder. Or no reminder for this estate.')
      super
    end
  end

  class AttributeDataUnknownException < DuePayments::Exception

    attr_accessor :attribute

    def initialize(
      msg='Properties doesn\'t exist or not filled corretly',
      attribute = ''
    )
      super(msg)
      @attribute = attribute
    end
  end
end

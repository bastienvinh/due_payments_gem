require "due_payments/version"
require "active_record"
require 'due_payments_base'

module DuePayments
  
  class DPMPayments < DPMRecordBase
    self.table_name = "payments"

    def self.helloworld()
      puts "Hello world !!!"  
    end
  end

end

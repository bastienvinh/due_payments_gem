require "active_record"
require "#{File.dirname(__FILE__)}/due_payments_base"

module DuePayments::Data
  
  class DPMPayments < DPMRecordBase
    self.table_name = "payments"

    def self.helloworld()
      puts "Hello world !!!"  
    end
  end

end

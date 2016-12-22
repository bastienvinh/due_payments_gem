require "active_record"

require "#{File.dirname(__FILE__)}/autoload"

module DuePayments::Data
  
  class DPMPayments < DPMRecordBase
    self.table_name = "payments"
  end

end
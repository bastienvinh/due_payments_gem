require 'active_record'
require "#{File.dirname(__FILE__)}/due_payments_base"

module DuePayments

  class Landlord < DPMRecordBase
    
    self.table_name = "landlords"

  end

end
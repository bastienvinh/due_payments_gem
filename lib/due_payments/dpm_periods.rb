require 'active_record'
require "#{File.dirname(__FILE__)}/due_payments_base"


module DuePayments::Data
  class DPMPeriods < DPMRecordBase
    self.table_name = "periods"
  end
end
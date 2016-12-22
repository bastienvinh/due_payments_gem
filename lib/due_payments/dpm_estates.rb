require 'active_record'
require "#{File.dirname(__FILE__)}/due_payments_base"

module DuePayments::Data
  class DPMEstate < DPMRecordBase
    self.table_name = "estates"
  end
end
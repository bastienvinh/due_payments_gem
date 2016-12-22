require 'active_record'

require "#{File.dirname(__FILE__)}/autoload"

module DuePayments::Data
  class DPMPeriods < DPMRecordBase
    self.table_name = "periods"
  end
end
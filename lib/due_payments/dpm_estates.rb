require 'active_record'
require "#{File.dirname(__FILE__)}/autoload"

module DuePayments::Data
  class DPMEstate < DPMRecordBase
    self.table_name = "estates"
  end
end
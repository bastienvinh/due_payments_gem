require 'active_record'
require "#{File.dirname(__FILE__)}/autoload"

module DuePayments::Data
  class DPMEstate < DPMRecordBase
    self.table_name = "estates"

    belongs_to :landlord, :class_name => "DuePayments::Data::DPMLandlord", :foreign_key => "landlord_id"
  end
end
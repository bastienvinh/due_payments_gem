require 'active_record'

require "#{File.dirname(__FILE__)}/../autoload"

module DuePayments::Data

  class DPMLandlord < DPMRecordBase
    self.table_name = "landlords"

    has_many :estates, :class_name => "DuePayments::Data::DPMEstate", :foreign_key => "landlord_id"

    scope :from_landlords, ->(ids) { where( :id => ids ) }
  end

end
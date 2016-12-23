require 'active_record'
require "#{File.dirname(__FILE__)}/autoload"

module DuePayments::Data
  class DPMReminder < DPMRecordBase
    self.table_name = "reminders"

    belongs_to :estate, class_name: "DuePayments::Data::DPMEstate", foreign_key: "estate_id"
    belongs_to :period, class_name: "DuePayments::Data::DPMPeriods", foreign_key: "period_id"

  end
end
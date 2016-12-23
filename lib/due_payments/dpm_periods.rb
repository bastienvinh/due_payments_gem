require 'active_record'

require "#{File.dirname(__FILE__)}/autoload"

module DuePayments::Data
  class DPMPeriods < DPMRecordBase
    self.table_name = "periods"

    has_many :reminders, :class_name => "DuePayments::Data::DPMReminder", :foreign_key => "period_id"
  end
end
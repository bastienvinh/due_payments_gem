require 'active_record'

require "#{File.dirname(__FILE__)}/autoload"

module DuePayments::Data
  class DPMStatusReminder < DPMRecordBase
    self.table_name = "status_reminder"
  end
end
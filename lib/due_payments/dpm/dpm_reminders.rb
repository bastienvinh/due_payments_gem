require 'active_record'
require "#{File.dirname(__FILE__)}/../autoload"

module DuePayments::Data
  class DPMReminder < DPMRecordBase
    self.table_name = "reminders"

    belongs_to :estate, class_name: "DuePayments::Data::DPMEstate", foreign_key: "estate_id"
    belongs_to :period, class_name: "DuePayments::Data::DPMPeriods", foreign_key: "period_id"

    # I believe 100 years more is reasonable, change it if you found a way to become immortal or to live longer than normal human being
    scope :since, -> (from_date, to_date=DateTime.now + 100.years) {
      where("date_to_pay >= ? AND date_to_pay <= ? ", from_date, to_date)
    }

    scope :by_period, ->(id) { where( :period_id => id ) }

    scope :is_unpaid, ->  { where( :status_id => StatusReminder.UNPAID ) }
    scope :has_paid, -> { where( :status_id => StatusReminder.PAID ) }
    scope :by_estate, ->(id) { where(:estate_id => id ) }

  end
end
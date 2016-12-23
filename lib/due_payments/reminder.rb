require "#{File.dirname(__FILE__)}/autoload"


DPMPeriods = DuePayments::Data::DPMPeriods
DPMReminder = DuePayments::Data::DPMReminder


## BV : Well I wanted to create a automatic system, that generate itsetf
## but for some reason, they want a manual programs. The client is always king.

# TODO : implement a better enumeration system
module StatusReminder
  NONE = 0
  CANCELLED = 1
  NORMAL = 2
  PROBLEM = 3
  UNPAID = 4
  PAID = 5
end

class DuePayments::ReminderStatus

  include DuePayments::Identifier

  attr_accessor :estate_code, :period_code

  private
  def initialize
    # For now I need the minimum information
    @estate_code = nil
    @period_code = nil
    @id = nil
  end

  class << self

    def create_object
      return DuePayments::ReminderStatus.new
    end

    def create(*opts)
      result = convertor(DPMReminder.create(*opts))
      return result
    end

    private
    def convertor(data, has_id=true)
      result = create_object
      result.estate_code = data.estate_id
      result.period_code = data.period_id
      if has_id
        result.id = data.id
      end
    end

  end

end

class Reminder

  attr_accessor :name, :before_date, :number_of_days, :recycle_period, :visible, :number_of_month
  attr_reader :id

  def initialize(reminder_rules = {
    :before_date => DateTime.now,
    :name => "period-#{DateTime.now}",
    :number_of_days => 0,
    :number_of_months => 0,
    :recycle_period => true,
    :enable => true,
    :status_code => StatusReminder.NONE
  })

    @before_date = reminder_rules[:before_date]
    @name = reminder_rules[:name]
    @number_of_days = reminder_rules[:number_of_days]
    @recycle_period = reminder_rules[:recycle_period]
    @enable = reminder_rules[:visible]
    @number_of_months = reminder_rules[:number_of_month]
    @status_code = reminder_rules[:status_code]
    @id = nil

  end
  
  def on(date, estates)
    # TODO : finish this functions
    unless id.nil?
      raise "Save your reminder first."
    end

    estates.each do |estate|
      # TODO : retrieve the date automatically
      DuePayments::ReminderStatus.create(:status_id => @status_code, :estate_id => estate.id, :period_id => @period_id, :date_to_pay => date, :date_to_notify => @before_date)
    end
  end

  # be careful when you save, it might consum a lot
  def save
    if @id.nil? && !Reminder.exists?(@id)
      save_internally_on_database
    else
      update_internaly_on_database 
    end
  end

  def self.exists?(id)
    return DPMPeriods.exists?(id)
  end

  private

  def save_internally_on_database
    DPMPeriods.create( :name => @name, :enable => @enable, :number_of_days => @number_of_days, 
    :number_of_months => @number_of_months, :recycle_period => @recycle_period, :before_date => @before_date )
  end

  def update_internaly_on_database
    data = DPMPeriods.find(@id)
    data.name = @name
    data.enable = @enable
    data.number_of_days = @number_of_days
    data.recycle_period = @recycle_period
    data.before_date = @before_date
    data.number_of_months = @number_of_months
    data.status_id = @status_code
    data.save
  end


end
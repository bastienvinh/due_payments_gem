require "#{File.dirname(__FILE__)}/autoload"

require 'pp'
DPMPeriods = DuePayments::Data::DPMPeriods
DPMReminder = DuePayments::Data::DPMReminder


## TODO : BV : Well I wanted to create a automatic system, that generate itsetf
## But for some reason, they want a manual programs. The client is always king. Think about it later

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

    def find(id)
    end

    def all
      return DPMReminder.all.map { |r| convertor(r) }
    end

    def day(date)
      return DPMReminder
        .where("date_to_pay >= ? AND date_to_pay <= ? ", date.beginning_of_day, date.end_of_day)
        .map { |r| convertor(r) }
    end

    def from(date)
    end

    private
    def convertor(data, has_id=true)
      result = create_object
      result.estate_code = data.estate_id
      result.period_code = data.period_id
      if has_id
        result.id = data.id
      end
      return result
    end

  end

end

class Reminder

  include DuePayments::Identifier

  attr_accessor :name, :before_date, :number_of_days, :recycle_period, :visible, :number_of_month

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

    # TODO : do better than that
    # TODO : verify duplicate date
    if estates.instance_of? DuePayments::Estate
      result = self.class.create_a_reminder_status(date, estates)  
    else
      result = self.class.create_multiple_reminder_status(date, estates)
    end

    return result
  end

  def list(estate_id=nil)

  end

  # We return a exuastive list of
  def list_by_date(date)

  end

  def list_of_today
  end

  def list_of_unpaid
  end

  def list_of_late
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


  class << self

    def find(id)
      
      begin
        data = DPMPeriods.find(1)
        result = Reminder.new(:before_date => data.before_date, :name => data.name, :number_of_days => data.number_of_days, 
        :number_of_months => data.number_of_months, :recycle_period => data.recycle_period, :enable => data.enable)
      rescue ActiveRecord::RecordNotFound
        raise DuePayments::Default.reminder_cant_be_find
      rescue
        raise DuePayments::Default.unknown_error 
      end

      return result
    end

    # TODO : add contract for on estate
    def create_a_reminder_status(date, estate)
      result = DuePayments::ReminderStatus.create(:status_id => @status_code, :estate_id => estate.id, :period_id => @period_id, :date_to_pay => date, :date_to_notify => @before_date)
      pp result
      return { :reminder_id => result.id, :date => date, :estate_id => estate.id }
    end

    # TODO : add contract to reminder status
    def create_multiple_reminder_status(date, estates)
      result = []
      estates.each do |e|
        result << create_a_reminder_status(date, e)
      end
      return result
    end

    def get_lists_all
    end

    def get_by_estate
    end

  end


end
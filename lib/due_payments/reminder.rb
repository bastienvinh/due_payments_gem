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
      result
    end

    def all
      DPMReminder.all.map { |r| convertor(r) }
    end

    def all_from_date(date)
      DPMReminder.since(date).map do |r|  
        { :status_code => r.status_id, :date_to_notify => r.date_to_pay, :date_limit => r.date_to_notify, :active => r.active, :periode_code => r.period_id, :estate_id => r.estate_id }
      end
    end

    def all_between(from_date, to_date)
      DPMReminder.since(from_date, to_date).map do |r|  
        { :status_code => r.status_id, :date_to_notify => r.date_to_pay, :date_limit => r.date_to_notify, :active => r.active, :periode_code => r.period_id, :estate_id => r.estate_id }
      end
    end

    def all_from_estate(id)
      return DPMReminder.by_estate(id).map do |r|  
        { :status_code => r.status_id, :date_to_notify => r.date_to_pay, :date_limit => r.date_to_notify, :active => r.active, :periode_code => r.period_id, :estate_id => r.estate_id }
      end
    end


    def period(period_id)
      DPMReminder.by_period(period_id).map { |r| convertor(r) }
    end

    def period_from_date(period_id, date)
      DPMReminder.by_period(period_id).since(date).map do |r|  
        { :status_code => r.status_id, :date_to_notify => r.date_to_pay, :date_limit => r.date_to_notify, :active => r.active, :periode_code => r.period_id, :estate_id => r.estate_id }
      end
    end

    def period_between(period_id, from_date, to_date)
      DPMReminder.by_period(period_id).since(from_date, to_date).map do |r|  
        { :status_code => r.status_id, :date_to_notify => r.date_to_pay, :date_limit => r.date_to_notify, :active => r.active, :periode_code => r.period_id, :estate_id => r.estate_id }
      end
    end

    def period_from_estate(period_id, estate_id)
      DPMReminder.by_period(period_id).by_estate(estate_id).map do |r|  
        { :status_code => r.status_id, :date_to_notify => r.date_to_pay, :date_limit => r.date_to_notify, :active => r.active, :periode_code => r.period_id, :estate_id => r.estate_id }
      end
    end

    private

    def convertor(data, has_id=true)
      result = create_object
      result.estate_code = data.estate_id
      result.period_code = data.period_id
      if has_id
        result.id = data.id
      end
      result
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
    if @id.nil?
      raise 'Save your reminder first.'
    end

    # TODO : do better than that
    # TODO : verify duplicate date
    estates.instance_of? DuePayments::Estate ? create_a_reminder_status(date, estates) : create_multiple_reminder_status(date, estates)
  end

  # We return a exuastive list of
  def all_by_date(date)
    DuePayments::ReminderStatus.all_from_date(date)
    #  TODO : find a better way to deal with it / tempory way to retrieve the information
    # I do two request to light the request time than using a concatenation
    # landlords = DuePayments::Data::DPMLandlord.from_landlords(data_reminders.map( |r| r.estate_id ))
  end

  def all_of_today
    # TODO : implement this
  end

  def all_is_unpaid
    # TODO : implement this
  end

  def all_late_in_paid
    # TODO : implements this
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
    DPMPeriods.exists?(id)
  end

  private

  def save_internally_on_database
    data = DPMPeriods.create(name: @name, enable: @enable, 
    number_of_days: @number_of_days, number_of_months: @number_of_months, 
    recycle_period: @recycle_period, before_date: @before_date)

    @id = data.id
    self
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

  # TODO : add contract for on estate
  def create_a_reminder_status(date, estate)
    result = DuePayments::ReminderStatus.create(:status_id => @status_code, :estate_id => estate.id, :period_id => @id, :date_to_pay => date, :date_to_notify => @before_date)
    { :reminder_id => result.id, :date => date, :estate_id => estate.id }
  end

  # TODO : add contract to reminder status
  def create_multiple_reminder_status(date, estates)
    result = []
    estates.each do |e|
      result << create_a_reminder_status(date, e)
    end
    return result
  end

  class << self

    def find(id)
      begin
        data = DPMPeriods.find(id)
        result = Reminder.new(:before_date => data.before_date, :name => data.name, :number_of_days => data.number_of_days, 
        :number_of_months => data.number_of_months, :recycle_period => data.recycle_period, :enable => data.enable)
        result.id = data.id
      rescue ActiveRecord::RecordNotFound
        raise DuePayments::Default.reminder_cant_be_find
      rescue
        DuePayments::Default.unknown_error
      end
      result
    end

  end


end
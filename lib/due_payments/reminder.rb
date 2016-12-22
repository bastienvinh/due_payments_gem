require "#{File.dirname(__FILE__)}/autoload"

class Reminder

  def initialize(reminder_rules = {
    :before_date => DateTime.now,
    :name => "task-#{DateTime.now}",
    :number_of_days => 0,
    :recycle_period => true
  })

    @before_date = reminder_rules[:before_date]
    @name = reminder_rules[:name]
    @number_of_days = reminder_rules[:number_of_days]
    @recycle_period = reminder_rules[:recycle_period]
    @id = nil

  end
  
  def on(dates, estate)
  end


  class << self

    def generate
    end

    def update_all
    end

    def save(reminder)
      # TODO : verify it's  a reminder with a contract
    end

  end

end
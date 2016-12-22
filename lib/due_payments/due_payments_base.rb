require 'active_record'
require 'yaml'

module DuePayments::Data

  class DPMRecordBase < ActiveRecord::Base

    self.abstract_class = true

    def self.configure
      # don't need to reconnect, use default connection if possible  
      unless ActiveRecord::Base.connected?
        db_config = YAML::load(File.open('config/database.yml'))['development']
        connection = ActiveRecord::Base.establish_connection(db_config)
        return connection
      end
    end

  end
  
end
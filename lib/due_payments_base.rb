require 'active_record'
require 'yaml'

module DuePayments

  class DPMRecordBase < ActiveRecord::Base

    self.abstract_class = true

    def self.configure

      # don't need to reconnect, use default connection if possible  
      unless ActiveRecord::Base.connected?
        db_config = YAML::load(File.open('config/database.yml'))['development']
        ActiveRecord::Base.establish_connection(db_config)
      end
    
    end

  end
end
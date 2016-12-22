################## Private Methods

def start_by_initiatng_database

   filename = "db/test.sqlite3"
    db_config = YAML::load(File.open('config/database.yml'))['test']

    if !File.exist?("db/test.sqlite3")

      puts "Creating database file : #{filename}"

      ActiveRecord::Base.establish_connection(db_config)
      ActiveRecord::Migrator.migrate("db/migrate/")
      
      require 'active_record/schema_dumper'
      filename = "db/schema.rb"
      File.open(filename, "w:utf-8") do |file|
        ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
      end

    else
      puts "Already created database file : #{filename}"
    end

end

def finish_by_delete_database
  filename = "db/test.sqlite3"
    if File.exists?(filename)
      File.delete filename
      puts "Delete environment test file #{filename}"
    end
end


################## End Private Methods
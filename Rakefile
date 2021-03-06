require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "active_record"
require "yaml"
require "pp"


require "rubygems/commands/uninstall_command"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec


desc "Uninstall the gem"
task :uninstall do

  begin
    Gem::Uninstaller.new('due_payments', :all => true, :executables => true).uninstall
    `rm -f *.gem`
    puts "Gem due_payments has just been deleted ..."
    puts "Enjoy ..."    
  rescue
    puts "You have an error ..."
  end
end

namespace :db do

  RAILS_ENV = 'development'
  db_config       = YAML::load(File.open('config/database.yml'))[RAILS_ENV]

  desc "Create the database"
  task :create do
    ActiveRecord::Base.establish_connection(db_config)
    ActiveRecord::Base.connection.create_database(db_config["database"])
    puts "Database created."
  end

  desc "Migrate the database"
  task :migrate do
    ActiveRecord::Base.establish_connection(db_config)
    ActiveRecord::Migrator.migrate("db/migrate/")
    Rake::Task["db:schema"].invoke
    puts "Database migrated."
  end

  desc "Drop the database"
  task :drop do
    ActiveRecord::Base.establish_connection(db_config)
    ActiveRecord::Base.connection.drop_database(db_config["database"])
    puts "Database deleted."
  end

  desc "Reset the database"
  task :reset => [:drop, :create, :migrate]

  desc 'Create a db/schema.rb file that is portable against any DB supported by AR'
  task :schema do
    ActiveRecord::Base.establish_connection(db_config)
    require 'active_record/schema_dumper'
    filename = "db/schema.rb"
    File.open(filename, "w:utf-8") do |file|
      ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
    end
  end


  desc 'Fill database with false data'
  task :seed do
    ActiveRecord::Base.establish_connection(db_config)
    filename = "db/seed.rb"
    abs_path_filename = "#{File.dirname(__FILE__)}/#{filename}"
    if File.exists?(abs_path_filename)
      load(abs_path_filename)
    end
  end

end

namespace :app do

  desc "build applications"
  task :build do
    `rm -rf *.gem`
    puts 'Old packages deleted ...'
    `gem build due_payments.gemspec`
    puts "Buildings done ..."
  end

end

namespace :g do
  desc "Generate migration"
  task :migration do
    name = ARGV[1] || raise("Specify name: rake g:migration your_migration")
    timestamp = Time.now.strftime("%Y%m%d%H%M%S")
    path = File.expand_path("../db/migrate/#{timestamp}_#{name}.rb", __FILE__)
    migration_class = name.split("_").map(&:capitalize).join

    File.open(path, 'w') do |file|
      file.write <<-EOF
class #{migration_class} < ActiveRecord::Migration

  def self.up
  end

  def self.down
  end

end
      EOF
    end

    puts "Migration #{path} created"
    abort # needed stop other tasks
  end
end
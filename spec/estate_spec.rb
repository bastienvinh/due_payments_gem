require "spec_helper"
require 'active_record_test'

require "#{File.dirname(__FILE__)}/autoload"

Estate = DuePayments::Estate

RSpec.describe "Estates database" do

  before :all do
    DuePayments::Core.silence_stdout { start_by_initiatng_database }
    puts "Database created and loaded ..."
  end

  context "Creation" do
    context "create_object method" do
      it "create_object method create new instance DuePayment::Estate" do
        result = Estate.create_object
        expect(result).not_to be_nil
        expect(result).to be_instance_of(DuePayments::Estate)
      end

      it "create_object method set default values" do

        result = Estate.create_object

        expect(result.name).not_to be_nil
        expect(result.price_per_acre).not_to be_nil
        expect(result.landlord_id).not_to be_nil
        expect(result.acre).not_to be_nil
        expect(result.zip_code).not_to be_nil
        expect(result.address).not_to be_nil
        expect(result.geolocalisation).not_to be_nil
        expect(result.coordinate_points).not_to be_nil
        expect(result.description).not_to be_nil
        expect(result.total_price).not_to be_nil

        expect(result.name).to be_instance_of(String)
        expect(result.price_per_acre).to be_instance_of(BigDecimal)
        expect(result.landlord_id).to be_instance_of(Fixnum)
        expect(result.acre).to be_instance_of(Fixnum)
        expect(result.zip_code).to be_instance_of(String)
        expect(result.address).to be_instance_of(String)
        expect(result.geolocalisation).to be_instance_of(String)
        expect(result.coordinate_points).to be_instance_of(String)
        expect(result.description).to be_instance_of(String)
        expect(result.total_price).to be_instance_of(BigDecimal)
        
      end
    end

    context "create method" do
      it "create method returns a DuePayment::Estate" do
        #TODO : finish this method
      end

      it "create method create a data on the database" do
        #TODO : finish this method
      end
    end

  end

  after :all do
    finish_by_delete_database
    puts "Database deleted ..."
  end

end
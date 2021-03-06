require "spec_helper"

require 'autoload'
require 'active_record_test'

Landlord = DuePayments::Landlord

################## Tests

RSpec.describe "Landlord database" do

  before :all do
    # Don't need to see all th migration database informations ... Active records work very well already
    DuePayments::Core.silence_stdout { start_by_initiatng_database }
    puts 'Database created and loaded ...'
  end

  context 'Creation' do
    context 'create_object Methods' do

      it 'create_object method must create an instance and return an Landlord type' do
        test_new_instance = Landlord.create_object()
        expect(test_new_instance).not_to be_nil
      end

      it 'create_object method must have predefined default value set' do
        test_new_instance = Landlord.create_object()
        expect(test_new_instance.id).to be_nil

        # Test default value

        expect(test_new_instance.firstname).to be_instance_of(String)
        expect(test_new_instance.lastname).to be_instance_of(String)
        expect(test_new_instance.email).to be_instance_of(String)
        expect(test_new_instance.zip_code).to be_instance_of(String)
        expect(test_new_instance.address).to be_instance_of(String)

        expect(test_new_instance.firstname).to be_empty
        expect(test_new_instance.lastname).to be_empty
        expect(test_new_instance.email).to be_empty
        expect(test_new_instance.zip_code).to be_empty
        expect(test_new_instance.address).to be_empty

      end

    end

    context 'create methods' do

      it 'create without argument must create an error' do
        expect { Landlord.create }.to raise_error
      end

      it 'create should raise error on email, firstname, lastname' do
        expect { 
          Landlord.create(firstname: 'last name')
        }.to raise_error
      end

      it 'create return an object' do
        new_object = Landlord.create(
          firstname: 'barry', lastname: 'allen',
          email: 'test@yopmail.com', zip_code: 'YHJ 7YH',
          address: '6, play machine'
        )
        expect(new_object).to be_instance_of(DuePayments::Landlord)
      end

    end

    context 'find' do
      it 'find methods => correct case : return one data' do
        new_object = Landlord.create(
          firstname: 'barry', lastname: 'alien', 
          email: 'test@yopmail.com', zip_code: 'YHJ 7YH',
          address: '6, play machine'
        )
        expect(new_object.id).not_to be_nil
        expect { Landlord.find(new_object.id) }.not_to raise_error
        object_to_test = Landlord.find(new_object.id)
        expect(object_to_test).to be_instance_of(DuePayments::Landlord)
        expect(object_to_test.id).to eq(new_object.id)
      end
    end

    context 'delete' do

      it 'delete an entry' do
        new_object = Landlord.create(
          firstname: 'barry', lastname: 'allen',
          email: 'test@yopmail.com', zip_code: 'YHJ 7YH',
          address: '6, play machine'
        )


        result = Landlord.delete(new_object.id)
        expect(result).not_to be_nil
        expect(result).to be_instance_of(DuePayments::Landlord)

        expect {
          Landlord.find(new_object.id)
        }.to raise_error(DuePayments::LandlordNotFoundException)

        expect {
          Landlord.find(new_object.id)
        }.to raise_error(DuePayments::Default.landlord_cant_be_find.message)

      end

    end

  end

  after :all do
    finish_by_delete_database
    puts 'Database deleted ...'
  end

end
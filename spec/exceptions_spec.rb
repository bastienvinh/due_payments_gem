require "spec_helper"
require 'autoload'

RSpec.describe "Exceptions handlings" do
  context "DuePayments::Exception" do
    
    context "General" do
      it "check default instance" do
        expect(DuePayments::Exception.new).to be_instance_of(DuePayments::Exception)

        expect { raise DuePayments::Exception.new }.to raise_error(DuePayments::Exception)
      end

      it "Check default message" do
        check_obj = DuePayments::Exception.new
        message = "Unknown errors ..."
        expect(check_obj.message).to eq(message)

        expect {
          raise check_obj
        }.to raise_error(message)
      end

      it "cant_create_instance methods" do
      
        message = "Can't create new instance"
        check_obj = DuePayments::Default.cant_create_instance
        expect(check_obj).to be_instance_of(DuePayments::Exception)
        expect(check_obj.message).to eq(message)
        expect { raise check_obj }.to raise_error(DuePayments::Exception)
        expect { raise check_obj }.to raise_error(message)

      end
    end

    context "Custom errors" do
      context "Landlords" do
        it "can't find landlord error" do
          
          # TODO : finish this error

          message = "Can't find landlord."
          check_obj = DuePayments::Default.landlord_cant_be_find
          expect(check_obj).to be_instance_of(DuePayments::Exception)
          expect(check_obj.message).to eq(message)
          expect { raise check_obj }.to raise_error(DuePayments::Exception)
          expect { raise check_obj }.to raise_error(message)

        end
      end
      
    end

  end
end
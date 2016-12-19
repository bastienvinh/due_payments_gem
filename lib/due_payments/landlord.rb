require 'securerandom'

LIB_ROOT = File.dirname(__FILE__)

require "#{LIB_ROOT}/dpm_landlords"
require "#{LIB_ROOT}/utils/object_utils"
require "#{LIB_ROOT}/identifier_module"

DPMLandlord = DuePayments::Data::DPMLandlord

class DuePayments::Landlord

  include DuePayments::Identifier

  # TODO : use contract

  @@create_id = SecureRandom.uuid

  attr_accessor :firstname, :lastname, :address, :zip_code, :phone_number, :email

  class << self
    
    def create(*opts)
      result = DuePayments::Landlord.new(@@create_id)
      # Get Active record data
      DuePayments::Utils::ObjectUtils::symbols_set_obj(result, *opts)


      # Insert into database
      DPMLandlord.create(*opts)

      return result
    end

    def all
      datas = DPMLandlord.all.map { |d| convertor(d) }
      return datas
    end

    def delete(id)

    end

    def delete(criteria)
      
    end

    def get(criteria)
    end

    private

    # Insert teh date into the database
    def create_data
      
    end

    def convertor(data)

      result = DuePayments::Landlord.new(@@create_id)
      result.firstname = data.firstname
      result.lastname = data.lastname
      result.address = data.address
      result.zip_code = data.zip_code
      result.phone_number = data.phone_number
      result.email = data.email
      result.id = data.id

      return result
    end

  end

  private
  def initialize(value)
    unless value == @@create_id
      raise "Can't create instance variable"
    end

    @firstname = ""
    @lastname = ""
    @address = ""
    @zip_code = ""
    @phone_number = ""
    @email = ""
    @id = nil

  end

end
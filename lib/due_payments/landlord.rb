require 'securerandom'

require "#{File.dirname(__FILE__)}/autoload"

DPMLandlord = DuePayments::Data::DPMLandlord

# TODO : implement more features ...

class DuePayments::Landlord

  include DuePayments::Identifier

  # TODO : use contract

  @@create_id = SecureRandom.uuid

  attr_accessor :firstname, :lastname, :address, :zip_code, :phone_number, :email

  class << self

    def create(*opts)
      # Insert into database
      begin
        result = convertor(DPMLandlord.create(*opts))
      rescue ActiveRecord::StatementInvalid
        raise DuePayments::Default.problem_with_properties
      rescue
        raise DuePayments::Default.unknown_error
      end
      result
    end

    def create_object
      result = DuePayments::Landlord.new(@@create_id)
      result
    end

    def all
      datas = DPMLandlord.all.map { |d| convertor(d) }
      datas
    end

    def delete(id)
      landlord = DPMLandlord.find(id)
      newResult = convertor(landlord)
      landlord.destroy
      newResult
    end
    
    def find_one(criteria)
      
    end

    # TODO : put a constract to integer only
    def find(id)

      begin
        # TODO : Improve this query because he cant take more than one result
        result = DPMLandlord.find(id)
      rescue
        raise DuePayments::Default::landlord_cant_be_find
      end
      
      return convertor( result )
    end

    def first(*criteria)
    end

    def delete_one(id)
      begin
        result = DPMLandlord.find(id)
        deleted_user = convertor(result)
        result.destroy
      rescue ActiveRecord::RecordNotFound
        raise DuePayments::Default::landlord_cant_be_find
      rescue => e
        raise DuePayments::Default.new("Unknown error : #{e.message}")
      end

      return deleted_user
    end

    private

    def convertor(data, has_id = true)

      result = DuePayments::Landlord.new(@@create_id)
      result.firstname = data.firstname
      result.lastname = data.lastname
      result.address = data.address
      result.zip_code = data.zip_code
      result.phone_number = data.phone_number
      result.email = data.email
      
      if has_id
        result.id = data.id
      end

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
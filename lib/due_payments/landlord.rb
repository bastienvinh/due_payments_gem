require 'securerandom'
require 'pp'

require "#{File.dirname(__FILE__)}/autoload"

DPMLandlord = DuePayments::Data::DPMLandlord

# TODO : implement more features ...

class DuePayments::Landlord

  include DuePayments::Identifier

  # TODO : use contract

  @@create_id = SecureRandom.uuid

  attr_accessor :firstname, :lastname, :address, :zip_code, :phone_number, :email
  attr_accessor :enable

  class << self

    def create(*opts)
      # Insert into database
      begin
        result = convertor(DPMLandlord.create(*opts))
      rescue ActiveRecord::StatementInvalid 
        raise DuePayments::Default.problem_with_properties
      rescue ActiveModel::UnknownAttributeError => ua
        excep = DuePayments::Default.attribute_doesnt_exists
        excep.attribute = ua.attribute
        raise excep
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

    # TODO : put a constract to integer only
    def find(id)

      begin
        # TODO : Improve this query because he cant take more than one result
        result = DPMLandlord.find(id)
      rescue
        raise DuePayments::Default::landlord_cant_be_find
      end

      convertor( result )
    end

    def first(*criteria); end


    def update_attribute(*opts); end

    def update(landlord)
      begin
        # TODO : add contract about landlord
        data = DPMLandlord.find(landlord.id)
        data.firstname = landlord.firstname
        data.lastname = landlord.lastname
        data.address = landlord.address
        data.zip_code = landlord.zip_code
        data.phone_number = landlord.phone_number
        data.email = landlord.email
        data.enable = landlord.enable
        has_saved = data.save
      rescue ActiveRecord::RecordNotFound
        raise DuePayments::Default.landlord_cant_be_find
      end
      has_saved
    end

    def delete_one(id)
      begin
        result = DPMLandlord.find(id)
        deleted_user = convertor(result)
        result.destroy
      rescue ActiveRecord::RecordNotFound
        raise DuePayments::Default.landlord_cant_be_find
      rescue
        raise DuePayments::Default.unknown_error
      end

      deleted_user
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
      result.enable = data.enable
      result.id = has_id ? data.id : nil
      result
    end

  end

  private
  def initialize(value)
    raise "Can't create instance variable" unless value == @@create_id

    @firstname = ''
    @lastname = ''
    @address = ''
    @zip_code = ''
    @phone_number = ''
    @email = ''
    @id = nil
    @enable = true

  end

end

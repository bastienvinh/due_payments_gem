require 'securerandom'

require "#{File.dirname(__FILE__)}/autoload"


DPMEstate = DuePayments::Data::DPMEstate

class DuePayments::Estate

  attr_accessor :name, :price_per_acre, :landlord_id, :acre, :zip_code, :address, :geolocalisation, :description, :total_price, :coordinate_points

  include DuePayments::Identifier

  @@create_id = SecureRandom.uuid

  class << self
  
    def create(*opts)
      begin
        # TODO : Add our custom errors
        result = convertor(DPMEstate.create(*opts))
      rescue ActiveModel::UnknownAttributeError
        raise DuePayments::Default::attribute_dont_exists
      end

      return result
    end

    def create_object
      result = DuePayments::Estate.new(@@create_id)
      return result
    end

    def all
      # TODO : manage connection errors and exceptions
      result = DPMEstate.all.map { |d| convertor(d) }
      return result
    end

    def find(id)
      begin
        result = convertor(DPMEstate.find(id))
      rescue ActiveRecord::RecordNotFound
        raise DuePayments::Default::estate_cant_be_found
      end

      result ||= create_object
      return result
    end

    def find_by_landord(id)
      result = DPMEstate.where(:landlord_id => id).all.map{ |d| convertor(d) }
      return result
    end

    private

    def convertor(data, has_id=true)
      result = DuePayments::Estate.new(@@create_id)
      result.name = data.name
      result.price_per_acre = data.price_per_acre
      result.landlord_id = data.landlord_id
      result.acre = data.acre
      result.zip_code = data.zip_code
      result.address = data.address
      result.geolocalisation = data.geolocalisation
      result.coordinate_points = data.coordinate_points
      result.description = data.description
      result.total_price = data.total_price
      result.id = nil

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

    @name = ""
    @price_per_acre = BigDecimal.new(0)
    @landlord_id = -1
    @acre = 0
    @zip_code = ""
    @address = ""
    @geolocalisation = ""
    @coordinate_points = ""
    @description = ""
    @total_price = BigDecimal.new(0)

  end

end
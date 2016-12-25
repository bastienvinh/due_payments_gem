module DuePayments::Identifier
  
  @id = nil
  attr_reader :id

  def id=(value)
    unless @id == nil
      raise "This is a read-only property. It can be assign once ..."
    end

    @id = value
  end

  
end
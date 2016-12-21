class DuePayments::Exception < StandardError
  def initialize(msg="Unknown errors ...")
    super
  end
end
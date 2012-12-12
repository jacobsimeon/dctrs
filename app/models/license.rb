class License
  attr_accessor :number, :state
  include Initializable
end

class NullLicense
  attr_accessor :number, :state
  def initialize
    @number = "-"
    @state = "-"
  end
end

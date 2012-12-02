class AuthorizedOfficial
  attr_accessor :title, :phone
  attr_reader :name
  include Initializable

  def name=(name_attributes)
    @name = Name.new(name_attributes)
  end
end

class IndividualName < ActiveRecord::Base
  attr_accessible :first, :last
  belongs_to :individual_provider, touch: true
  def to_s
    "#{first} #{last}"
  end
end

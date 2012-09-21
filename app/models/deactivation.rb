class Deactivation < ActiveRecord::Base
  attr_accessible :deactivated_on, :reactivated_on, :reason
end

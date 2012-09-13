class Specialty < ActiveRecord::Base
  belongs_to :provider
  belongs_to :taxonomy
end

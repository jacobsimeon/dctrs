class Specialty < ActiveRecord::Base
  belongs_to :provider
  belongs_to :taxonomy
  has_one :license
end

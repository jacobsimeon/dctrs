class Address < ActiveRecord::Base
  attr_accessible :city, :fax, :first_line, :phone, :second_line, :zip
end

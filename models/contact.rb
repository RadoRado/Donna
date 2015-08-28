class Contact < ActiveRecord::Base
  belongs_to :user
  has_many :ping_rules
end

class PingRule < ActiveRecord::Base
  has_many :pings, dependent: :destroy
end

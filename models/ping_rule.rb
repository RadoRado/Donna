# rubocop:disable Style/Documentation

class PingRule < ActiveRecord::Base
  has_many :pings, dependent: :destroy
  belongs_to :contact
  belongs_to :user
end

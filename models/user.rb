# rubocop:disable Style/Documentation

class User < ActiveRecord::Base
  has_many :contacts, dependent: :destroy
  has_many :ping_rules, dependent: :destroy

  def public_user
    {
      id: id,
      name: name,
      email: email
    }
  end
end

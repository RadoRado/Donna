class User < ActiveRecord::Base
  has_many :contacts, dependent: :destroy
  has_many :ping_rules, dependent: :destroy

  def public_user
    return {
      id: self.id,
      name: self.name,
      email: self.email
    }
  end
end

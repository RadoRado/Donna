class User < ActiveRecord::Base
  has_many :contacts, dependent: :destroy

  def public_user
    return {
      id: self.id,
      name: self.name,
      email: self.email
    }
  end
end

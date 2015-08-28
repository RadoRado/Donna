require 'sinatra/activerecord'

class User < ActiveRecord::Base
  def public_user
    return {
      id: self.id,
      name: self.name,
      email: self.email
    }
  end
end

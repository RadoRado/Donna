module DonnaClient
  module Models
    class User
      attr_reader :id, :name, :email

      def initialize(hash)
        @id = hash["id"] if hash.key? "id"
        @name = hash["name"] if hash.key? "name"
        @email = hash["email"] if hash.key? "email"
      end
    end
  end
end

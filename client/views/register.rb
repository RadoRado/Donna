module DonnaClient
  module Views
    class Register
      def take_control
        puts "In register view"
      end
    end
  end
end

DonnaClient::Views.register_view(:register, DonnaClient::Views::Register)

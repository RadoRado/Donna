# rubocop:disable Style/Documentation

require 'mustache'

module DonnaClient
  module Views
    class BaseView
      def render(templateDict)
        template_name =  self.class.name.demodulize.downcase
        template = File.read("templates/#{template_name}.mustache")

        Mustache.render(template, templateDict)
      end
    end
  end
end

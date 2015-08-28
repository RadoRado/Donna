# Holds the program state - like current user, configuration, session tokens, etc.

module DonnaClient
  module State
    extend self

    def [](key)
      @conf[key]
    end

    def conf=(configuration)
      @conf = configuration
    end
  end
end

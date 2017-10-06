require "thor"
require "resr"

module Resr
  class CLI < Thor

    desc 'take SERVER', 'Take ownership of the SERVER'
    def take(server)
      puts "Taking ownership of #{server}"
    end

    desc 'free SERVER', 'Free/release ownership of the SERVER'
    def free(server)
      puts "Releasing ownership of #{server}"
    end

    desc 'list', 'List all servers and who owns them'
    def list
      puts 'Listing servers and owners'
    end
  end

end

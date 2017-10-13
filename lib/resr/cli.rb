require "thor"
require "resr"

module Resr
  class CLI < Thor

    desc 'take SERVER', 'Take ownership of the SERVER'
    option aliases: :t
    def take(server, details = nil)
      details = `git rev-parse --abbrev-ref HEAD`.chomp if details.nil?
      say Resr.take(server, details: details)
    end

    desc 'free SERVER', 'Free/release ownership of the SERVER'
    option aliases: :f
    def free(server)
      Resr.free server
    end

    desc 'list', 'List all servers and who owns them'
    option aliases: :l
    def list
      channels = Resr.list
      channels.each do |channel|
        say channel.name, :yellow
        channel.servers.each do |server, details|
          if details
            say "  #{server}: #{details}"
          else
            say "  #{server}", :green
          end
        end
      end
    end
  end
end
require 'thor'
require 'resr'

module Resr
  class CLI < Thor
    map %w[--version -v] => :__print_version

    desc 'take SERVER [DESC]', 'Take ownership of the SERVER and set an optional description'
    long_desc <<-LONGDESC
      `resr free SERVER` will reserve SERVER using the current git branch name

      `resr free SERVER 'custom desc'` will reserve SERVER using 'custom desc'
    LONGDESC
    option aliases: :t
    def take(server, details = nil)
      details = `git rev-parse --abbrev-ref HEAD`.chomp if details.nil?
      response = Resr.take(server, details: details)

      if response.ok?
        say "Reserved #{server}"
      else
        say "Reservation failed: #{response.error}"
      end
    end

    desc 'free SERVER', 'Free/release ownership of the SERVER'
    option aliases: :f
    def free(server)
      response = Resr.free server

      if response.ok?
        say "Released #{server}"
      else
        say "Release failed: #{response.error}"
      end
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

    desc '--version, -v', 'Display the current version'
    def __print_version
      puts Resr::VERSION
    end
  end
end

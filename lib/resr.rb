require "resr/state"
require "resr/version"
require 'slack'
require 'yaml'

module Resr
  def self.list
    channels
  end

  def self.take(server, details: nil)
    channel = channels.find {|channel| channel.server? server}
    channel.set_details(server, details)
    channel.save
  end

  def self.free(server)
    channel = channels.find {|channel| channel.server? server}
    channel.set_details(server, nil)
    channel.save
  end

  private

  def self.channels
    @channels ||= config.dig('channels').map { |name, mappings| State.new(name, mappings, slack_client) }
  end

  def self.slack_token
    config.fetch('slack_token')
  end

  def self.config
    @config ||= YAML::load_file(File.join(Dir.home, '.resr.yml'))
  end

  def self.slack_client
    @slack_client ||=
      Slack.configure do |config|
        config.token = slack_token
      end
      Slack::Web::Client.new
  end
end

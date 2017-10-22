# frozen_string_literal: true

require 'resr/state'
require 'resr/version'
require 'slack'
require 'yaml'

module Resr
  DEFAULT_CONFIG = '.resr.yml'

  def self.list
    channels
  end

  def self.take(server, details: nil)
    channel = channels.find { |chnl| chnl.server? server }
    channel.set_details(server, details)
    channel.save
  end

  def self.free(server)
    channel = channels.find { |chnl| chnl.server? server }
    channel.set_details(server, nil)
    channel.save
  end

  def self.config
    @config ||= YAML.load_file(config_file_location)
  end

  private_class_method

  def self.config_file_location
    if ENV['RESR_CONFIG']
      expanded_file_location = File.absolute_path(ENV['RESR_CONFIG'])

      return expanded_file_location if File.file?(expanded_file_location)
      raise "Resr config not found at #{expanded_file_location}"
    end

    if File.file?(DEFAULT_CONFIG)
      DEFAULT_CONFIG
    elsif File.file?(File.join(Dir.home, DEFAULT_CONFIG))
      File.join(Dir.home, DEFAULT_CONFIG)
    else
      raise 'Resr config has not been found.'
    end
  end

  def self.channels
    @channels ||= config.dig('channels').map { |name, mappings| State.new(name, mappings, slack_client) }
  end

  def self.slack_token
    config.fetch('slack_token')
  end

  def self.slack_client
    @slack_client ||=
      Slack.configure do |config|
        config.token = slack_token
      end
    Slack::Web::Client.new
  end
end

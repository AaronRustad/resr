module Resr
  class State
    attr_accessor :name

    def initialize(name, mappings, client)
      @name = name
      @mappings = mappings
      @client = client
    end

    def server?(server)
      topic.key? server
    end

    def servers
      topic
    end

    def details(server)
      topic.fetch(server) { raise StandardError, "No such server: #{server}" }
    end

    def set_details(server, details)
      topic[server] = details
    end

    def to_s
      topic.to_s
    end

    def to_slack
      topic.map do |server, details|
        "#{slack_name(server)} #{details}"
      end.join(', ')
    end

    def save
      write_topic
    end

    private

    def channel_name
      "##{@name}"
    end

    def write_topic
      @client.channels_setTopic(channel: channel_name, topic: to_slack, as_user: true)
    end

    def topic
      @topic ||= parse_state(channel_topic)
    end

    def parse_state(state)
      state.split(',').each_with_object({}) do |server, memo|
        server_name, server_details = server.split(' ')
        memo[local_name(server_name)] = server_details
      end
    end

    def local_name(name)
      @mappings.key(name)
    end

    def slack_name(name)
      @mappings[name]
    end

    def channel_topic
      channel_info.channel.topic.value
    end

    def channel_info
      @client.channels_info(channel: channel_name, as_user: true)
    end
  end
end

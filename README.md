[![Gem Version](https://badge.fury.io/rb/resr.svg)](https://badge.fury.io/rb/resr)
[![Build Status](https://travis-ci.org/AaronRustad/resr.svg?branch=master)](https://travis-ci.org/AaronRustad/resr)

# Resr

A ridiculously simple way of managing soft-ownership of staging servers using Slack and channel topics for state.

## Installation

    $ gem install resr

## Setup

### Generate a legacy token in Slack

Visit the [Slack Legacy tokens](https://api.slack.com/custom-integrations/legacy-tokens) page and generate a token for your Workspace/User.

### Configure resr

Copy the following to `~/.resr.yml`, and add the token that was generated in the previous section.

```yml
slack_token: 'YOUR_LEGACY_SLACK_TOKEN'

channels:
  dev-deploy-io:         # Your Slack channel that manages state
    io: ':flag-io:'      # Mapping between the server console name and how
    cat: ':cat2:'        # it is represented in Slack. In this case,
    dog: ':trashdog:'    # as emoji.

  dev-deploys:
    prod: ':cat2:'
    canary: ':canary:'
```

## Usage

    Commands:
      resr --version, -v       # Display the current version
      resr free SERVER         # Free/release ownership of the SERVER
      resr help [COMMAND]      # Describe available commands or one specific command
      resr list                # List all servers and who owns them
      resr take SERVER [DESC]  # Take ownership of the SERVER and set an optional description

The command options `free`, `list`, and `take` are aliased as `f`, `l`, and `t` respectively.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/AaronRustad/resr.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

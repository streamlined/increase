# Increase

This is a simple wrapper for Increase.com's API. Refer to [documentation here](https://increase.com/documentation/api).

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add increase

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install increase

## Usage

```
@client = Increase::Client.new(api_base_url: "https://sandbox.increase.com", api_key: "...")
@client.get_all_accounts
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can then run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

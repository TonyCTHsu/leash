# Leash

![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/TonyCTHsu/leash/test.yml?style=for-the-badge&logo=github)

`Leash` provides a lightweight framework to implement "Do Nothing Scripting" with Ruby.

A "do nothing script" is a script that encodes instructions of a manual procedure and encapsulating each step in a function. Making it easier to start small and gradually increase the level of automation.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add leash

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install leash

## Usage

Define steps for your procedure by `Leash::Procedure#step`.

```ruby
require 'leash'

procedure = Leash::Procedure.new("My Procedure") do
  step "Creates a manual step, which only contains a description."

  step "Creates an automated step by providing a block, run: `bundle install`" do
    system("bundle install")
  end

  step "Or by passing a callable object as the second argument, run: `echo Hello!`", -> { system("echo Hello!") }
end

```

Execute the defined procedure by `Leash::Procedure#run`.

```ruby
# Executes each step by pressing `Enter`.
procedure.run
```

Render a text report by `Leash::Procedure#render`.

```ruby
# Renders a text report for the procedure
puts procedure.render

# > My Procedure
# > (1/3): Creates a manual step, which only contains a description.
# > (2/3): Creates an automated step by providing a block, run: `bundle install`
# > (3/3): Or by passing a callable object as the second argument, run: `echo Hello!`
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/TonyCTHsu/leash. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/TonyCTHsu/leash/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Leash project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/TonyCTHsu/leash/blob/master/CODE_OF_CONDUCT.md).

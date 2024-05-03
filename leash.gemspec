# frozen_string_literal: true

require_relative "lib/leash/version"

Gem::Specification.new do |spec|
  spec.name = "leash"
  spec.version = Leash::VERSION
  spec.authors = ["Tony Hsu"]
  spec.email = ["tonyc.t.hsu@gmail.com"]

  spec.summary = "Do Nothing Scripting with Ruby"
  spec.description = ~<<-DESC
    Leash provides a lightweight framework to implement "Do Nothing Scripting" with Ruby.

    A "do nothing script" is a script that encodes instructions of a manual procedure and encapsulates each step in a function.
    Making it easier to start small and gradually increase the level of automation.
  DESC
  spec.homepage = "https://github.com/TonyCTHsu/leash"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end

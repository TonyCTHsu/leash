# frozen_string_literal: true

module Leash
  class Procedure
    attr_reader :title, :options, :steps

    def initialize(title, options = {}, &block)
      @title = title
      @options = options
      @steps = []

      instance_eval(&block) if block
    end

    def step(description, action = nil, &block)
      steps << Step.new(
        description: description,
        action: action || block
      )
    end

    def run
      puts "Running: #{title}"

      steps.each_with_index do |step, index|
        puts("(#{index.next}/#{length}): #{step.description}")
        puts "> Press Enter to continue ..."
        $stdin.gets
        step.run
      end
    end

    def render
      text = +"#{title}\n"

      steps.each_with_index do |step, index|
        text << "(#{index.next}/#{length}): #{step.description}\n"
      end

      text
    end

    def length
      steps.length
    end
  end
end

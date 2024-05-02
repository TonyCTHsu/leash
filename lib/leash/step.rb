# frozen_string_literal: true

module Leash
  class Step
    attr_reader :description, :action

    def initialize(description:, action:)
      @description = description
      @action = action
    end

    def run
      action&.call
    end
  end
end

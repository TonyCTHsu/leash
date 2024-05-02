require "leash/step"

RSpec.describe Leash::Step do
  describe "#initialize" do
    it "sets the description" do
      step = described_class.new(description: "description", action: nil)
      expect(step.description).to eq("description")
    end

    it "sets the action" do
      action = double("action")
      step = described_class.new(description: nil, action: action)
      expect(step.action).to eq(action)
    end
  end

  describe "#run" do
    it "calls the action" do
      action = double("action")
      step = described_class.new(description: "description", action: action)
      expect(action).to receive(:call).with(no_args)
      step.run
    end

    it "does not raise an error if action is nil" do
      step = described_class.new(description: "description", action: nil)

      expect { step.run }.not_to raise_error
    end
  end
end

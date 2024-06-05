require "leash/procedure"

RSpec.describe Leash::Procedure do
  describe "#initialize" do
    it "creates a new instance of Procedure" do
      procedure = described_class.new("Test Procedure")

      expect(procedure).to be_an_instance_of(Leash::Procedure)
    end

    it "sets the title and options correctly" do
      procedure = described_class.new("Test Procedure", {option1: "value1", option2: "value2"})

      expect(procedure.title).to eq("Test Procedure")
      expect(procedure.options).to eq({option1: "value1", option2: "value2"})
    end

    it "initializes an empty steps array" do
      procedure = described_class.new("Test Procedure")

      expect(procedure.steps).to be_empty
    end

    it "evaluates the block if provided" do
      block_executed = false

      described_class.new("Test Procedure") do
        block_executed = true
      end

      expect(block_executed).to be true
    end

    it "instance_eval" do
      instance = nil

      procedure = described_class.new("Test Procedure") do
        instance = self
      end

      expect(instance).to equal(procedure)
    end
  end

  describe "#step" do
    let(:procedure) { described_class.new("Test Procedure") }

    it "adds a new step" do
      procedure.step("Step 1")

      expect(procedure.steps.length).to eq(1)

      step = procedure.steps[0]

      expect(step).to be_an_instance_of(Leash::Step)
      expect(step.description).to eq("Step 1")
      expect(step.action).to be_nil
    end

    it "adds a new step with an callable action" do
      procedure.step("Step 1", -> { puts "Executing Step 1" })

      expect(procedure.steps.length).to eq(1)

      step = procedure.steps[0]

      expect(step).to be_an_instance_of(Leash::Step)
      expect(step.description).to eq("Step 1")
      expect(step.action).to respond_to(:call)
    end

    it "adds a new step with a block" do
      procedure.step("Step 1") { puts "Executing Step 1" }

      expect(procedure.steps.length).to eq(1)

      step = procedure.steps[0]

      expect(step).to be_an_instance_of(Leash::Step)
      expect(step.description).to eq("Step 1")
      expect(step.action).to respond_to(:call)
    end
  end

  describe "#run" do
    let(:procedure) do
      described_class.new("Test Procedure") do
        step("Step 1") { puts "Executing Step 1" }
        step("Step 2", -> { puts "Executing Step 2" })
        step("Step 3")
      end
    end

    it "prints out each step" do
      allow($stdin).to receive(:gets)

      output = <<~OUTPUT
        Running: Test Procedure
        (1/3): Step 1
        > Press Enter to continue ...
        Executing Step 1
        (2/3): Step 2
        > Press Enter to continue ...
        Executing Step 2
        (3/3): Step 3
        > Press Enter to continue ...
      OUTPUT

      expect { procedure.run }.to output(output).to_stdout
    end

    it "executes each step" do
      allow($stdin).to receive(:gets)

      procedure.steps.each do |step|
        expect(step).to receive(:run).with(no_args).once
      end

      procedure.run
    end
  end

  describe "#render" do
    let(:procedure) do
      described_class.new("Test Procedure") do
        step("Step 1") { puts "Executing Step 1" }
        step("Step 2", -> { puts "Executing Step 2" })
        step("Step 3")
      end
    end

    it "returns a string representation of the procedure" do
      text = <<~OUTPUT
        Test Procedure
        (1/3): Step 1
        (2/3): Step 2
        (3/3): Step 3
      OUTPUT

      expect(procedure.render).to eq(text)
    end
  end
end

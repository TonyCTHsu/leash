# frozen_string_literal: true

# load rake tasks from tasks directory
Dir.glob(File.join(__dir__ || Dir.pwd, "tasks", "**", "*.rake")) { |f| import f }

task default: %i[spec]

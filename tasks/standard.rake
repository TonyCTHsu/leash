# frozen_string_literal: true

begin
  require "standard/rake"
rescue LoadError
  warn "'standard' gem not loaded: skipping tasks..."
  return
end

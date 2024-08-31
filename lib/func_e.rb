# frozen_string_literal: true

require 'terrapin'
require 'func_e/func'
require 'func_e/config'

# Path: lib/funcy.rb
module FuncE
  require 'railtie' if defined?(Rails)

  RUNNER_PATH = "#{File.expand_path(__dir__)}/func_e.js"

  def self.exec(func)
    JSON.parse line.run(path: func.path, payload: func.serialize_payload), symbolize_names: true
  rescue Terrapin::CommandLineError => e
    { error: 'An error occurred while executing the node function.', message: e.message }
  end

  def self.line
    Terrapin::CommandLine.new("node #{RUNNER_PATH}", '--path=:path --payload=:payload', logger: Logger.new($stdout))
  end
end

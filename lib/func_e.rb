# frozen_string_literal: true

require 'json'
require 'terrapin'

require 'func_e/http'
require 'func_e/func'
require 'func_e/config'

# Path: lib/funcy.rb
module FuncE
  require 'railtie' if defined?(Rails)

  RUNNER_PATH = "#{File.expand_path(__dir__)}/func_e_runner.js"
  SERVER_PATH = "#{File.expand_path(__dir__)}/func_e_server.js"

  def self.exec(func)
    Config.config.local_server ? server(func) : runner(func)
  end

  def self.server(func)
    json_parse FuncE::Http.post(func).body
  rescue Errno::ECONNREFUSED
    { error: 'The server is not running. Please start the server before executing functions.' }
  end

  def self.runner(func)
    json_parse line.run(path: func.path, payload: func.serialize_payload)
  rescue Terrapin::CommandLineError => e
    { error: 'An error occurred while executing the node function.', message: e.message }
  end

  def self.line
    Terrapin::CommandLine.new("node #{RUNNER_PATH}", '--path=:path --payload=:payload')
  end

  def self.json_parse(json)
    JSON.parse(json, symbolize_names: true)
  end
end

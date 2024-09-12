# frozen_string_literal: true

require 'func_e'

FuncE::Config.configure do |config|
  config.fn_dir_path = 'funcs'

  # If the tests are being run, do not start the server.
  unless ENV['RAILS_ENV'] == 'test'
    config.local_server = true
    config.local_server_port = 3031
  end
end

# frozen_string_literal: true

require './test/test_helper'

class ConfigServerTest < Minitest::Test
  def setup
    FuncE::Config.configure do |config|
      config.local_server = true
      config.local_server_port = 3031
    end

    # Server initialization usually takes a second or two. Sleep for a brief period of
    # time to ensure the server is up and running before any request is sent.
    sleep(1)
  end

  def test_function_call_to_server
    func = FuncE::Func.new('helloFn')

    func.set_payload({ planet: 'Earth' })

    assert FuncE.server(func)[:result] == "Hello, Earth!"
  end

  def teardown
    FuncE::Http.kill_server

    FuncE::Config.configure do |config|
      config.local_server = false
      config.local_server_port = nil
    end
  end
end

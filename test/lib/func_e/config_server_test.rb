# frozen_string_literal: true

require './test/test_helper'

class ConfigServerTest < Minitest::Test

  SAMPLE_PACKAGE_JSON = <<-EOF
    {
      "name": "Test",
      "version": "0.0.1",
      "dependencies": {
        "lodash": "^4.17.21"
      }
    }
  EOF

  LODASH_FN = <<-EOF
    const _ = require('lodash');
    module.exports = async function lodashFn({ data }) {
      return {
        result: _.sum(data)
      }
    }
  EOF

  def setup
    # Add a package.json file to the funcs directory.
    File.open("#{FuncE::Config.install_path}/package.json", 'w') { |f| f.write(SAMPLE_PACKAGE_JSON) }
    File.open("#{FuncE::Config.install_path}/lodashFn.js", 'w') { |f| f.write(LODASH_FN) }

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

  def test_function_call_to_server_with_dependency
    func = FuncE::Func.new('lodashFn')

    func.set_payload({ data: [1, 2, 3, 4, 5] })

    assert FuncE.server(func)[:result] == 15
  end

  def teardown
    FuncE::Http.kill_server

    File.delete("#{FuncE::Config.install_path}/lodashFn.js")
    File.delete("#{FuncE::Config.install_path}/package.json")
    File.delete("#{FuncE::Config.install_path}/package-lock.json")
    FileUtils.rm_rf("#{FuncE::Config.install_path}/node_modules")

    FuncE::Config.configure do |config|
      config.local_server = false
      config.local_server_port = nil
    end
  end
end

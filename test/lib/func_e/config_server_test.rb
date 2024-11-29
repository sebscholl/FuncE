# frozen_string_literal: true

require './test/test_helper'

class ConfigServerTest < Minitest::Test
  def setup
    # Run serve rake task to start the server.
    Thread.new { Rake::Task['func_e:serve'].invoke }
  end

  def test_function_call_to_server_with_dependency
    func = FuncE::Func.new('lodashFn')

    func.set_payload({ data: [1, 2, 3, 4, 5] })

    assert FuncE.server(func)[:result] == 15
  end

  def teardown
    FuncE::Server.kill
    
    FileUtils.rm_rf("#{FuncE::Config.install_path}/node_modules")
  end
end

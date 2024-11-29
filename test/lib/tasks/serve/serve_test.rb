# frozen_string_literal: true

require './test/test_helper'

class ServeTest < Minitest::Test
  def setup
    Thread.new { Rake::Task['func_e:serve'].invoke }

    while FuncE::Server.pid.nil?
      sleep 1
    end
  end

  def test_func_e_serve_enables_server
    assert FuncE::Config.config.server == true
  end

  def test_func_e_serve_starts_server
    assert FuncE::Server.pid.is_a?(Integer)
  end

  def teardown
    FuncE::Server.kill
  end
end

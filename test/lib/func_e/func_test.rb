# frozen_string_literal: true

require './test/test_helper'

class FuncTest < Minitest::Test
  def setup
    @func = FuncE::Func.new('helloFn')
  end

  def test_func_exists
    assert @func.exists?
  end

  def test_func_doesnt_exist
    refute FuncE::Func.new('nonexistent').exists?
  end

  def test_func_name
    assert_equal 'helloFn', @func.name
  end

  def test_func_path
    assert_equal FuncE::Config.install_path.join('helloFn.js'), @func.path
  end

  def test_func_run_returns_hash
    result = @func.run({ planet: 'world' })

    assert_equal result.class, Hash
    assert_equal result[:result], 'Hello, world!'
  end

  def test_func_run_returns_benchmarks
    @func.run({ planet: 'world' })

    assert @func.run_at.is_a?(Time)
    assert @func.run_time.is_a?(Float)
  end
end

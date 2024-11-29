# frozen_string_literal: true

require './test/test_helper'

class ConfigTest < Minitest::Test
  def test_config_configure_yeilds_config
    FuncE::Config.configure do |config|
      assert_equal FuncE::Config, config.class
    end
  end

  def test_config_default_port
    assert FuncE::Config::DEFAULT_PORT == 3030
  end

  def test_config_default_dir
    assert FuncE::Config::DEFAULT_DIR == 'funcs'
  end

  def test_config_default_server
    assert FuncE::Config::DEFAULT_SERVER == false
  end

  def test_config_dir
    assert FuncE::Config.instance.respond_to?(:dir=)
  end

  def test_config_port
    assert FuncE::Config.instance.respond_to?(:port=)
  end

  def test_config_server
    assert FuncE::Config.instance.respond_to?(:server=)
  end

  def test_config_install_path
    assert FuncE::Config.install_path.is_a?(Pathname)
  end

  def test_config_get
    assert_equal FuncE::Config.instance.dir, FuncE::Config.config.dir
  end
end

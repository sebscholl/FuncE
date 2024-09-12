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

  def test_config_default_install_dir
    assert FuncE::Config::DEFAULT_INSTALL_DIR == 'funcs'
  end

  def test_config_fn_dir_path
    assert FuncE::Config.instance.respond_to?(:fn_dir_path=)
  end

  def test_config_local_server
    assert FuncE::Config.instance.respond_to?(:local_server=)
  end

  def test_config_local_server_port
    assert FuncE::Config.instance.respond_to?(:local_server_port=)
  end

  def test_config_install_path
    assert FuncE::Config.install_path.is_a?(Pathname)
  end

  def test_config_get
    assert_equal FuncE::Config.instance.fn_dir_path, FuncE::Config.config.fn_dir_path
  end
end

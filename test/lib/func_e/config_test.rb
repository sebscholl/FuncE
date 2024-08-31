# frozen_string_literal: true

require './test/test_helper'

class ConfigTest < Minitest::Test
  def test_config_configure_yeilds_config
    FuncE::Config.configure do |config|
      assert_equal FuncE::Config, config.class
    end
  end

  def test_config_fn_dir_path
    assert FuncE::Config.instance.respond_to?(:fn_dir_path=)
  end

  def test_config_install_path
    assert FuncE::Config.install_path.is_a?(Pathname)
  end

  def test_config_get
    assert_equal FuncE::Config.instance.fn_dir_path, FuncE::Config.get(:fn_dir_path)
  end
end

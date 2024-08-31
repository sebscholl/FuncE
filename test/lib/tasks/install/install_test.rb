# frozen_string_literal: true

require './test/test_helper'

class InstallTest < Minitest::Test
  FUNC_DIR = FuncE::Config.install_path

  def setup
    FUNC_DIR.rmtree if FUNC_DIR.exist?

    Rake::Task['func_e:install'].invoke
  end

  def test_installs_func_e_directory
    assert Dir.exist?(FUNC_DIR)
    assert File.exist?(FUNC_DIR.join('helloFn.js'))
    assert File.exist?(FUNC_DIR.join('package.json'))
  end
end

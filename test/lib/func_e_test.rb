# frozen_string_literal: true

require './test/test_helper'

class FuncETest < Minitest::Test
  def test_runner_path_is_a_string
    assert FuncE::RUNNER_PATH.is_a?(String)
  end
end

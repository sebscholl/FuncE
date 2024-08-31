# frozen_string_literal: true

require 'rake'
require 'minitest/test_task'

# Build a test task for the test directory
Minitest::TestTask.create(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.warning = false
  t.test_globs = ['test/**/*_test.rb']
end

task default: :test

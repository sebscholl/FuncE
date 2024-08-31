# frozen_string_literal: true

require 'rake'
require 'func_e'
require 'minitest/test_task'

# Load all rake tasks from the lib/tasks directory
Dir.glob("./lib/tasks/**/*.rake").each { |f| import f }

# Build a test task for the test directory
Minitest::TestTask.create(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.warning = false
  t.test_globs = ['test/**/*_test.rb']
end

task default: :test

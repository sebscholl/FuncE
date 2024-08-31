# frozen_string_literal: true

# lib/railtie.rb
require 'func_e'
require 'rails'

module FuncE
  # This class is used to load rake tasks for the gem
  class Railtie < Rails::Railtie
    railtie_name :func_e

    rake_tasks do
      path = File.expand_path(__dir__)
      Dir.glob("#{path}/tasks/**/*.rake").each { |f| load f }
    end
  end
end

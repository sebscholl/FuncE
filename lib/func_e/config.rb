# frozen_string_literal: true

require 'singleton'

# Path: func_e/lib/func_e/config.rb
module FuncE
  # Singleton class for configuring FuncE.
  class Config
    include Singleton

    attr_accessor :fn_dir_path

    def self.configure
      yield instance

      @fn_dir_path = 'funcs' if @fn_dir_path.nil?
    end

    def self.config
      instance
    end

    def self.get(key)
      instance.send(key)
    end

    def self.install_path
      defined?(Rails) ? Rails.root.join(@fn_dir_path) : Bundler.root.join(@fn_dir_path)
    end
  end
end

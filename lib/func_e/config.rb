# frozen_string_literal: true

require 'singleton'

# Path: func_e/lib/func_e/config.rb
module FuncE
  # Singleton class for configuring FuncE.
  class Config
    include Singleton

    DEFAULT_INSTALL_DIR = 'funcs'

    attr_accessor :fn_dir_path

    def self.configure
      yield instance
    end

    def self.config
      instance
    end

    def self.get(key)
      instance.send(key)
    end

    def self.install_path
      if defined?(Rails)
        Rails.root.join(@fn_dir_path || DEFAULT_INSTALL_DIR)
      elsif defined?(Bundler)
        Bundler.root.join(@fn_dir_path || DEFAULT_INSTALL_DIR)
      else
        Pathname.new(Dir.pwd).join(@fn_dir_path || DEFAULT_INSTALL_DIR)
      end
    end
  end
end

# frozen_string_literal: true

require 'singleton'

# Path: func_e/lib/func_e/config.rb
module FuncE
  # Singleton class for configuring FuncE.
  class Config
    include Singleton

    DEFAULT_PORT = 3030
    DEFAULT_DIR = 'funcs'
    DEFAULT_SERVER = false

    attr_accessor :dir, :port, :server

    def self.configure
      yield instance
      
      # Set default values if they are not set.
      instance.dir ||= DEFAULT_DIR
      instance.port ||= DEFAULT_PORT
      instance.server ||= DEFAULT_SERVER
    end

    def self.config
      instance
    end

    def self.install_path
      if defined?(Rails)
        Rails.root.join(config.dir)
      elsif defined?(Bundler)
        Bundler.root.join(config.dir)
      else
        Pathname.new(Dir.pwd).join(config.dir)
      end
    end

    def self.has_dependencies?
      File.exist?("#{install_path}/package.json")
    end

    def self.npm_install
      system("cd #{install_path} && npm i && cd #{`pwd`.strip}") if has_dependencies?
    end
  end
end

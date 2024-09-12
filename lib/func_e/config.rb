# frozen_string_literal: true

require 'singleton'

# Path: func_e/lib/func_e/config.rb
module FuncE
  # Singleton class for configuring FuncE.
  class Config
    include Singleton

    DEFAULT_PORT = 3030
    DEFAULT_INSTALL_DIR = 'funcs'

    attr_accessor :fn_dir_path, :local_server, :local_server_port

    def self.configure
      yield instance
      
      # Set default values if they are not set.
      instance.local_server ||= false
      instance.local_server_port ||= DEFAULT_PORT
      instance.fn_dir_path ||= DEFAULT_INSTALL_DIR

      # Start the server if the local_server option is set to true.
      FuncE::Http.start_server if instance.local_server
    end

    def self.config
      instance
    end

    def self.install_path
      if defined?(Rails)
        Rails.root.join(config.fn_dir_path)
      elsif defined?(Bundler)
        Bundler.root.join(config.fn_dir_path)
      else
        Pathname.new(Dir.pwd).join(config.fn_dir_path)
      end
    end
  end
end

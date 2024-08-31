# frozen_string_literal: true

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
  end
end

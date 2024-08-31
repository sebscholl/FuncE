# frozen_string_literal: true

module FuncE
  # Represents a function that can be executed.
  class Func
    attr_reader :name, :result, :payload, :run_at, :run_time

    def initialize(name)
      @name = name
      @path = path
    end

    def path
      FuncE::Config.install_path.join("#{@name}.js")
    end

    def run(payload)
      @payload = payload

      benchmark do
        @result = FuncE.exec(self)
      end

      @result
    end

    def serialize_payload
      @payload.to_json
    end

    def exists?
      File.exist?(@path)
    end

    private

    def benchmark
      @run_at = Time.current
      yield
      @run_time = Time.current - @run_at
    end
  end
end

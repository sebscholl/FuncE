require 'net/http'

module FuncE
  module Server
    def self.uri
      URI("http://localhost:#{FuncE::Config.config.port}")
    end

    def self.headers
      { 'Content-Type': 'application/json' }
    end

    def self.post(func)
      Net::HTTP.post(uri, { name: func.name, payload: func.payload }.to_json, headers)
    end

    def self.kill
      pid.tap { |n| system("kill -9 #{n}") unless n.zero? }

      Config.config.server = false
    end
    
    def self.start
      system("node #{FuncE::SERVER_PATH} --port=#{Config.config.port} --functions_path=#{Config.install_path}")

      Config.config.server = true
    end

    def self.pid
      `lsof -i:#{Config.config.port} -t`.to_i
    end

    def self.running?
      pid != 0
    end
  end
end
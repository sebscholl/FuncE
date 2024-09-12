require 'net/http'

module FuncE
  module Http
    def self.uri
      URI("http://localhost:#{FuncE::Config.config.local_server_port}")
    end

    def self.headers
      { 'Content-Type': 'application/json' }
    end

    def self.active_pid
      `lsof -i:#{Config.config.local_server_port} -t`.to_i
    end

    def self.post(func)
      Net::HTTP.post(uri, { name: func.name, payload: func.payload }.to_json, headers)
    end

    def self.start_server
      kill_server
      
      Thread.new {
        system("node #{FuncE::SERVER_PATH} --port=#{Config.config.local_server_port} --functions_path=#{Config.install_path}")
      }
    end

    def self.kill_server
      active_pid.tap { |pid| system("kill -9 #{pid}") unless pid.zero? }
    end
  end
end
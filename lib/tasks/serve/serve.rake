# frozen_string_literal: true

namespace :func_e do
  desc 'Start the func_e server'
  task :serve, [:port, :dir] do
    FuncE::Config.configure do |config|
      config.dir = ENV['dir']
      config.port = ENV['port']
    end

    FuncE::Config.npm_install
    FuncE::Server.start
  end

  desc 'Restart the func_e server'
  task :restart do
    FuncE::Server.kill
    FuncE::Server.start
  end
end

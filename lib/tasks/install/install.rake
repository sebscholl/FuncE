# frozen_string_literal: true

namespace :func_e do
  desc 'Install func_e by generating the functions directory to the root of your project'

  task :install do
    template = Pathname.new(__dir__).join('template')
    FileUtils.cp_r "#{template}/.", FuncE::Config.install_path
  end
end

# frozen_string_literal: true

namespace :func_e do
  desc 'Install func_e by generating the functions directory to the root of your project'

  task :install do
    puts 'Installing FuncE...'

    Dir.mkdir('func_b')
    template = Pathname.new(__dir__).join('template')
    FileUtils.cp_r("#{template}/.", 'func_b', verbose: true)
  end
end

# -*- encoding : utf-8 -*-
# bundle exec unicorn_rails -c config/unicorn.rb -D

rails_env = ENV['RAILS_ENV'] || 'production'
worker_processes (rails_env == 'production' ? 4 : 2)

APP_PATH = "/srv/projects/sho"
TMP_PATH = File.join(APP_PATH, 'tmp')

timeout 90

working_directory APP_PATH
listen "#{TMP_PATH}/unicorn.sock"
pid "#{TMP_PATH}/unicorn.pid"
stderr_path "#{APP_PATH}/log/unicorn.log"
stdout_path "#{APP_PATH}/log/unicorn.log"

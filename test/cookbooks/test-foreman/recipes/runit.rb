#
# Cookbook Name:: test-foreman
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

file ::File.join(app_root, '.env') do
  contents "AA=BB\nCC=DD"
end

file ::File.join(app_root, 'Procfile') do
  contents 'test: run_my_command'
end

directory '/tmp/test/foreman' do
  recursive true
end

user 'deploy'

foreman_export 'my_app' do
  format :upstart
  concurrency 'test' => 3
  log '/tmp/log'
  port 9000
  user 'deploy'
  root app_root
  env ::File.join(app_root, '.env')
  procfile ::File.join(app_root, 'Procfile'
  pid_dir ::File.join(app_root)
  location '/tmp/test/foreman'
end

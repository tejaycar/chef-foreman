# encoding: utf-8
#
# Cookbook Name:: foreman
# Provider:: export
#
# Author:: Tejay Cardon <Tejay.cardon@gmail.com>
#
# Copyright 2013, Tejay Cardon
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
require 'fileutils'
include Chef::Mixin::ShellOut

def whyrun_supported?
  true
end

use_inline_resources

action :run do
  tmp_dir = ::File.join(Chef::Config[:file_cache_path], 'foreman')
  format = new_resource.format.to_s
  location = new_resource.location

  opts = {}
  opts[:app] = new_resource.app
  opts[:concurrency] = new_resource.concurrency.map{ |name, value| "#{name}=#{value}" }.join(',') if new_resource.concurrency
  opts[:log] = new_resource.log if new_resource.log
  opts[:port] = new_resource.port if new_resource.port
  opts[:template] = new_resource.template if new_resource.template
  opts[:user] = new_resource.template if new_resource.template
  opts[:root] = new_resource.root if new_resource.root
  opts[:env] = (new_resource.env.kind_of?(Array) ? new_resource.env.join(',') : new_resource.env) if new_resource.env
  opts[:run] = new_resource.procfile if new_resource.procfile
  opts[:run] = new_resource.run if new_resource.run

  install_gem('foreman', node[:foreman][:version], node[:foreman][:gem_source])
  begin
    require 'foreman/cli'
  rescue LoadError
    fail "Missing the 'foreman' gem.  Use the 'foreman::default' recipe to install it first"
  end

  FileUtils.rm_rf tmp_dir
  FileUtils.mkdir_p tmp_dir

  Dir.chdir(new_resource.root) do
    Foreman::CLI.new([format, tmp_dir], opts).invoke(:export, [format, tmp_dir])
  end

  create_or_replace tmp_dir, location
end

def create_or_replace(tmp_dir, destination)
  ::Dir.foreach(tmp_dir) do |file_name|
    next if file_name == '.' || file_name == '..'
    puts ::File.join(tmp_dir,file_name)
    tmp_path = ::File.join(tmp_dir, file_name)
    if ::File.file? tmp_path
      file ::File.join(destination, file_name) do
        content IO.read(tmp_path)
        owner new_resource.user if new_resource.user
      end
    elsif ::File.directory? tmp_path
      directory ::File.join(destination, file_name) do
        owner new_resource.user if new_resource.user
      end
      create_or_replace(tmp_path, ::File.join(destination, file_name))
    end
  end
end
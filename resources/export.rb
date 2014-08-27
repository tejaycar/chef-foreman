# encoding: utf-8
#
# Cookbook Name:: foreman
# Resource:: default
#
# Author:: Tejay Cardon (<tejay.cardon@gmail.com>)
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

actions :run # TODO: add a delete or remove action later (lots of branching logic for that on a per 'format' basis
default_action :run

attribute :app, :kind_of => String, :name_attribute => true
attribute :format, :kind_of => Symbol, :required => true,
  :equal_to => [:bluepill, :inittab, :launchd, :runit, :supervisord, :systemd, :upstart]
attribute :concurrency, :kind_of => Hash
attribute :log, :kind_of => String
attribute :port, :kind_of => [String, Fixnum]
attribute :template, :kind_of => String # TODO:  Add hash later to allow me to generate the file
attribute :user, :kind_of => String
attribute :root, :kind_of => String, :required => true
attribute :env, :kind_of => [String, Array]
attribute :procfile, :kind_of =>  String  # TODO: Add hash later to allow me to generate the file
attribute :run, :kind_of => String # odd name for a pid file path
attribute :pid_dir, :kind_of => String # better name for a pid file path
attribute :location, :kind_of => String, :required => true
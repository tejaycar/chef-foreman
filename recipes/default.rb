chef_gem 'foreman' do
  version node[:foreman][:version]
  source  node[:foreman][:gem_source] if node[:foreman][:gem_source]
  action :install
end

require 'foreman'
require 'foreman/cli'
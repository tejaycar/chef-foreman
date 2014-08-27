def install_gem(gem, version, source="http://rubygems.org")
  gem_installer = Chef::Resource::ChefGem.new(gem, run_context)
  gem_installer.version version if version
  gem_installer.options "--clear-sources --source #{source}"
  gem_installer.action :install
  gem_installer.after_created

  require gem
end

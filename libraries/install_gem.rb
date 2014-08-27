def install_gem(gem, version, source="http://rubygems.org")
#   begin
#     Gem::Specification.find_by_name(gem, version)
#   rescue Gem::LoadError
#     ::Chef::Log.info("missing #{gem} gem. installing ....")
#     require 'rubygems/dependency_installer'
#     Gem::DependencyInstaller.new(Gem::DependencyInstaller::DEFAULT_OPTIONS).install(gem, version)
#   end
#   Gem.clear_paths
# end


  gem_installer = Chef::Resource::ChefGem.new(gem, run_context)
  gem_installer.version version if version
  gem_installer.options "--clear-sources --source #{source}"
  gem_installer.action :install
  gem_installer.run_action :install
  puts 'ran it'
  gem_installer.after_created
end

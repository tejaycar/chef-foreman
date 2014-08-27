require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.platform = 'ubuntu'
  config.version = '12.04'

  config.color = true

  config.log_level = :fatal

  config.order = 'random'
end

at_exit { ChefSpec::Coverage.report! }

# Load the Rails application.
require_relative "application"

set_env = File.join(Rails.root, 'config', 'set_env.rb')
load(set_env) if File.exist?(set_env)
# Initialize the Rails application.
Rails.application.initialize!

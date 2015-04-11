require 'stacked_config'

require 'private_deploy/version'
require 'private_deploy/custom_config'
require 'private_deploy/bundler_patch'

module PrivateDeploy

  def self.config
    @private_deploy_config ||= CustomConfig.new
    @private_deploy_config
  end

end


module Bundler
  class GemHelper
    def rubygem_push(path)
      raise 'Undefined gem deployment target server' unless  PrivateDeploy.config[PrivateDeploy::GEM_PRIVATE_DEPLOYMENT_VARIABLE]
      gem_server_url = PrivateDeploy.config[PrivateDeploy::GEM_PRIVATE_DEPLOYMENT_VARIABLE]
      sh("gem inabox '#{path}' --host #{gem_server_url}")
      Bundler.ui.confirm "Pushed #{name} #{version} to #{gem_server_url}"
    end
  end
end
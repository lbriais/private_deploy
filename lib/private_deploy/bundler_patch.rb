module Bundler
  class GemHelper
    def rubygem_push(path)
      raise 'Undefined gem deployment target server' unless  PrivateDeploy.config[PrivateDeploy::CustomConfig::ENV_VARIABLES_FILTER]
      gem_server_url = PrivateDeploy.config[PrivateDeploy::CustomConfig::ENV_VARIABLES_FILTER]
      sh("gem inabox '#{path}' --host #{gem_server_url}")
      Bundler.ui.confirm "#{name} (version #{version}) has been correctly pushed to #{gem_server_url}"
    end
  end
end
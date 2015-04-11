
module Bundler
  class GemHelper
    def rubygem_push(path)
      raise 'Undefined gem deployment target server' unless  EasyAppHelper.config[:private_gem_server]
      gem_server_url = EasyAppHelper.config[:private_gem_server]
      sh("gem inabox '#{path}' --host #{gem_server_url}")
      Bundler.ui.confirm "Pushed #{name} #{version} to #{gem_server_url}"
    end
  end
end
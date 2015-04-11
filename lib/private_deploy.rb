require 'stacked_config'

require 'private_deploy/version'
require 'private_deploy/bundler_patch'

module PrivateDeploy

  CONFIG_FILE_BASENAME = 'gem_private_deploy'
  GEM_PRIVATE_DEPLOYMENT_VARIABLE = 'gem_private_deployment_url'

  def self.config
    @private_deploy_config ||= setup_conf
    @private_deploy_config
  end

  private

  def self.setup_conf
    manager = SuperStack::Manager.new
    manager.extend StackedConfig::ProgramDescriptionHelper
    manager.config_file_base_name = CONFIG_FILE_BASENAME
    # The Gem level
    gem_layer = setup_layer manager, StackedConfig::Layers::GemLayer, :gem, 30
    gem_layer.gem_name = CONFIG_FILE_BASENAME
    # The global level
    setup_layer manager, StackedConfig::Layers::GlobalLayer, :global, 40
    # The user level
    setup_layer manager, StackedConfig::Layers::UserLayer, :user, 50
    # The environment level
    env_layer = setup_layer manager, StackedConfig::Layers::EnvLayer, :env, 60
    env_layer.filter = GEM_PRIVATE_DEPLOYMENT_VARIABLE

    # The layer to write something
    override_layer = setup_layer manager, SuperStack::Layer, 'Overridden configuration level', 1000
    manager.write_layer = override_layer
    manager.reload_layers
    raise "Gem config file not found for Gem: #{gem_layer.gem_name}" if gem_layer.file_name.nil?
    manager
  end


  def self.setup_layer(manager, class_type, name, priority)
    layer = class_type.new
    layer.name = name
    layer.priority = priority
    manager << layer
    layer
  end

end

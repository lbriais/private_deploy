module PrivateDeploy

  class CustomConfig < SuperStack::Manager

    CONFIG_FILE_BASENAME = 'gem_private_deploy'
    ENV_VARIABLES_FILTER = 'gem_private_deployment_url'

    include StackedConfig::ProgramDescriptionHelper

    attr_reader :system_layer, :global_layer, :executable_gem_layer, :user_layer, :env_layer

    def initialize
      super
      self.merge_policy = SuperStack::MergePolicies::FullMergePolicy
      self.config_file_base_name = CONFIG_FILE_BASENAME
      setup_layers
    end


    private

    def setup_layers
      # The system level
      @system_layer = setup_layer StackedConfig::Layers::SystemLayer, 'System-wide configuration level', 10

      # The executable gem level
      @executable_gem_layer = setup_layer StackedConfig::Layers::ExecutableGemLayer, 'Gem associated to the executable running configuration level', 20

      # The global level
      @global_layer = setup_layer StackedConfig::Layers::GlobalLayer, 'Global configuration level', 40

      # The user level
      @user_layer = setup_layer StackedConfig::Layers::UserLayer, 'User configuration level', 50

      # The layer to write something
      override_layer = setup_layer SuperStack::Layer, 'Overridden configuration level', 1000
      self.write_layer = override_layer

      include_env_layer ENV_VARIABLES_FILTER
      include_gem_layer_for CONFIG_FILE_BASENAME

    ensure
      reload_layers
    end

    def setup_layer(class_type, name, priority)
      layer = class_type.new
      layer.name = name
      layer.priority = priority
      self << layer
      layer
    end

    def include_env_layer(filter = nil, priority = 70)
      @env_layer = StackedConfig::Layers::EnvLayer.new filter
      env_layer.name = 'Environment variables level'
      env_layer.priority = priority
      self << env_layer
    end

    def include_gem_layer_for(gem_name, priority = 30)
      gem_layer  = StackedConfig::Layers::GemLayer.new
      gem_layer.gem_name = gem_name
      raise "No config found in gem #{gem_name}" if gem_layer.file_name.nil?
      gem_layer.name = "#{gem_name} Gem configuration level"
      gem_layer.priority = priority
      self << gem_layer
    end

  end

end
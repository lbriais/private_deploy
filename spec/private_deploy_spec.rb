require 'spec_helper'

describe PrivateDeploy do

  subject {
    gem_path = File.expand_path '../..', __FILE__
    allow(StackedConfig::Layers::GemLayer).to receive(:gem_config_root) {File.join(gem_path, 'spec', 'tst_data') }
    described_class
  }

  it 'should provide a config mechanism' do
    expect(subject.config).to be_a_kind_of SuperStack::Manager
  end

  it 'should always have a url specified in the config' do
    expect(subject.config[]).not_to be_empty
    expect(subject.config[subject::GEM_PRIVATE_DEPLOYMENT_VARIABLE]).not_to be_nil
  end


end

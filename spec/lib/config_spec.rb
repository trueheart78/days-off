# frozen_string_literal: true

require 'spec_helper'
require 'config'

RSpec.describe Config do
  before do
    described_class.instance.load_config_file fixture_config_path
  end
  subject { described_class.instance }

  context 'valid?' do
    it { is_expected.to be_valid }
  end

  def project_path
    File.expand_path '.'
  end

  def spec_path
    File.join project_path, 'spec'
  end

  def fixture_path
    File.join spec_path, 'fixtures'
  end

  def fixture_config_path(type = :default)
    File.join fixture_path, 'config', "#{type}.yml"
  end
end

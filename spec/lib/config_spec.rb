# frozen_string_literal: true
require 'spec_helper'
require 'config'

RSpec.describe Config do
  subject { described_class.instance }

  it { is_expected.to be_valid }
end

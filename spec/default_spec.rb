# -*- coding: utf-8 -*-

require_relative 'spec_helper'

describe 'zookeeper::default' do
  subject { ChefSpec::ServerRunner.new.converge(described_recipe) }

  it 'does includes recipes' do
    expect(subject).to include_recipe('apt')
  end
end

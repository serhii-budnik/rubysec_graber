# typed: false
# frozen_string_literal: true

require 'rails_helper'

describe Operations::Advisories::Sync, '#call' do
  before(:all) do
    path_to_yml = 'spec/fixtures/files/gems/activerecord/CVE-2016-6317.yml'
    yaml_hash = YAML.load_file(path_to_yml).symbolize_keys
    @advisory_adapter = RubysecAdapter.new(**yaml_hash, filepath: path_to_yml)
  end

  subject do
    described_class.new.call(advisory_adapter: @advisory_adapter)
  end

  shared_examples 'a synchronized record' do |advisories_before_invocation|
    it 'should sync one and return object' do
      expect(Advisory.count).to eq(advisories_before_invocation)

      outcome = subject
      adv = outcome.success

      expect(outcome).to be_success
      expect(adv).to be_an(Advisory)
      expect(adv.attributes.slice(AdvisoryAdapter::MEMBERS)).to include(
        @advisory_adapter.to_h.slice(AdvisoryAdapter::MEMBERS)
      )
      expect(Advisory.count).to eq(1)
    end
  end

  context 'when a record does not exist' do
    it_should_behave_like 'a synchronized record', 0
  end

  context 'when a record changed' do
    let!(:advisory) do
      create(:advisory, identifier: @advisory_adapter.identifier)
    end

    it_should_behave_like 'a synchronized record', 1
  end

  context 'when a record has not changed' do
    let!(:advisory) do
      create(:advisory, **@advisory_adapter.to_fhash)
    end

    it 'returns nil' do
      expect(Advisory.count).to eq(1)
      expect(advisory.attributes.slice(AdvisoryAdapter::MEMBERS)).not_to include(
        @advisory_adapter.to_h.slice(AdvisoryAdapter::MEMBERS)
      )

      outcome = subject

      expect(outcome).to be_success
      expect(outcome.success).to be_nil
      expect(advisory).to be_an(Advisory)
      expect(advisory.attributes.slice(AdvisoryAdapter::MEMBERS)).to include(
        @advisory_adapter.to_h.slice(AdvisoryAdapter::MEMBERS)
      )
      expect(Advisory.count).to eq(1)
    end
  end
end

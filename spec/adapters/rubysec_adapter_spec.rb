# typed: false
# frozen_string_literal: true

require 'rails_helper'

describe RubysecAdapter do
  let(:path_to_yml) do
    'spec/fixtures/files/gems/activerecord/CVE-2016-6317.yml'
  end
  let(:yaml_hash) { YAML.load_file(path_to_yml).symbolize_keys }

  describe '.read_file' do
    context 'when given correct file_path' do
      it 'returns an object with initialized attributes' do
        object = described_class.read_file(path_to_yml)

        expect(object).to be_a(described_class)
        expect(object.to_h).to include(
          yaml_hash.slice(*AdvisoryAdapter::MEMBERS)
        )
      end
    end

    context 'when given incorrect file_path' do
      it 'raises Errno::ENOENT' do
        expect do
          described_class.read_file('file.incorrect')
        end.to raise_error(Errno::ENOENT)
      end
    end
  end

  describe '#identifier' do
    context 'when given correct file_path' do
      it 'returns string concatenated with gem name and cve' do
        advisory_adapter =
          described_class.new(filepath: path_to_yml, **yaml_hash)

        identifier = "#{advisory_adapter.gem}-"\
                     "#{advisory_adapter.osvdb ? 'OSVDB' : 'CVE'}-" \
                     "#{advisory_adapter.cve}"
        expect(advisory_adapter.identifier).to eq(identifier)
      end
    end

    context 'when given incorrect file_path' do
      it 'raises NoMethodError' do
        obj1 = described_class.new(filepath: 'root\file')
        obj2 = described_class.new(filepath: nil)
        obj3 = described_class.new(filepath: 'file_name.yml')
        expect { obj1.identifier }.to raise_error(NoMethodError)
        expect { obj2.identifier }.to raise_error(NoMethodError)
        expect { obj3.identifier }.to raise_error(NoMethodError)
      end
    end
  end

  describe '#to_fhash' do
    context 'when the adapter has a filepath attribute' do
      it 'returns hash with a "file_name" attr and without "filepath"' do
        advisory_adapter = described_class.new(filepath: path_to_yml)
        advisory_memebers = AdvisoryAdapter::MEMBERS.dup.push(:identifier)
        advisory_memebers.delete(:filepath)

        expect(advisory_adapter.to_fhash.keys).to include(*advisory_memebers)
      end
    end

    context 'when the adapter hasnot a filepath attribute' do
      it 'returns hash with a  attr and without "filepath"' do
        advisory_adapter = described_class.new({})

        expect { advisory_adapter.to_fhash }.to raise_error(NoMethodError)
      end
    end
  end
end

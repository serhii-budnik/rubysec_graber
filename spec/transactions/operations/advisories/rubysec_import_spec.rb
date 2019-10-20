# frozen_string_literal: true

require 'rails_helper'

describe Operations::Advisories::RubysecImport, '#call' do
  context "when advisories don't exist" do
    it 'returns imported advisories' do
      expect(Advisory.count).to be_zero

      stub_const("#{described_class}::REPO_PATH", 'spec/fixtures/files')
      allow_any_instance_of(GitHandler).to receive(
        :fetch_and_update_repo!
      ).and_return(true)

      outcome = described_class.new.call
      advisories = outcome.success

      expect(outcome).to be_success
      expect(advisories).to have_exactly(1).items
      expect(Advisory.count).to eq(1)
    end
  end

  context 'when a repository does not found' do
    it 'returns failure message' do
      allow_any_instance_of(GitHandler).to receive(
        :fetch_and_update_repo!
      ).and_raise(
        GitHandler::Error.new(
          'fatal: not a git repository (or any of the parent directories): .git'
        )
      )

      outcome = described_class.new.call

      expect(outcome).to be_failure
      expect(outcome.failure).to eq(
        '/home/serhii/projects/rubysec_graber/spec/transactions/operations' \
        '/advisories/rubysec_import_spec.rb - something went wrong ' \
        'processing: fatal: not a git repository (or any of the parent ' \
        'directories): .git'
      )
    end
  end
end

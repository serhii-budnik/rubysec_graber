# frozen_string_literal: true

require 'rails_helper'

describe GitHandler do
  let(:allow_open3_receive_capture2e_fatal) do
    allow(Open3).to receive(:capture2e).and_return(
      ['fatal: not a git repository', OpenStruct.new(success?: false)]
    )
  end
  let(:allow_open3_receive_capture2e) do
    allow(Open3).to receive(
      :capture2e
    ).and_return(['Already up to date.', OpenStruct.new(success?: true)])
  end
  let(:allow_file_utils_receive_mkdir_p) do
    allow(FileUtils).to receive(
      :mkdir_p
    ).and_return(true)
  end

  subject do
    described_class.new(
      'https://github.com/rubysec/ruby-advisory-db.git', local_path
    ).fetch_and_update_repo!
  end

  context 'when a repository already cloned' do
    let(:local_path) { 'tmp' }

    it 'should pull changes from a repository' do
      allow_open3_receive_capture2e

      expect(subject).to eq('Already up to date.')
    end
  end

  context 'when a repository is not cloned' do
    let(:local_path) { 'tmp/rubysec' }

    it 'should clone a repository' do
      allow_file_utils_receive_mkdir_p
      allow_open3_receive_capture2e

      expect(subject).to eq('Already up to date.')
    end
  end

  context 'when a folder is not a git repository' do
    let(:local_path) { 'tmp' }

    it 'raises GitHandler::Error' do
      allow_open3_receive_capture2e_fatal

      expect { subject }.to raise_error(GitHandler::Error)
    end
  end
end

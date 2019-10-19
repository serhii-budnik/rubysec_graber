# frozen_string_literal: true

module Operations::Advisories
  class RubysecImport
    include Dry::Transaction::Operation

    REPO_URL = 'https://github.com/rubysec/ruby-advisory-db.git'
    REPO_PATH = 'tmp/importers/rubysec'

    def call
      init_vars

      update_local_store.bind do
        all_advisories =
          raw_advisories.lazy.map { |ra| RubysecAdapter.read_file(ra) }
        sync_advisories(all_advisories)
      end
    end

    private

    attr_reader :new_advisories

    def init_vars
      @new_advisories = []
    end

    def local_repo_path
      @local_repo_path ||= File.join(Rails.root, REPO_PATH)
    end

    def update_local_store
      git = GitHandler.new(REPO_URL, local_repo_path)
      git.fetch_and_update_repo!
      Success(true)
    rescue GitHandler::Error => exception
      Failure(exception.message)
    end

    def raw_advisories
      @raw_advisories ||= Dir[File.join(local_repo_path, 'gems', '**', '**yml')]
    end

    def sync_advisories(all_advisories)
      all_advisories.each do |advisory_adapter|
        advisories_sync = Operations::Advisories::Sync.new
        advisory =
          advisories_sync.call(advisory_adapter: advisory_adapter).success

        new_advisories.push(advisory) if advisory
      end

      Success(new_advisories)
    end
  end
end

# frozen_string_literal: true

module Operations::Advisories
  # Synchronize a record. Create if does not exist or update an existing one
  class Sync
    include Dry::Transaction::Operation

    def call(input)
      init_attributes(input)

      process_advisories
    end

    private

    attr_reader :advisory_adapter, :advisory_hash_adapter

    def init_attributes(input)
      @advisory_adapter = input[:advisory_adapter]
      @advisory_hash_adapter = advisory_adapter.to_fhash
    end

    def current_advisory
      @current_advisory ||=
        Advisory.find_by(identifier: advisory_adapter.identifier)
    end

    # TODO: add create and validate operations for advisories
    def process_advisories
      if current_advisory
        current_advisory.assign_attributes(advisory_hash_adapter)
        return Success(nil) unless current_advisory.changed?

        return Success(current_advisory.tap(&:save!))
      end

      Success(Advisory.create!(advisory_hash_adapter))
    end
  end
end

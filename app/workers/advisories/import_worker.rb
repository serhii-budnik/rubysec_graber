# typed: true
# frozen_string_literal: true

module Advisories
  class ImportWorker
    include Sidekiq::Worker

    def perform
      Advisories::Import.new.call do |outcome|
        outcome.success do |result|
          p result
        end

        outcome.failure do |message|
          raise message
        end
      end
    end
  end
end

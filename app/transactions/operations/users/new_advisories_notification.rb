# frozen_string_literal: true

module Operations::Users
  class NewAdvisoriesNotification
    include Dry::Transaction::Operation

    def call(input)
      @advisories = input

      notify_users_via_emails
      Success(advisories)
    end

    private

    attr_reader :advisories

    def notify_users_via_emails
      AdvisoryMailer.new_advisories(advisories.map(&:id)).deliver_later
    end
  end
end

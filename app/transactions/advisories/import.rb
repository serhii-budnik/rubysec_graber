# frozen_string_literal: true

module Advisories
  class Import
    include Dry::Transaction(container: Container)

    step :rubysec_import, with: 'advisories.rubysec_import'
    # step :new_advisories_notification, with: 'users.new_advisories_notification'
  end
end
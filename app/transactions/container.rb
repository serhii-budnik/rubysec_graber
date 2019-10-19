# frozen_string_literal: true

class Container
  extend Dry::Container::Mixin

  namespace 'advisories' do
    register 'rubysec_import' do
      Operations::Advisories::RubysecImport.new
    end
  end

  namespace 'users' do
    register 'new_advisories_notification' do
      Operations::Users::NewAdvisoriesNotification.new
    end
  end
end

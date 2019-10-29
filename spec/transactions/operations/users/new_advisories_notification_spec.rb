# typed: false
# frozen_string_literal: true

require 'rails_helper'

describe Operations::Users::NewAdvisoriesNotification, '#call' do
  let(:advisory) { create(:advisory) }
  let!(:user) { create(:user, created_at: Time.current) }

  context 'when going to notify users about an advisory' do
    it 'should send email' do
      stub_request(:post, 'https://api.telegram.org/bot/sendMessage').to_return(
        body: %({"ok":true, "result":{"message_id":13,"author_signature":"RubysecBot",
                "chat":{"id":-1001301260856, "title":"Rubysec Advisories",
                "username":"rubysec_advisories", "type":"channel"},
                "date":1571616860, "text":"test message"}}),
        status: 200
      )

      Sidekiq::Testing.inline! do
        described_class.new.call([advisory])

        email = ActionMailer::Base.deliveries.first

        expect(ActionMailer::Base.deliveries.count).to eq(1)
        expect(email.to).to be_nil
        expect(email.body).to include(
          "<a href=\"#{advisory.url}\">#{advisory.gem} / #{advisory.title}</a>"
        )
      end
    end
  end
end

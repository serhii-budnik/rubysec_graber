# frozen_string_literal: true

require 'rails_helper'

describe Operations::Users::NewAdvisoriesNotification, '#call' do
  let(:advisory) { create(:advisory) }

  context 'when going to notify users about an advisory' do
    it 'should send email' do
      Sidekiq::Testing.inline! do
        described_class.new.call([advisory])

        email = ActionMailer::Base.deliveries.first

        expect(email.to).to eq(['serhii.budnik@gmail.com'])
        expect(email.body).to include(
          "<a href=\"#{advisory.url}\">#{advisory.gem} / #{advisory.title}</a>"
        )
      end
    end
  end
end

# frozen_string_literal: true

module Operations::Users
  class NewAdvisoriesNotification
    include Dry::Transaction::Operation

    def call(input)
      @advisories = input

      return Success([]) if advisories.blank?

      notify_users_via_emails
      notify_users_via_telegram

      Success(advisories)
    end

    private

    attr_reader :advisories

    def notify_users_via_emails
      User.confirmed.pluck(:email).each_slice(100).to_a.each do |emails|
        AdvisoryMailer.new_advisories(
          advisories.map(&:id), emails
        ).deliver_later
      end
    end

    def notify_users_via_telegram
      Telegram.bot.send_message(
        chat_id: TELEGRAM_CHAT_ID, text: telegram_message, parse_mode: 'HTML'
      )
    end

    def telegram_message
      advisories.map do |ad|
        "#{ad.gem} - <a href=\"#{ad.url}\">#{ad.title}</a>"
      end.join("\n")
    end
  end
end

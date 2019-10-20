# frozen_string_literal: true

TELEGRAM_CHAT_ID = -1_001_301_260_856

Telegram.bots_config = {
  default: ENV['TELEGRAM_BOT_TOKEN']
}

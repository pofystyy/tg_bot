require 'active_support'
require 'active_support/core_ext'
require 'telegram/bot'
require 'byebug'
require 'dotenv'
Dotenv.load

class SimpleNumberSumatorBot

TOKEN       = ENV['TELEGRAM_API_TOKEN']
DESCRIPTION = "Bot calculates the sum of numbers.\nImportant: Write numbers using a space.\nFor example: 9 6 1"

  def initialize
    Telegram::Bot::Client.run(TOKEN) do |bot|
      bot.listen do |message|
        bot.api.send_message(
          chat_id: message.chat.id,
          text: (
                  case message.text
                  when '/description'
                    DESCRIPTION
                  else
                    response(message.text)
                  end
                )
        )        
      end
    end
  end

  private

  def response(message)
    message = message.split
    if present_not_a_number?(message)
      'Incorrect Data'
    else
      sum_for(message)
    end
  end

  def present_not_a_number?(array)
    array.find { |i| false if Float(i) rescue true }
  end

  def sum_for(array)
    array.map(&:to_f).sum
  end
end


require 'rest-client'
require 'telegram_bot'
require 'json'

# monkeypatched some error thing. don't look too close
class TelegramBot::ApiResponse::ResponseError < StandardError
  attr_reader :response

  def initialize(res)
    @response = res
  end

  def data
    @data ||= begin
                JSON.parse(response.body)
              rescue JSON::ParserError
                { error_code: response.status, error_message: response.reason_phrase }
              end
  end
end

class Chat
  ZUKUNFTCHAT = TelegramBot::Channel.new(id: -1_001_645_342_432) # zukunft supergroup
  KLINGELGRUPPE = TelegramBot::Channel.new(id: -1_001_149_902_183)
  DINGDONGGRUPPE = TelegramBot::Channel.new(id: -4_052_388_495)
  ERROR_CHAT = TelegramBot::Channel.new(id: -229_011_980) # fake gruppe

  def initialize(token:)
    @token = token
    @bot = TelegramBot.new(token: @token)
  end

  def get_updates
    begin
      @bot.get_updates(fail_silently: true) do |message|
        yield message
      end
    rescue StandardError => e
      send_message e.to_s, to: ERROR_CHAT, parse_mode: nil
      send_message e.backtrace.join("\n").to_s, to: ERROR_CHAT, parse_mode: nil
      retry
    end
  end

  def send_gif(url, to: ZUKUNFTCHAT)
    @bot.send(:request, :sendAnimation, animation: url, chat_id: to.id)
  end

  def send_file(file, to: ZUKUNFTCHAT)
    # Bot.send(:request, :sendFile, document: File.open(file, 'r'), chat_id: ZUKUNFTCHAT.id)
    url = "https://api.telegram.org/bot#{@token}/sendDocument"
    response = RestClient.post(url, chat_id: to.id, document: File.open(file, 'r'))
  end

  def send_random_gif(topic, to = ZUKUNFTCHAT)
    send_gif(random_gif_url(topic), to: to)
  rescue StandardError => _e
    nil
  end

  def send_message(text, to: ZUKUNFTCHAT, parse_mode: 'markdown', reply_keyboard: nil)
    o = TelegramBot::OutMessage.new
    o.chat = to
    o.parse_mode = parse_mode
    o.text = text
    o.reply_markup = reply_keyboard
    o.send_with(@bot)
  end

  def user_mention(name, id)
    "[#{name}](tg://user?id=#{id})"
  end

  def telegram_user(user)
    TelegramBot::User.new(id: user.telegram_id, first_name: user.name)
  end

  # send one user which weekly task it is. send to group if contacting is
  # impossible
  def notify_task(task:)
    begin
      text = "Hi! This week it's your turn to do #{task.room.name}. 👍"
      send_message(text, to: telegram_user(task.user))
      send_message(task.room.description, to: telegram_user(task.user)) if !task.room.description.nil? && !task.room.description != ''
    rescue TelegramBot::ApiResponse::ResponseError
      text = "Hi #{user_mention(task.user.name, task.user.telegram_id)}! This week it's your turn to do #{task.room.name}. Also please chat me up, so i can send you direct messages"
      send_message(text)
    end
  end

  private
  def random_gif_url(topic)
    a = JSON.parse(RestClient.get("http://api.giphy.com/v1/gifs/random?api_key=l2k8R5Y94uU0zZjH2jCEndQe38ReWO7F&tag=#{topic}").body)
    a['data']['images']['fixed_height']['url']
  end
end

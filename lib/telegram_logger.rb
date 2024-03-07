class TelegramLogger < ActiveSupport::Logger
  attr_accessor :telegram_log_level

  def initialize(chat)
    @chat = chat
    self.telegram_log_level = Logger::ERROR
    super("log/#{Rails.env}.log") # hacky
  end

  def add(severity, message = nil, progname = nil, &block)
    return true if severity < level

    if severity >= telegram_log_level
      message = (message || (block && block.call) || progname).to_s
      @chat.send_message(message, to: Chat::ERROR_CHAT)
    end

    super
  end
end

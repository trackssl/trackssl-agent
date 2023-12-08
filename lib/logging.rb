module Logging
  delegate :warn, :info, :error, to: :logger

  def logger
    @logger ||= Logger.new(STDOUT)
  end

end

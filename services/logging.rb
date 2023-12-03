# frozen_string_literal: true

module Logging
  def self.logger(output_location: nil, level: nil)
    @logger ||= Logger.new(output_location, level:)
  end

  def self.log(msg:, level:)
    logger.debug(msg)
  end
end

# frozen_string_literal: true

require 'logger'
require 'json'

module Logging
  DEFAULT_LOG_FILE = './logs/logs.txt'

  def self.logger(output_location: DEFAULT_LOG_FILE)
    @logger ||= Logger.new(output_location, formatter:)
  end

  def self.log(msg)
    logger.info(**msg)
  end

  def self.formatter
    proc do |_severity, datetime, _progname, msg|
      date_format = datetime.strftime('%Y-%m-%d %H:%M:%S')
      JSON.dump({
                  date: date_format.to_s,
                  pid: "##{Process.pid}",
                  user: Process.uid,
                  process_name: $PROGRAM_NAME,
                  **msg
                }) + "\n"
    end
  end
end

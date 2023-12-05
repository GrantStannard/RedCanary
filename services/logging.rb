# frozen_string_literal: true

require 'logger'
require 'json'

module Logging
  def self.logger(output_location: "./log.json", level: nil)
    @logger ||= Logger.new(output_location, formatter:)
  end

  def self.log_process(process: {})
    logger.info({ process: })
  end

  def self.log_file(activity:, file_path:)
    logger.info({ activity:, file_path: })
  end

  def self.log_network(address:, port:, data_size:)
    logger.info({ address:, port:, data_size: })

  end

  def self.formatter
    proc do |severity, datetime, _progname, msg|
      date_format = datetime.strftime("%Y-%m-%d %H:%M:%S")
      JSON.dump({
                  date: "#{date_format}",
                 severity:"#{severity.ljust(5)}",
                 pid:"##{Process.pid}",
                 user: Process.uid,
                 process_name: $PROGRAM_NAME,
                  **msg}) + "\n"
    end
  end
end

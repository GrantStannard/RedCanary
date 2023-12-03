# frozen_string_literal: true

require 'zeitwerk'
require 'logger'

loader = Zeitwerk::Loader.new
loader.push_dir('./services')
loader.setup
module RedCanary
  file_location = ARGV[0]
  Logging.logger(output_location: file_location, level: Logger::DEBUG)
  Logging.log(msg: 'testing', level: Logger::DEBUG)

  # grab file
  # for each command in file
  #   log the start and the information about who started it
  #   do the action
  #   log the end time and results (if needed)
end

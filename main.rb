# frozen_string_literal: true

require 'zeitwerk'
require 'logger'

loader = Zeitwerk::Loader.new
loader.push_dir('./services')
loader.setup
module RedCanary
  file_location = ARGV[0] || './log.txt'

  Logging.logger(output_location: file_location)

  Command.create_file(file: './test.txt')
end

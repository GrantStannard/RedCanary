# frozen_string_literal: true

require 'zeitwerk'
require 'logger'

# Autoloads so I don't have to `require` in the files.
# This is the entry point to the application, so I chose to put this here.
loader = Zeitwerk::Loader.new
loader.push_dir('./services')
loader.setup

module RedCanary
  COMMAND_FILE_NAME = './test.txt'
  DEFAULT_LOG_FILE = './logs/logs.txt'

  def self.run(file_location: DEFAULT_LOG_FILE)
    Logging.logger(output_location: file_location)

    Command.create_file(file: COMMAND_FILE_NAME)

    Command.modify_file(file: COMMAND_FILE_NAME)

    Command.delete_file(file: COMMAND_FILE_NAME)

    Command.send_data(address: 'https://httpbin.org/anything', body: 'penguins')

    Command.run_process(cmd: 'ls')
  end
end

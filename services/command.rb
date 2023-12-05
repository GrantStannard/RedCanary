# frozen_string_literal: true

require 'open3'
require 'uri'
require 'net/http'
class Command
  def self.run_process(cmd:, args: [])
    Logging.log({ process: "#{cmd} #{args.join(' ')}" })

    Open3.capture3("#{cmd} #{args.join(' ')}")
  end

  def self.create_file(file:)
    File.open(file, 'w+').close
    Logging.log({ file_path: File.expand_path(file), activity: 'File Creation' })
  end

  def self.modify_file(file:)
    File.open(file, 'w+') do |open_file|
      open_file.write('updating this file')
    end
    Logging.log({ file_path: File.expand_path(file), activity: 'File Modification' })
  end

  def self.delete_file(file:)
    return unless File.exist?(file)

    File.delete(file)
    Logging.log({ file_path: File.expand_path(file), activity: 'File Deletion' })
  end

  def self.send_data(address:, body:)
    uri = URI(address)
    res = Net::HTTP.post(uri, "#{body}")
    return unless res.is_a?(Net::HTTPSuccess)

    Logging.log({ address:, port: uri.port, data_size: body.bytesize })
    res.body
  end
end

# frozen_string_literal: true

class ProcessFile
  def self.process(file_name:)
    File.foreach(file_name).with_index do |line, line_num|
      puts "#{line_num + 1}: #{line}"
    end
  end
end

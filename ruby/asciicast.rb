# Original code by Copyright (c) 2011-2012 Marcin Kulik
# Imported from https://github.com/sickill/asciinema.org
# Code license MIT, see MIT.txt for details
# Adjustments made by Tobias Pfeiffer, 2014
class Asciicast

  attr_accessor :duration, :terminal_columns, :terminal_lines
  attr_reader   :stdout_data_path, :stdout_timing_path

  def initialize(stdout_data_path, stdout_timing_path, meta_data_path)
    @stdout_data_path   = stdout_data_path
    @stdout_timing_path = stdout_timing_path
    @meta_data_path     = meta_data_path
    read_meta_data meta_data_path
  end

  def stdout
    @stdout ||= BufferedStdout.new(stdout_data_path, stdout_timing_path).lazy
  end

  def with_terminal
    terminal = Terminal.new(terminal_columns, terminal_lines)
    yield(terminal)
  ensure
    terminal.release if terminal
  end

  def snapshot=(snap)
    puts snap.class
    File.write('snapshot', snap.as_json)
  end

  def stdout_frames=(stdout_file)
    File.write('stdout_frames', stdout_file.open.read)
  end

  def read_meta_data(meta_data_path)
    data = Yajl::Parser.parse File.read(meta_data_path)
    terminal_data         = data['term']
    self.terminal_lines   = terminal_data['lines']
    self.terminal_columns = terminal_data['columns']
    self.duration         = data['duration']
  end
end

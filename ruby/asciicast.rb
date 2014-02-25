class Asciicast

  def stdout
    @stdout ||= BufferedStdout.new(stdout_data.decompressed_path,
                                   stdout_timing.decompressed_path).lazy
  end

  def with_terminal
    terminal = Terminal.new(terminal_columns, terminal_lines)
    yield(terminal)
  ensure
    terminal.release if terminal
  end
end

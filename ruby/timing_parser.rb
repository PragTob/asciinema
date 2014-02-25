# Original code by Copyright (c) 2011-2012 Marcin Kulik
# Imported from https://github.com/sickill/asciinema.org
# Code license MIT, see MIT.txt for details

class TimingParser

  def self.parse(data)
    data.lines.map { |line| parse_line(line) }
  end

  def self.parse_line(line)
    delay, size = line.split
    [delay.to_f, size.to_i]
  end

end

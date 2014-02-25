# Original code by Copyright (c) 2011-2012 Marcin Kulik
# Imported from https://github.com/sickill/asciinema.org
# Code license MIT, see MIT.txt for details

require 'tempfile'

class AsciicastFramesFileUpdater

  def initialize(file_writer = JsonFileWriter.new)
    @file_writer = file_writer
  end

  def update(asciicast)
    file = Tempfile.new('frames')

    asciicast.with_terminal do |terminal|
      film = Film.new(asciicast.stdout, terminal)
      file_writer.write_enumerable(file, film.frames)
    end

    asciicast.stdout_frames = file
  ensure
    file.unlink if file
  end

  private

  attr_reader :file_writer

end

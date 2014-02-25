# Original code by Copyright (c) 2011-2012 Marcin Kulik
# Imported from https://github.com/sickill/asciinema.org
# Code license MIT, see MIT.txt for details

class FrameDiffList
  include Enumerable

  def initialize(frames)
    @frames = frames
  end

  def each(&block)
    frame_diffs.each &block
  end

  private

  attr_reader :frames

  def frame_diffs
    previous_frame = nil

    frames.map { |delay, frame|
      diff = frame.diff(previous_frame)
      previous_frame = frame
      [delay, diff]
    }
  end

end

# Original code by Copyright (c) 2011-2012 Marcin Kulik
# Imported from https://github.com/sickill/asciinema.org
# Code license MIT, see MIT.txt for details

class AsciicastProcessor

  def process(asciicast)
    AsciicastSnapshotUpdater.new.update(asciicast)
    AsciicastFramesFileUpdater.new.update(asciicast)
  end

end

# Original code by Copyright (c) 2011-2012 Marcin Kulik
# Imported from https://github.com/sickill/asciinema.org
# Code license MIT, see MIT.txt for details

class AsciicastSnapshotUpdater

  def update(asciicast, at_seconds = asciicast.duration / 2)
    snapshot = generate_snapshot(asciicast, at_seconds)
    asciicast.snapshot = snapshot
  end

  private

  def generate_snapshot(asciicast, at_seconds)
    asciicast.with_terminal do |terminal|
      Film.new(asciicast.stdout, terminal).snapshot_at(at_seconds)
    end
  end

end

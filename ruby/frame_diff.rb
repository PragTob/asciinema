# Original code by Copyright (c) 2011-2012 Marcin Kulik
# Imported from https://github.com/sickill/asciinema.org
# Code license MIT, see MIT.txt for details

class FrameDiff

  def initialize(line_changes, cursor_changes)
    @line_changes = line_changes
    @cursor_changes = cursor_changes
  end

  def as_json(*)
    json = {}
    json[:lines] = line_changes unless line_changes.blank?
    json[:cursor] = cursor_changes unless cursor_changes.blank?

    json
  end

  private

  attr_reader :line_changes, :cursor_changes

end

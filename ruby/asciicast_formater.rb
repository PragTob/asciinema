require 'json'
require 'open3'
require 'yajl'
require 'active_model_serializers'
require 'active_support/all'

# fed up, dunno where this method comes from, implement it myself
class Array
  def as_json(*)
    map &:as_json
  end
end

require_relative 'stdout'


require_relative 'asciicast'
require_relative 'asciicast_frames_file_updater'
require_relative 'asciicast_processor'
require_relative 'asciicast_snapshot_updater'
require_relative 'brush'
require_relative 'buffered_stdout'
require_relative 'cell'
require_relative 'cursor'
require_relative 'film'
require_relative 'frame'
require_relative 'frame_diff'
require_relative 'frame_diff_list'
require_relative 'grid'
require_relative 'json_file_writer'
require_relative 'snapshot'
require_relative 'terminal'
require_relative 'timing_parser'

directory = ARGV.first
asciicast = Asciicast.new directory + '/stdout_data',
                          directory + '/stdout_timing',
                          directory + '/meta_data'
AsciicastProcessor.new.process asciicast

require_relative 'stdout'
require 'delegate'


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

















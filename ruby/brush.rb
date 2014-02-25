# Original code by Copyright (c) 2011-2012 Marcin Kulik
# Imported from https://github.com/sickill/asciinema.org
# Code license MIT, see MIT.txt for details

class Brush

  ALLOWED_ATTRIBUTES = [:fg, :bg, :bold, :underline, :inverse, :blink]
  DEFAULT_FG_CODE = 7
  DEFAULT_BG_CODE = 0

  def initialize(attributes = {})
    @attributes = symbolize_keys attributes
  end

  def symbolize_keys(hash)
    hash.inject({}) do |new_hash, (key,value)|
      new_hash[key.to_sym] = value
      new_hash
    end
  end

  def ==(other)
    fg == other.fg &&
      bg == other.bg &&
      bold? == other.bold? &&
      underline? == other.underline? &&
      blink? == other.blink?
  end

  def fg
    inverse? ? bg_code || DEFAULT_BG_CODE : fg_code
  end

  def bg
    inverse? ? fg_code || DEFAULT_FG_CODE : bg_code
  end

  def bold?
    !!attributes[:bold]
  end

  def underline?
    !!attributes[:underline]
  end

  def inverse?
    !!attributes[:inverse]
  end

  def blink?
    !!attributes[:blink]
  end

  def default?
    fg.nil? && bg.nil? && !bold? && !underline? && !inverse? && !blink?
  end

  def as_json(*)
    attributes.slice(*ALLOWED_ATTRIBUTES)
  end

  protected

  attr_reader :attributes

  private

  def fg_code
    calculate_code(:fg, bold?)
  end

  def bg_code
    calculate_code(:bg, blink?)
  end

  def calculate_code(attr_name, strong)
    code = attributes[attr_name]

    if code
      if code < 8 && strong
        code += 8
      end
    end

    code
  end

end

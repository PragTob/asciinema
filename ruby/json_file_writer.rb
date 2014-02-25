# Original code by Copyright (c) 2011-2012 Marcin Kulik
# Imported from https://github.com/sickill/asciinema.org
# Code license MIT, see MIT.txt for details

class JsonFileWriter

  def write_enumerable(file, array)
    first = true
    file << '['

    array.each do |item|
      if first
        first = false
      else
        file << ','
      end

      file << item.to_json
    end

    file << ']'
    file.close
  end

end

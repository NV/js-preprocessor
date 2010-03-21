class JSPP

  INCLUDE = %r{/\*>\s*(.+?)\s*\*/}
  INCLUDE_INSIDE_STRING = %r{"#{INCLUDE.source}"}

  def parse text='', base_dir='.'
    text.gsub!(INCLUDE_INSIDE_STRING) {
      file, dir = get_file $1, base_dir
      parsed = parse file, dir
      '"' << parsed.gsub(/$/, '\\').chop << '"'
    }
    text.gsub!(INCLUDE) {
      file, dir = get_file $1, base_dir
      parse file, dir
    }
    text
  end

  def get_file path, base_dir='.'
    if path.index'http://' or path.index'https://'
      require 'open-uri'
      file = open(path).read
      dir = File.dirname path
    else
      full_path = File.join base_dir, path
      file = File.read full_path
      dir = File.dirname full_path
    end
    [file, dir]
  end

end

module Kernel
  def JSPP path
    text = File.read path
    base_dir = File.dirname path
    JSPP.new.parse text, base_dir
  end
  private :JSPP
end
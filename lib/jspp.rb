require 'open-uri'

class JSPP

  INCLUDE = %r{/\*>\s*(.+?)\s*\*/}
  INCLUDE_INSIDE_STRING = %r{"#{INCLUDE.source}"}

  def initialize path
    @path = path
  end
  
  attr_accessor :path, :file, :children

  def read
    if uri? @path
      open(@path).read
    else
      File.read @path
    end
  end

  def tree
    @file = read
    @children = @file.scan(INCLUDE).inject([]) {|all, p|
      p = from_here_to(p) unless uri?(p.first)
      all << self.class.new(p).tree
    }
    self
  end

  def build
    
  end

  def to_s
    @path
  end

  def self.uri? p
    p.index'http://' or p.index'https://'
  end

  def from_here_to suffix
    File.join dirname, suffix
  end

  def dirname
    File.dirname @path
  end

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
require 'helper'

describe JSPP do

  describe '::INCLUDE' do
    it 'matches files' do
      JSPP::INCLUDE.match('/*> path_to/my_file.js */')[1].should == 'path_to/my_file.js'
    end
    it 'matches URIs' do
      JSPP::INCLUDE.match('/*> http://elv1s.ru/x/pets.txt */')[1].should == 'http://elv1s.ru/x/pets.txt'
    end
  end

  describe '::INCLUDE_INSIDE_STRING' do
    it 'matches local files inside strings' do
      JSPP::INCLUDE_INSIDE_STRING.match('"/*> path_to/my_file.js */"')[1].should == 'path_to/my_file.js'
    end
    it 'matches URIs inside strings' do
      JSPP::INCLUDE_INSIDE_STRING.match('"/*> http://elv1s.ru/x/pets.txt */"')[1].should == 'http://elv1s.ru/x/pets.txt'
    end
  end

  describe '#parse' do
    it 'include files' do
      file = File.read(EXAMPLE + '/main.js')
      JSPP.new.parse(file, EXAMPLE).should == <<-result
var my_script;

var style = "html, body {margin:0; padding:0}\\
.i-am-child {}\\
.my-style {background: #fffacc}\\
";
      result
    end
    it 'returns same text if no /*> file */ was found' do
      JSPP.new.parse(PETS).should == PETS
    end
  end

  describe '#get_file' do
    it 'fetches URI' do
      JSPP.new.get_file(PETS_URL).first.should == PETS
    end
    it 'reads file' do
      main_js = EXAMPLE + '/main.js'
      JSPP.new.get_file(main_js, '/').first.should == File.read(main_js)
    end
  end

end


describe Kernel, '#JSPP' do
  it 'do all the stuff' do
    JSPP(EXAMPLE + '/main.js').should == <<-result
var my_script;

var style = "html, body {margin:0; padding:0}\\
.i-am-child {}\\
.my-style {background: #fffacc}\\
";
    result
  end
end
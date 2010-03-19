require 'helper'

describe JSPP do
  describe '#get_file' do
    it 'fetches URI' do
      JSPP.new.get_file(PETS_URL).first.should == PETS
    end
    it 'reads file' do
      main_js = EXAMPLE + '/main.js'
      JSPP.new.get_file(main_js, '/').first.should == File.read(main_js)
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
end
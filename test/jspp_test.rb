require "test/unit"

class JSPreprocessorTest < Test::Unit::TestCase

  def jspp(arg='')
    `../bin/jspp ../example/#{arg}`
  end

  def test_examples
    assert_equal File.read('../example/style-child.css'), jspp('style-child.css')
    assert_equal <<-multiline, jspp('style.css')
html, body {margin:0; padding:0}
.i-am-child {}
.my-style {background: #fffacc}
multiline
    assert_equal File.read('../example/script.js'), jspp('script.js')
    assert_equal <<-multiline, jspp('main.js')
var my_script;

var style = "html, body {margin:0; padding:0}\\
.i-am-child {}\\
.my-style {background: #fffacc}\\
";
multiline
  end
end
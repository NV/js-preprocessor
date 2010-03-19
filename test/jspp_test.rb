require "test/unit"

class JSPreprocessorTest < Test::Unit::TestCase

  DIR = File.dirname __FILE__
  EXAMPLE = File.join DIR, '..', 'example', ''
  JSPP = File.join DIR, '..', 'bin', 'jspp'

  def jspp(name='')
    `#{JSPP} #{EXAMPLE}#{name}`
  end

  def test_examples
    assert_equal File.read("#{EXAMPLE}css/style-child.css"), jspp('css/style-child.css')
    assert_equal <<-multiline, jspp('css/style.css')
html, body {margin:0; padding:0}
.i-am-child {}
.my-style {background: #fffacc}
multiline
    assert_equal File.read("#{EXAMPLE}script.js"), jspp('script.js')
    assert_equal <<-multiline, jspp('main.js')
var my_script;

var style = "html, body {margin:0; padding:0}\\
.i-am-child {}\\
.my-style {background: #fffacc}\\
";
multiline
  end
end
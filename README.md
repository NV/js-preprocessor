JavaScript preprocessor
===============
Minimal preprocessing with `/*>*/`


Usage
----
`jspp input > output`

Example
----
<table><tr>
<td>main.js
<pre>/*> script.js */

var style = "/*> style.css */";</pre></td>
<td>style.css
<pre>html, body {margin:0; padding:0}
/*> http://nv.github.com/js-preprocessor/example/style-child.css */
.my-style {background: #fffacc}
</pre></td>
<td><br/>style-child.css
<pre>.i-am-child {}
</pre></td>
</tr><tr>
<td><br/>script.js
<pre>var my_script;</pre></td>
</tr></table>

    $ jspp example/main.js
    var my_script;
    
    var style = "html, body {margin:0; padding:0}\
    .i-am-child {}\
    .my-style {background: #fffacc}"

JavaScript preprocessor in a wild:
[GitHub Live Preview](http://github.com/NV/github-live-preview).

Installation
----
[Ruby gem](http://rubygems.org/gems/jspp)

    $ gem install jspp

Also, you can use `bin/jspp` directly. It’s just self-contained ruby script with no dependencies.

Why reinvent the wheel?
----
[Sprockets](http://github.com/sstephenson/sprockets) can't include non-JS files.
JS preprocessor can.

[Juicer](http://github.com/cjohansen/juicer) can include one JS file to another via
`@depend` statement, but can't include CSS file to JS as multiline string. 
JS preprocessor can do it via `"/*> some_file */"`.

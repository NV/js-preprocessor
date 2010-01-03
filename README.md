JavaScript preprocessor
===============
Minimal preprocessing with `/*>*/`


Usage
----
`jspp input > output`

Example
----
    $ cat example/main.js
    /*> script.js */
    
    var style = "/*> style.css */";

    $ cat example/script.js
    var my_script;example

    $ cat example/style.css
    html, body {margin:0; padding:0}
    /*> style-child.css */
    .my-style {background: #fffacc}
    
    $ cat example/style-child.css
    .i-am-child {}
    
    $ bin/jspp example/main.js
    var my_script;
    
    var style = "html, body {margin:0; padding:0}\
    .i-am-child {}\
    .my-style {background: #fffacc}"


Why reinvent the wheel?
----
[Sprockets](http://github.com/sstephenson/sprockets) can't include non-JS files.
JS preprocessor can.

[Juicer](http://github.com/cjohansen/juicer) can include one JS file to another via
`@depend` statement, but can't include CSS file to JS as multiline string. 
JS preprocessor can do it via `"/*> some_file */"`.

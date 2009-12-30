JS preprocessor
===============

main.js
    /*> script.js */
    
    var style = "/*> style.css */";


script.js
    var my_script;


style.css
    html, body {margin:0; padding:0}
    .my-style {background: #fffacc}


    example$ ../bin/jspreprocessor main.js
    var my_script;
    
    var style = "html, body {margin:0; padding:0}\
    .my-style {background: #fffacc}";


Why?
----
Because [http://github.com/sstephenson/sprockets](Sprockets) can't include non-JS files.

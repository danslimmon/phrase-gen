<?php

$sentence = rtrim(`ruby phrase.rb data/healthcare.yaml`);
?>
<html> <meta http-equiv="Content-Type" content="text/html; charset=utf-8"> <head><link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet"></head> <body> <div class='container' style='top:25% ;position:relative;'> <div class='row'> <div class='jumbotron text-center'><h1><? echo $sentence ?></h1></div> </div> </div> <div style="position: fixed; bottom: 1em; left: 49%; font-size: 0.6em; color: gray; font-family: Helvetica, Sans-Serif"><a href="https://github.com/danslimmon/phrase-gen">Source</a></div> </body> </html>

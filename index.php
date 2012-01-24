<?php

$title = rtrim(`ruby phrase.rb data/of-montreal.yaml`);
?>
<html>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <body style="background-color: black; letter-spacing: 1px; font-family: Apple Chancery, Gabriola, Sans-Serif;">
    <div style="text-align: center; width: 100%; left-margin: auto; right-margin: auto; position: relative; top: 20%;">
        <div style="float: left; height: 35%;"></div>
        <div style="position: relative; color: white; font-size: xx-large; text-align: center;">Of Montreal</div>
        <div style="position: relative; top: 2em; text-align: center"><img src="/of-montreal-divider.png"></div>
        <div style="position: relative; top: 3em; color: white; font-size: x-large; text-align: center"><? echo $title ?></div>
    </div>
    </body>
</html>

<?php

$opt[1] = "--vertical-label Packages -l0  --title \"$hostname / $servicedesc\" ";

$def[1]  = '';
$def[1] .= rrd::def("avail", $RRDFILE[1], $DS[1], "AVERAGE");
$def[1] .= rrd::def("crit",  $RRDFILE[2], $DS[2], "AVERAGE");

$def[1] .= rrd::area(  "avail", "#007FFF", "available ") ;
$def[1] .= rrd::gprint("avail", array("LAST", "AVERAGE", "MAX"), "%6.2lf");
$def[1] .= rrd::area(  "crit",  "#FF7F00", "critical  ") ;
$def[1] .= rrd::gprint("crit",  array("LAST", "AVERAGE", "MAX"), "%6.2lf");
?>
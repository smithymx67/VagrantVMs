<?php

$opt[1] = "--vertical-label Load -l0 -u1 --title \"$hostname / $servicedesc\"";

$def[1]  = '';
$def[1]  = rrd::def("load1", $RRDFILE[1], $DS[1], "AVERAGE");
$def[1] .= rrd::def("load5", $RRDFILE[2], $DS[2], "AVERAGE");
$def[1] .= rrd::def("loadF", $RRDFILE[3], $DS[3], "AVERAGE");

if ($WARN[1] != "") {
    $def[1] .= "HRULE:$WARN[1]#FF7F00 ";
}
if ($CRIT[1] != "") {
    $def[1] .= "HRULE:$CRIT[1]#FF0000 ";
}

$def[1] .= rrd::area(  "load1", "#CCCCCC", "load 1 ") ;
$def[1] .= rrd::gprint("load1", array("LAST", "AVERAGE", "MAX"), "%6.2lf");
$def[1] .= rrd::line1( "loadF", "#FF0000", "load 15") ;
$def[1] .= rrd::gprint("loadF", array("LAST", "AVERAGE", "MAX"), "%6.2lf");
$def[1] .= rrd::line1( "load5", "#FFBB00", "Load 5 ") ;
$def[1] .= rrd::gprint("load5", array("LAST", "AVERAGE", "MAX"), "%6.2lf");
?>
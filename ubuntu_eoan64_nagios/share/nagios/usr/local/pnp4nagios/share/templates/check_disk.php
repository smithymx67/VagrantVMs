<?php

$i = 0;
foreach ($this->DS as $KEY=>$VAL) {
    $i++;
    $opt[1] = "-X 0 --vertical-label MB -l 0 -u $MAX[1] --title \"$hostname / $servicedesc\"";
    $def[$i]  = '';
    $def[$i] .= rrd::def(   $NAME[1]."_var", $RRDFILE[1], $DS[1], "AVERAGE");
    $def[$i] .= rrd::area(  $NAME[1]."_var", "#CCCCCC", $LABEL[1]." ") ;
    $def[$i] .= rrd::line1( $NAME[1]."_var", "#000000") ;
    $def[$i] .= rrd::gprint($NAME[1]."_var", array("LAST", "AVERAGE", "MAX"), "%6.2lf");

    if ($MAX[$i] != "") {
        $def[$i] .= "HRULE:$MAX[1]#003300:\"Capacity $MAX[1] MB \" ";
    }
    if ($WARN[$i] != "") {
        $def[$i] .= "HRULE:$WARN[1]#FF7F00:\"Warning on $WARN[1] MB \" ";
    }
    if ($CRIT[$i] != "") {
        $def[$i] .= "HRULE:$CRIT[1]#FF0000:\"Critical on $CRIT[1] MB \\n\" ";
    }
}

?>
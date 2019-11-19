<?php
# Based on check_apachestatus_auto as included by pnp4nagios
$i=0;

#
# Requests per Second
#
$i++;
$def[$i]     = "";
$opt[$i]     = " -l0 --title Requests/s";
$ds_name[$i] = "Requests/s";
$regex = '/ReqPerSec/';
foreach ($this->DS as $KEY=>$VAL) {
    if(preg_match($regex, $VAL['NAME'])) {
        $def[$i]    .= rrd::def   ("var".$KEY, $VAL['RRDFILE'], $VAL['DS'], "AVERAGE");
        $def[$i]    .= rrd::area  ("var".$KEY, rrd::color($KEY), rrd::cut($VAL['NAME'],16), 'STACK' );
        $def[$i]    .= rrd::gprint("var".$KEY, array("LAST","MAX","AVERAGE"), "%6.1lf/s");
    }
}
#
# Bytes per Second
#
$i++;
$def[$i]     = "";
$opt[$i]     = " -l0 --title 'Bytes per Second'";
$ds_name[$i] = "Bytes/s";
$regex='/BytesPerSec/';
foreach ($this->DS as $KEY=>$VAL) {
    if(preg_match($regex, $VAL['NAME'])) {
        $def[$i]    .= rrd::def   ("var".$KEY, $VAL['RRDFILE'], $VAL['DS'], "AVERAGE");
        $def[$i]    .= rrd::area  ("var".$KEY, rrd::color($KEY), rrd::cut($VAL['NAME'],16), 'STACK' );
        $def[$i]    .= rrd::gprint("var".$KEY, array("LAST","MAX","AVERAGE"), "%6.1lf %sb/s");
    }
}
#
# Bytes per Request
#
$i++;
$def[$i]     = "";
$opt[$i]     = " -l0 --title 'Bytes per Request'";
$ds_name[$i] = "Bytes/Reqs";
$regex='/BytesPerReq/';
foreach ($this->DS as $KEY=>$VAL) {
    if(preg_match($regex, $VAL['NAME'])) {
        $def[$i]    .= rrd::def   ("var".$KEY, $VAL['RRDFILE'], $VAL['DS'], "AVERAGE");
        $def[$i]    .= rrd::area  ("var".$KEY, rrd::color($KEY),rrd::cut($VAL['NAME'],16), 'STACK' );
        $def[$i]    .= rrd::gprint("var".$KEY, array("LAST","MAX","AVERAGE"), "%6.1lf %sb/s");
    }
}
#
# Worker Stats
#
$i++;
$def[$i]     = "";
$opt[$i]     = " -l0 --title 'Worker States'";
$ds_name[$i] = "Worker States";
$regex='/^Workers(?!Open)/';
foreach ($this->DS as $KEY=>$VAL) {
    $val_name = rrd::cut(str_replace('Workers', '', $VAL['NAME']),10);
    if(preg_match($regex, $VAL['NAME'])) {
        $def[$i]    .= rrd::def   ("var".$KEY, $VAL['RRDFILE'], $VAL['DS'], "AVERAGE");
        $def[$i]    .= rrd::area  ("var".$KEY, rrd::color($KEY), $val_name, 'STACK' );
        $def[$i]    .= rrd::gprint("var".$KEY, array("LAST","MAX","AVERAGE"), "%6.0lf".$VAL['UNIT']);
    }
}
?>
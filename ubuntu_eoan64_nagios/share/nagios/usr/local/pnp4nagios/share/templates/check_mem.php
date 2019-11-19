<?php

$opt[1] = "--vertical-label bytes -l0  --title \"$hostname / $servicedesc\" ";

$def[1]  = '';

$names = array();
foreach ($this->DS as $KEY=>$VAL) {
    $def[1] .= rrd::def(  $VAL['NAME'], $VAL['RRDFILE'], $VAL['DS'], 'AVERAGE' );
    $def[1] .= rrd::cdef( $VAL['NAME'].'-MB', $VAL['NAME'].',1000000,/' );
    $names[] = $VAL['NAME'];
}

$def[1] .= rrd::area(  'total',   '#DDDDDD', 'total   MB');
$def[1] .= rrd::gprint('total-MB',   array('LAST', 'AVERAGE', 'MAX'), '%7.2lf');
$def[1] .= rrd::line1( 'total',   '#000000');

$def[1] .= rrd::area(  'used',    '#0000FF', 'used    MB');
$def[1] .= rrd::gprint('used-MB',    array('LAST', 'AVERAGE', 'MAX'), '%7.2lf');

$def[1] .= rrd::area(  'buffers', '#EEEE00', 'buffers MB', 'STACK');
$def[1] .= rrd::gprint('buffers-MB', array('LAST', 'AVERAGE', 'MAX'), '%7.2lf');

if( in_array('cache', $names) ){
    $def[1] .= rrd::area(  'cache',   '#FFAA00', 'cache   MB', 'STACK');
    $def[1] .= rrd::gprint('cache-MB',   array('LAST', 'AVERAGE', 'MAX'), '%7.2lf');
}

?>
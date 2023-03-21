set ns [new Simulator] ;# initialise the simulation
# Predefine tracing
set f [open out.tr w]
$ns trace-all $f
set nf [open out.nam w]
$ns namtrace-all $nf

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

$ns duplex-link $n0 $n1 5Mb 2ms DropTail
$ns cost $n0 $n1 2
$ns duplex-link $n0 $n2 5Mb 2ms DropTail
$ns cost $n0 $n2 4
$ns simplex-link $n1 $n2 5Mb 2ms DropTail
$ns cost $n0 $n2 1
$ns duplex-link $n1 $n3 5Kb 2ms DropTail
$ns cost $n1 $n3 7 
$ns duplex-link $n2 $n4 5Mb 2ms DropTail
$ns cost $n2 $n4 3
$ns simplex-link $n3 $n4 5Mb 2ms DropTail
$ns cost $n3 $n4 2
$ns duplex-link $n3 $n5 5Mb 2ms DropTail
$ns cost $n3 $n5 1
$ns duplex-link $n4 $n5 5Mb 2ms DropTail
$ns cost $n4 $n5 3
# Some agents.
set udp0 [new Agent/UDP] ;# A UDP agent
$ns attach-agent $n0 $udp0 ;# on node $n0
set cbr0 [new Application/Traffic/CBR] ;# A CBR traffic generator agent
$cbr0 attach-agent $udp0 ;# attached to the UDP agent
$udp0 set class_ 0 ;# actually, the default, but. . .
set null0 [new Agent/Null] ;# Its sink
$ns attach-agent $n5 $null0 ;
$ns connect $udp0 $null0
$ns at 1.0 "$cbr0 start"
puts [$cbr0 set packetSize_]
puts [$cbr0 set interval_]

$ns at 3.0 "finish"
proc finish {} {
global ns f nf
$ns flush-trace
close $f
close $nf
puts "running nam..."
exec nam out.nam &
exit 0
}
$ns run
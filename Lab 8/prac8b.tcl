set ns [new Simulator] 
set f [open out.tr w]
$ns trace-all $f
set nf [open out.nam w]
$ns namtrace-all $nf
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]

$ns duplex-link $n1 $n2 5Mb 1ms DropTail
$ns duplex-link $n1 $n3 5Mb 1ms DropTail
$ns duplex-link $n2 $n4 5Mb 1ms DropTail
$ns duplex-link $n2 $n3 5Mb 1ms DropTail
$ns duplex-link $n3 $n5 5Mb 1ms DropTail
$ns duplex-link $n5 $n4 5Mb 1ms DropTail
$ns duplex-link $n4 $n6 5Mb 1ms DropTail
$ns duplex-link $n5 $n6 5Mb 1ms DropTail

$n1 color blue
$n2 color red
$n3 color red
$n4 color yellow
$n5 color yellow
$n6 color brown

set udp0 [new Agent/UDP] 
$ns attach-agent $n1 $udp0
set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $udp0 
$udp0 set class_ 0 
set null0 [new Agent/Null] 
$ns attach-agent $n6 $null0 
$ns connect $udp0 $null0
$ns at 0.5 "$cbr0 start"
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
# Finally, start the simulation.
$ns run

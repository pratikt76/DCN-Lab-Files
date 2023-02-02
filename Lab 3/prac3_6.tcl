set ns [new Simulator] 
$ns color 1 blue
$ns color 2 red
set f [open out.tr w]
$ns trace-all $f
set nf [open out.nam w]
$ns namtrace-all $nf

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]

$ns duplex-link $n2 $n1 10Mb 2ms DropTail
$ns duplex-link $n1 $n0 10Mb 2ms DropTail

set udp0 [new Agent/UDP] ;
$ns attach-agent $n0 $udp0 ;
set cbr0 [new Application/Traffic/CBR] ;
$cbr0 attach-agent $udp0 ;
$udp0 set class_ 0 ;
set null0 [new Agent/Null] ;
$ns attach-agent $n2 $null0 ;
$ns connect $udp0 $null0
$ns at 0.5 "$cbr0 start"
puts [$cbr0 set packetSize_]
puts [$cbr0 set interval_]

set tcp [new Agent/TCP]
$tcp set class_ 1
$ns attach-agent $n0 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n2 $sink
set ftp [new Application/FTP] ;
$ftp attach-agent $tcp
$ns at 0.5 "$ftp start"
$ns connect $tcp $sink
$ns at 2.5 "$ns detach-agent $n0 $tcp ; $ns detach-agent $n2 $sink"

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
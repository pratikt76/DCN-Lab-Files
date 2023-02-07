# The preamble
set ns [new Simulator] ;# initialise the simulation

$ns color 1 blue
$ns color 2 red

# Predefine tracing
set f [open out.tr w]
$ns trace-all $f
set nf [open out.nam w]
$ns namtrace-all $nf


# creating 5 node with one node acts as router is in the middle
# in this prog n0 is router node or center

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

$n0 color red
$n1 color red
$n2 color green
$n3 color green
$n4 color green
$n5 color green

$ns duplex-link $n0 $n1 5Mb 2ms DropTail
$ns duplex-link $n1 $n2 5Mb 2ms DropTail
$ns duplex-link $n2 $n3 5Mb 2ms DropTail
$ns duplex-link $n3 $n4 5Mb 2ms DropTail
$ns duplex-link $n4 $n5 5Mb 2ms DropTail
$ns duplex-link $n5 $n0 5Mb 2ms DropTail

# Some agents.

set udp0 [new Agent/UDP] ;# A UDP agent

$ns attach-agent $n0 $udp0 ;# on node $n0
set cbr0 [new Application/Traffic/CBR] ;# A CBR traffic generator agent
$cbr0 attach-agent $udp0 ;# attached to the UDP agent
$udp0 set class_ 0 ;# actually, the default, but. . .

set null0 [new Agent/Null] ;# Its sink
$ns attach-agent $n1 $null0 ;# on node $n2

$ns connect $udp0 $null0

$udp0 set fid_ 1

$ns at 0.0 "$cbr0 start"

puts [$cbr0 set packetSize_]
puts [$cbr0 set interval_]

$ns at 1.5 "$cbr0 stop"



set udp0 [new Agent/UDP] ;# A UDP agent

$ns attach-agent $n1 $udp0 ;# on node $n0
set cbr0 [new Application/Traffic/CBR] ;# A CBR traffic generator agent
$cbr0 attach-agent $udp0 ;# attached to the UDP agent
$udp0 set class_ 0 ;# actually, the default, but. . .

set null0 [new Agent/Null] ;# Its sink
$ns attach-agent $n2 $null0 ;# on node $n2

$ns connect $udp0 $null0

$udp0 set fid_ 1

$ns at 0.0 "$cbr0 start"

puts [$cbr0 set packetSize_]
puts [$cbr0 set interval_]

$ns at 1.5 "$cbr0 stop"

set udp0 [new Agent/UDP] ;# A UDP agent

$ns attach-agent $n2 $udp0 ;# on node $n0
set cbr0 [new Application/Traffic/CBR] ;# A CBR traffic generator agent
$cbr0 attach-agent $udp0 ;# attached to the UDP agent
$udp0 set class_ 0 ;# actually, the default, but. . .

set null0 [new Agent/Null] ;# Its sink
$ns attach-agent $n3 $null0 ;# on node $n2

$ns connect $udp0 $null0

$udp0 set fid_ 1

$ns at 0.0 "$cbr0 start"

puts [$cbr0 set packetSize_]
puts [$cbr0 set interval_]

$ns at 1.5 "$cbr0 stop"

set udp0 [new Agent/UDP] ;# A UDP agent

$ns attach-agent $n3 $udp0 ;# on node $n0
set cbr0 [new Application/Traffic/CBR] ;# A CBR traffic generator agent
$cbr0 attach-agent $udp0 ;# attached to the UDP agent
$udp0 set class_ 0 ;# actually, the default, but. . .

set null0 [new Agent/Null] ;# Its sink
$ns attach-agent $n4 $null0 ;# on node $n2

$ns connect $udp0 $null0

$udp0 set fid_ 1

$ns at 0.0 "$cbr0 start"

puts [$cbr0 set packetSize_]
puts [$cbr0 set interval_]

$ns at 1.5 "$cbr0 stop"



set udp0 [new Agent/UDP] ;# A UDP agent

$ns attach-agent $n4 $udp0 ;# on node $n0
set cbr0 [new Application/Traffic/CBR] ;# A CBR traffic generator agent
$cbr0 attach-agent $udp0 ;# attached to the UDP agent
$udp0 set class_ 0 ;# actually, the default, but. . .

set null0 [new Agent/Null] ;# Its sink
$ns attach-agent $n5 $null0 ;# on node $n2

$ns connect $udp0 $null0

$udp0 set fid_ 1

$ns at 0.0 "$cbr0 start"

puts [$cbr0 set packetSize_]
puts [$cbr0 set interval_]

$ns at 1.5 "$cbr0 stop"



# A FTP over TCP/Tahoe from $n3 to $n4, flowid 2
set tcp [new Agent/TCP]


$tcp set class_ 1
$ns attach-agent $n5 $tcp

set sink [new Agent/TCPSink]
$ns attach-agent $n4 $sink

set ftp [new Application/FTP] ;# TCP does not generate its own traffic
$ftp attach-agent $tcp
$ns at 1.5 "$ftp start"

$ns connect $tcp $sink

$tcp set fid_ 2

$ns at 3.0 "$ns detach-agent $n0 $tcp ; $ns detach-agent $n1 $sink"

set tcp [new Agent/TCP]

$tcp set class_ 1
$ns attach-agent $n4 $tcp

set sink [new Agent/TCPSink]
$ns attach-agent $n3 $sink

set ftp [new Application/FTP] ;# TCP does not generate its own traffic
$ftp attach-agent $tcp
$ns at 1.5 "$ftp start"

$ns connect $tcp $sink

$tcp set fid_ 2

$ns at 3.0 "$ns detach-agent $n1 $tcp ; $ns detach-agent $n2 $sink"


set tcp [new Agent/TCP]

$tcp set class_ 1
$ns attach-agent $n3 $tcp

set sink [new Agent/TCPSink]
$ns attach-agent $n2 $sink

set ftp [new Application/FTP] ;# TCP does not generate its own traffic
$ftp attach-agent $tcp
$ns at 1.5 "$ftp start"

$ns connect $tcp $sink

$tcp set fid_ 2

$ns at 3.0 "$ns detach-agent $n2 $tcp ; $ns detach-agent $n3 $sink"


set tcp [new Agent/TCP]

$tcp set class_ 1
$ns attach-agent $n2 $tcp

set sink [new Agent/TCPSink]
$ns attach-agent $n1 $sink

set ftp [new Application/FTP] ;# TCP does not generate its own traffic
$ftp attach-agent $tcp
$ns at 1.5 "$ftp start"

$ns connect $tcp $sink

$tcp set fid_ 2

$ns at 3.0 "$ns detach-agent $n3 $tcp ; $ns detach-agent $n4 $sink"




set tcp [new Agent/TCP]

$tcp set class_ 1
$ns attach-agent $n1 $tcp

set sink [new Agent/TCPSink]
$ns attach-agent $n0 $sink

set ftp [new Application/FTP] ;# TCP does not generate its own traffic
$ftp attach-agent $tcp
$ns at 1.5 "$ftp start"

$ns connect $tcp $sink

$tcp set fid_ 2

$ns at 3.0 "$ns detach-agent $n4 $tcp ; $ns detach-agent $n5 $sink"



# The simulation runs for 3s.
# The simulation comes to an end when the scheduler invokes the finish{} procedure below.
# This procedure closes all trace files, and invokes nam visualization on one of the trace files.

$ns at 3.5 "finish"
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
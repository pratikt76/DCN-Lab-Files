# Create a simulator objevt set

ns[new Simulator]

$ns color 1 Blue
$ns color 2 record

#Open the nam trace file
#set nf[open out.nam w]
#$ns namtrace-all $nf

#Open then ns trace file set
tf [open ass21.tr w] set
winfile[open Win w]
$ns trace-all $tf

#Create five nodes
set n0 [$ns mode] set
n1 [$ns node] set n2
[$ns node] set n3
[$ns node] set n4
[$ns node] set n5
[$ns node]

#Create a duplex link between the nodes
$ns duplex-link $n0 $n2 2Mb 10ms DropTail
$ns duplex-link $n1 $n2 2Mb 10ms DropTail
$ns simplex-link $n2 $n3 0.3Mb 100ms DropTail
$ns simplex-link $n3 $n2 0.3Mb 100ms DropTail
$ns duplex-link $n3 $n4 0.5Mb 40ms DropTail
$ns duplex-link $n3 $n5 0.5Mb 30ms DropTail

$ns queue-limit $ns2 $ns3 20


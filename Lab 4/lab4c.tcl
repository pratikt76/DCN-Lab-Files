
# Page no 81 in ns2 Doc


set ns [new Simulator] ;# preamble initialization
Queue/JoBS set drop_front_ false ;# use drop-tail
Queue/JoBS set trace_hop_ true ;# enable statistic traces
Queue/JoBS set adc_resolution_type_ 0 ;# see ‘‘commands at a glance’’
Queue/JoBS set shared_buffer_ 1 ;# all classes share a common buffer
Queue/JoBS set mean_pkt_size_ 4000 ;# we expect to receive 500-Byte pkts
Queue/Demarker set demarker_arrvs1_ 0 ;# reset arrivals everywhere
Queue/Demarker set demarker_arrvs2_ 0
Queue/Demarker set demarker_arrvs3_ 0
Queue/Demarker set demarker_arrvs4_ 0
Queue/Marker set marker_arrvs1_ 0
Queue/Marker set marker_arrvs2_ 0
Queue/Marker set marker_arrvs3_ 0
Queue/Marker set marker_arrvs4_ 0
set router(1) [$ns node] ;# set first router
set router(2) [$ns node] ;# set second router
set source [$ns node] ;# set source
set sink [$ns node] ;# set traffic sink
set bw 10000000 ;# 10 Mbps
set delay 0.001 ;# 1 ms
set buff 500 ;# 500 packets

$ns duplex-link $router(1) $router(2) $bw $delay JoBS ;# Creates the JoBS link
$ns_ queue-limit $router(1) $router(2) $buff
set l [$ns_ get-link $router(1) $router(2)]
set q [$l queue]
$q init-rdcs -1 2 2 2 ;# Classes 2, 3 and 4 are bound by proportional delay differentiation with a factor of 2
$q init-rlcs -1 2 2 2 ;# Classes 2, 3 and 4 are bound by proportional loss differentiation with a factor of 2
$q init-alcs 0.01 -1 -1 -1 ;# Class 1 is provided with a loss rate bound of 1%
$q init-adcs 0.005 -1 -1 -1 ;# Class 1 is provided with a delay bound of 5 ms
$q init-arcs -1 -1 -1 500000 ;# Class 4 is provided with a minimumthroughput of 500 Kbps
$q link [$l link] ;# The link is attached to the queue (required)
$q trace-file jobstrace ;# Trace per-hop, per-class metrics to the file jobstrace
$q sampling-period 1 ;# Reevaluate rate allocation upon each arrival
$q id 1 ;# Assigns an ID of 1 to the JoBS queue
$q initialize ;# Proceed with the initialization
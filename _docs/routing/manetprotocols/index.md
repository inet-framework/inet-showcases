---
layout: page
title: Routing protocols for mobile ad hoc networks
hidden: true
---

## Goals

Routing protocols for mobile adhoc networks (MANETs) often fall into two major categories: reactive and proactive. INET contains various routing protocols for MANETs from both categories, and from other categories as well.

<!-- This showcase demonstrates three manet routing protocols with three example simulations. There is a simulation demonstrating manet routing with a reactive protocol (Aodv), a proactive protocol (Dsdv), and a manet routing protocol that is neither reactive nor proactive (Gpsr). -->

<!-- This showcase demonstrates three manet routing protocols with three example simulations, using a reactive (aodv), a proactive (dsdv), and a location based (gpsr) routing protocol. -->

This showcase demonstrates the configuration and operation of three manet routing protocols with three example simulations, using a reactive (AODV), a proactive (DSDV), and a location based (GPSR) routing protocol.

<!-- INET contains various routing protocols for simulating mobile adhoc networks (manets). Routing protocols for manets often fall into
on of two major categories: proactive and reactive. This showcase demonstrates
three manet routing protocols with three example simulations. It demonstrates a reactive (Aodv) and a proactive (Dsdv)
routing protocol, as well as one that is neither reactive nor proactive, but geographic location based (Gpsr). -->

<!-- TODO: it demonstrates how to configure it ?
TODO: comparison -->

INET version: `4.0`<br>
Source files location: <a href="https://github.com/inet-framework/inet-showcases/tree/master/routing/manetprotocols" target="_blank">`inet/showcases/routing/manetprotocols`</a>

## About MANETs

<!-- manets are mobile so there is no infrastructure and it is dynamic so we need protocols that can
work in the environment. reaction time and scalability. -->

MANETs are ad hoc networks comprised of wireless nodes, which are often not stationary. Given the mobile nature of the nodes, the network topology can change dynamically. The nodes create their own network infrastructure: each node also acts as a router, forwarding traffic in the network. MANET routing protocols need to adapt to changes in the network topology and <!--continuously--> maintain routing information to be able to forward packets to their destinations.

<!-- TODO: keywords: autonomous, wireless, self-configuring, continuously maintain information to properly route. each node is a router, forwarding traffic not mean for him. transport layer ? -->

<!-- MANETs operate without any existing infrastructure. Only the nodes create the network. Each node acts as a router, and the topology of the network is continuously changing. MANET routing protocols need to adapt to these changes in the network to be able to forward packets to their destinations. -->

There are two main types of MANET routing protocols, reactive and proactive (although there are others which don't fit into either category.) `Reactive` or on-demand routing protocols update routing information when there is an immediate demand for it, i.e. one of the nodes wants to send a packet (and there is no working route to the destination.) Then, they exchange route maintenance messages, and forward the packet. The routes stay the same until there is an error in a packet's forwarding, i.e. the packet cannot be forwarded anymore due to a change in the network topology. These type of protocols require less overhead than proactive protocols, but also might react more slowly to changes in the network topology. Examples of reactive MANET routing protocols include AODV, DSR, ABR, etc. `Proactive` or table-driven routing protocols continuously maintain routing information, so the routes in the network are always up to date.
This typically involves periodic routing maintenance messages exchanged throughout the network.
These types of protocols use more maintenance transmissions than reactive protocols in order to make sure the routing information is always up-to-date (they update it even when there is no change in the network topology.)
Due to the up-to-date nature of routing information, latency is lower than in the case of reactive protocols. Examples of reactive MANET routing protocols include DSDV, OLSR, Babel, etc.
There are other types of MANET routing protocols, such as Hybrid (both reactive and proactive), Hierarchical, and Geo routing.

INET features many routing protocols, for MANETs, and for other uses (including wired and wireless cases.)
See <a href="https://github.com/inet-framework/inet/tree/master/src/inet/routing" target="_blank">`/inet/src/inet/routing`</a> directory for the available routing protocols.

The example simulations in this showcase features the reactive protocol `Ad hoc On-Demand Distance Vector routing` (AODV), the proactive protocol `Destination-Sequenced Distance Vector routing` (DSDV),
and the geo routing protocol `Greedy Perimeter Stateless Routing` (GPSR). The following section details these three protocols briefly.

### About AODV

AODV is a reactive (or on-demand) MANET routing protocol, and as such, it maintains routes
for which there is a demand in the network (i.e. packets are frequently sent on the route.)
AODV uses IP addresses to address packets, and maintains a routing table with the next hop for reaching destinations. Routes time out after a while if not used. AODV features the following routing message types:

- `RREQ`: Route request
- `RREP`: Route reply
- `RERR`: Route error

When a node wants to send a packet, and it doesn't know the route to the destination, it initiates route discovery, by sending an `RREQ` multicast message. The neighboring nodes record where the message came from, and forward it to their neighbors, until the message gets to the destination node. The destination node replies with an `RREP`, which gets back to the source on the reverse path along which the `RREQ` came. <!--The intermediate nodes record the route towards the destination, as the RREP gets back to the source.-->
Forward routes are set up in the intermediate nodes as the `RREP` travels back to the source.
An intermediate node can also send an `RREP` in reply to a received `RREQ`, if it knows the route to the destination, thus nodes can join an existing route. When the `RREP` arrives at the source, and the route is created, communication can being between the source and the destination. If a route no longer works, i.e. messages cannot be forwarded on it, `RERR` messages are broadcast, and this triggers route discovery.
As a reactive protocol, generally AODV has less overhead (less route maintenance messages) than proactive ones, but reacts to changes in network topology slower. <!--TODO: less overhead in what measure? less frequent route maintenance packets? smaller packets? less overhead in bytes, time, ?-->

TODO: the overhead depends on the mobility level

(Note that the routing protocol overhead depends on the mobility level in the network.)
-> this seems obvious

Additionally, even though AODV is a reactive protocol, nodes can send periodic hello messages to discover links to neighbors and update the status of these links. This mechanism is local (hello messages are only sent to neighbors, and not forwarded), and it can make the network more responsive to local topology changes. By default, hello messages are turned off in INET's AODV implementation.

### About DSDV


V1

DSDV is a proactive (or table driven) MANET routing protocol, so it makes sure routing information in the network is always up-to-date. It maintains a table with the best routes to each destination. The table contains all other nodes a node knows about either directly because it's a neighbor, or indirectly through neighbors. The table contains nodes' IP addresses, last known sequence number and hop count required to reach it, and the next hop. Routing information is frequently updated, so all nodes have the best routes in the network.
Routing information is updated in two ways:

- Nodes broadcast their entire routing tables periodically (infrequently)
- Nodes broadcast small updates when a change in their routing table occurs

A node updates a routing table entry if it receives a better route. A better route is one that has a higher sequence number, or a lower hop count if the sequence number is the same.
<!-- TODO: this detail is probably not needed. -->

V2

DSDV is a proactive (or table-driven) MANET routing protocol, where nodes maintain a routing table of the best distances for destinations in the network. The routing tables are updated periodically, and when there is a change in a node's routing table (a better route becomes available.)

TODO: about performance -> more overhead (?) less delay

<!-- Note that INET's DSDV implementation only features the smaller periodic updates (hello messages.)
TODO: is this needed ? -> not here -> config section -->

<!-- TODO
The most important is:

all nodes maintain the best routes to destinations. they are frequently updated. they periodically
broadcast their entire routing tables, and send smaller updates when a change occurs in their routing tables. -->

### About GPSR


<!-- TODO: about ability to circumvent voids.
TODO: greedy is used whenever possible, perimeter is used whenever greedy cannot be.
TODO: keywords: locally optimal greedy choice in next hop...successively closer geographic hops
periodically broadcast its IP and position (x and y coordinates)
if no beacon is received after some time from a known neighbor, the entry is deleted,
and the neighbor is assumed to have gone out of range. also, 802.11 mac retransmission
failures cause the entry to be deleted (it is interpreted the same way)
A node has only information of the nodes in its vicinity/immediate neighbors
the beaconing proactive behavior...position is attached to all packets...thus all packets
serve as beacons (the inter beacon timer is resetted at every packet send...recuding time between beacons at parts of the network with active traffic) -->

GPSR is a geographic location based routing protocol. Each node maintains the addresses and geographical co-ordinates of its neighbors, i.e. other nodes in its communication range. Nodes advertise their locations periodically by sending beacons. When no beacons are received from a neighboring node for some time, the node is assumed to have gone out of range, and its table entry is deleted. A table entry for a node is also deleted after 802.11 MAC retransmission failures.
Nodes attach their location data on all sent and forwarded packets as well. Each packet transmission resets the inter beacon timer, reducing the required protocol overhead in parts of the network with frequent packet traffic.

Destination selection for packets is not address based, but packets are addressed to a location specified with co-ordinates. The destination node is actually the one which is the closest to the destination co-ordinates. The protocol operates in one of two modes:
<!--- In greedy routing mode, the next hop is the neighboring node which is geographically closest to the destination's location. Eventually, the packet reaches the destination. /* If a node should forward a packet, but doesn't know about any nodes that are closer to the destination than itself, it switches the packet to perimeter routing mode.*/ If a node should forward a packet, but it is closer to the destination than any of its neighbors, it switches the packet to perimeter mode.-->
- In greedy mode, a node forwards a packet to its neighbor which is geographically closest to the destination node. Thus the packet gets gradually closer to its destination with every hop. If a forwarding node is closer to the destination than any of its neighbors, the node switches the packet to perimeter mode. In this case, the packet must take a route that takes it farther from its destination temporarily - it routes around a void, a region without any nodes to route to.
- In perimeter routing mode, the packet can circumnavigate a void. When the packet is in this mode, nodes create a planar graph of their neighboring nodes based on their location, where vertices represent nodes and edges represent possible paths between nodes. Nodes use the right hand rule for forwarding packets, i.e. they forward the packet on the first edge to the right, compared to the edge the packet arrived from. Each node does this, until the packet arrives at its destination, or at an intermediate node which is closer to the destination than the one at which the packet was switched to perimeter mode. In the latter case, the packet is switched to greedy mode. If the packet is in perimeter mode and would be forwarded on an edge that it has been forwarded on previously, it is discarded (there is no route to the destination.) <!--can forward the packet to another node which is closer to the destination (in which case the packet is switched to greedy mode.)--> <!--If a packet is in perimeter mode and arrives at node it has been at previously, then it is discarded. TODO: how does this work?-->

<!-- TODO: parameters can be according to the mobility rate and the communication ranges in the network.
or maybe this belongs in the configuration section. -->

Several parameters of the protocol can be set according to the mobility rate and transmission ranges in the network, such as interval of beacons and timeout of neighbor location data.

<!-- TODO: this seems too big -->

<!-- TODO: sometimes the node doesnt know the location of all its neighbors (if they havent yet received a beacon from them) -> config section

TODO: about this much is enough about each protocol. Should be BRIEF. -->

<!-- TODO
About manets and routing protocols in general
About the three routing protocols briefly
Then about the configuration and networks
Then the results

then the statistic results ? or thats for later

Maybe something like Part I: demonstrating the protocols
                     Part II: comparing the protocols based on statistics, and how to do a parameter
                              study

The part II would involve: selecting a network, and mobility scenario. Making sure the results are seed independent. Then should run a study which selects the best performing parameter settings for each protocol. Then comparing the three protocols. Can you use the results from the study which looks for the best parameter values as the final results ? -->

## Configuration and Results

This section contains the configuration and results for the three simulations, which will demonstrate the MANET routing protocols `AODV`, `DSDV` and `GPSR`.
The AODV and DSDV simulations will use the `ManetRoutingProtocolsShowcaseA` network, which will feature moving hosts. The GPSR simulation will use the `ManetRoutingProtocolsShowcaseB` network, featuring stationary hosts. The networks are defined in <a srcfile="routing/manetprotocols/ManetProtocolsShowcase.ned"/>. Both networks contain hosts of the type `ManetRouter` (an extension of `WirelessHost`), whose routing module type is configurable.
Just as `WirelessHost`, it uses `Ieee80211ScalarRadio` by default. It also has IP forwarding enabled, and its management module is set to `Ieee80211MgmtAdhoc`. In the network, there is a source host named `source`, a destination host named `destination`, and a number of other hosts, which are named `node1` up to `node10` (their numbers vary in the different networks.) In addition to mobile nodes, both networks contain an `Ieee80211ScalarRadioMedium`, an `Ipv4NetworkConfigurator`, and an `IntegratedMultiVisualizer` module.
The nodes' default PHY model (IEEE 802.11) will suffice, because we're focusing on the routing protocols.

<!-- TODO: it uses wifi, because it doesnt matter...we're concentrating on the routing protocols here
TODO: what is ManetRouter ? -->

In all three simulations, the source node pings the destination node. The two nodes are out of communication range of each other, and the other nodes are responsible to forward packets between the two.
Since routes are managed dynamically by the MANET routing algorithms, the `Ipv4NetworkConfigurator` module is instructed not to add any routes (it will only assign IP addresses.) The netmask routes added by network interfaces are disabled as well. The following keys in the `General` configuration in <a srcfile="routing/manetprotocols/omnetpp.ini"/> achieve this:

<p>
<pre class="snippet" src="omnetpp.ini" from="configurator" upto="netmaskRoutes"></pre>
</p>

<!-- TODO: mobility -->

<!-- In the simulations for AODV and DSDV (using the `ManetRoutingProtocolsShowcaseA` network), `source` and `destination` will be static nodes out of communication range from each other. All other nodes will be moving around randomly, while taking part in routing the packets between the source and the destination nodes. In the GPSR simulation, all nodes will be stationary. TODO: is this necessary ? -->

### AODV

The example simulation featuring AODV is defined in the `Aodv` configuration in <a srcfile="routing/manetprotocols/omnetpp.ini"/>. This configuration uses the `ManetProtocolShowcaseA` network. The network looks like the following:

<img class="screen" src="networkA.png" style="max-width: 60%;">

<!-- - nodes are scattered
- the source and the destination are stationary
- the other nodes move linearly in random directions
- they relay the ping packets between source and destination -->

The nodes are scattered on the playground. The source and destination nodes are stationary, the other nodes will be moving in random directions. The communication ranges are set up so that `source` cannot reach `destination` directly, but through the intermediate nodes.
<!-- The topology will change fast, and the routing protocols will find routes from the source to the destination. TODO: rewrite -->
The routing protocols will adapt the routes to the changing network topology.

The mobility settings are defined in the `MobileNodesBase` configuration in omnetpp.ini. The simulations for AODV and DSDV, which feature moving nodes, will be based on this configuration.
<!--TODO: what does it do ?--> The nodes will be moving on linear paths in random directions with 25 meters per second, bouncing back from the edge of the playground. The mobility settings are the following:

<pre class="snippet" src="omnetpp.ini" from="LinearMobility" upto="MinY"></pre>

The ping app in `source` will send one ping request every second.

In INET, AODV is implemented by the `Aodv` module. This is configured in omnetpp.ini as the routing protocol type in `ManetRouter`:

<pre class="snippet" src="omnetpp.ini" from='"Aodv"' until=" "></pre>

The `Aodv` module has many parameters for contolling the operation of the protocol. The parameters can be set according to the number of nodes in a network, the nodes' mobility levels, traffic, and radio transmission power levels/communication ranges. All of the parameters have default values, and `Aodv` works out of the box, without setting any of the parameters. We will fine tune the protocol's behavior to our scenario by setting two of the parameters: <!--We set two of the parameters:-->

<pre class="snippet" src="omnetpp.ini" from="activeRouteTimeout" upto="deletePeriod"></pre>

The `activeRouteTimeout` parameter sets the timeout for the active routes. If the routes are not used for this period, they become inactive. The `deletePeriod` parameter sets the period after which the inactive routes are deleted. The `activeRouteTimeout` parameter is lowered from the default 3s to 1s, the `deletePeriod` parameter is lowered from the default 15s to 0.5s in order to make the protocol react faster to the rapidly changing network topology. (Higher mobility mobility results in routes becoming invalid faster. Thus the routing protocol can work better - react to topology changes faster - with lower timeout values.) <!--WHY IS THIS GOOD FOR THAT PURPOSE?-->

<!--<p><video autplay loop controls onclick="this.paused ? this.play() : this.pause();" src="Aodv1.mp4"></video></p>-->
<!--internal video recording, debug mode, normal run, animation speed none, zoom 1.54-->

<p><video autoplay loop controls max-width-percent="60" onclick="this.paused ? this.play() : this.pause();" src="Aodv5_s.mp4"></video></p>
<!--internal video recording, release mode (does it matter?), normal run, animation speed none, zoom 2 (or 1.54 if smaller), fadeOutMode = animationTime in datalink and networkroute visualizers-->
<!--playback speed 0.38, normal run until event 1950-->

<!-- TODO
aodv is done by the aodv module. it can be set in the manetrouter. it has a lot of parameters,
but we leave them at their defaults, only set two of them, to tweak the protocol for the mobility
in the network. Essentially, it makes the protocol react to changes faster. -->

Successful data link layer transmissions are visualized by colored arrows. Note that only the routing protocol and ping packets are visualized, not the ACKs. Here is what happens in the video:

At the beginning of the simulation, `source` queues a ping request packet for transmission. There are no routes for `destination`, so it broadcasts an `AodvRreq` message. The RREQ is re-broadcast by the adjacent nodes, until it gets to `destination`. The destination node sends an unicast `AodvRrep`. It is forwarded on the reverse path the RREQ message arrived on (`destination`->`node6`->`node1`->`source`). As the intermediate nodes receive the RREP message, the routes to `destination` are created. The routes are visualized with black arrows, the `RoutingTableVisualizer` is configured to only visualize routes leading to `destination`. When the route is established in `source`, it sends the ping request packet, which gets to the destination. The ping reply packet gets back to `source` on the reverse path.

When source sends the next ping request packet, `host6` has already moved out of range of `destination`. The ping packet gets to `host6`, but can't get to `destination` (`host6` tries to transmit the packet a few times, but it doesn't get an ACK). So `host6` broadcasts an `AodvRerr` message, indicating that the link no longer works. When the RERR gets back to `host1`, it initates route discovery by broadcasting a RREQ message. When a new route is discovered (`source`->`node1`->`destination`), the ping traffic can continue.

The following log excerpt shows `node6` handling the first RREQ and RREP messages:

<img class="screen" src="aodvlog3.png" onclick="imageFullSizeZoom(this);" style="cursor:zoom-in">

### DSDV

<!-- TODO: there is no periodic updates -> full routing table dumps (incomplete implementation)
still seems they send hello message periodically -->

The example simulation featuring DSDV is defined in the `Dsdv` configuration in omnetpp.ini. Just like the AODV configuration, this one uses the `ManetRoutingProtocolsShowcaseB` network as well.
The mobility settings are also the same as in the AODV simulation.
The ping app in `source` will send ping requests with a period of 0.5s.

The DSDV protocol is implemented in the `Dsdv` module. The routing protocol type in all hosts is set to `Dsdv`:

<pre class="snippet" src="omnetpp.ini" from='"Dsdv"' until=" "></pre>

<!-- TODO: same mobility settings? mobility base config? or thats just a technical detail, and here it is enough that they use the same network, and the same mobility settings (so basically its the same scenario). -->

The INET implementation of DSDV doesn't feature complete routing table broadcasts, only the broadcasting of changes in the routing table using periodic hello messages. <!--TODO: whats the difference exactly?-->

Like `Aodv` (and most routing protocol modules), `Dsdv` has many parameters with default values that yield a working simulation without any configuration. In this simulation, similarly to the previous one, we set two parameters of the protocol:

<pre class="snippet" src="omnetpp.ini" from="helloInterval" upto="routeLifetime"></pre>

The `helloInterval` parameter controls the frequency of the periodic updates, or hello messages. Setting this parameter to longer decreases the protocol overhead, but the network will react more slowly to changes in topology. We lower it to make the network more adaptive to rapid changes.
The `routeLifetime` parameter sets after how long the routes expire. TODO: more on this?

TODO Actually, in DSDV, routes doesn't seem to time out. They are replaced with a route with a newer sequence number. If the link breaks, the hop count is updated to infinity. How to make sense of route lifetime ? The real dsdv doesnt seem to have this. Is this the same as install time? when a route hasnt been updated in a while it is deleted from the routing table? how can this happen?

there is a link break, the hop count becomes infinite, and then no changes are made to it?
or is there a change? if it stays broken, it wont be updated in the incremental update...
but it will be in the full dump?
maybe they are updated when not used

The following video shows the nodes sending hello messages and routes being created at the beginning of the simulation. Note that the black arrows represent routes, and routes from all nodes to all destinations are visualized here.

<p><video autoplay loop controls max-width-percent="60" onclick="this.paused ? this.play() : this.pause();" src="Dsdv1.mp4"></video></p>
<!--internal video recording, animation speed none, data link visualizers fadeOutMode set to animation time, zoom 1.54-->

The following video shows `source` pinging `destination`:

<p>
<video autoplay loop controls max-width-percent="60" onclick="this.paused ? this.play() : this.pause();" src="DsdvPing1.mp4"></video>
</p>
<!--internal video recording, animation speed none, playback speed 0.38 (seems to have an effect), zoom 1.54, fadeOutMode animation time, run until event 3000, run until next sendPing-->

### GPSR

The example simulation featuring GPSR is defined in the `Gpsr` configuration in omnetpp.ini. It uses the `ManetRoutingProtocolsShowcaseB` network. The network looks like the following:

<img class="screen" src="networkB.png" style="max-width: 90%">

Just as with the previous two configurations, the nodes are `ManetRouter`s.
The nodes are laid out along a chain. The transmitter power of the radios is configured so that nodes can only reach their neighbors in the chain (except for node9, which can reach nodes 11,5, and 8). There is forest, which represents a void that GPSR can route around. In this example simulation, the nodes will be static (though GPSR is suitable for scenarios with moving nodes.) The source node will ping the destination node, which is on the other side of the void.
(The ping app in `source` will send one ping request every second.)

The hosts' routing protocol type is set to `Gpsr`:

<pre class="snippet" src="omnetpp.ini" from='"Gpsr"' until=" "></pre>

<!-- Arbitrarily, the planarization algorithm is set to RNG. TODO: is this relevant?
All other protocol parameters are left at their defaults. -->

<!-- TODO: planarization algorithm ? -->

<!-- TODO: some examples of parameters? link to documentation? -->

<p><video autoplay loop controls max-width-percent="80" onclick="this.paused ? this.play() : this.pause();" src="Gpsr1.mp4"></video></p>
<!--simple screen recorder, 10 fps, normal run-->

<!-- - First, there are beacons, then source sends a ping. it sends it along the chain, until it gets to node9. node9 sends it to node5 because it is closer. node5 realizes it is the closes to the destination of all the neighbors, but it cant reach it. thus it switches the packet to perimeter mode.
it sends the packet to the right, to node6. node6 passes it along the chain, until it arrives at node1. node1 sends it back to node2, as it is the node on the right (actually, the only neighbor).
The packet travels up the chain, and nodes always send it to the right...it routes around the void.
It arrives at node10, which is closer to the destination than node5, where the packet was switched to perimeter mode (so there is information in the packet on where it was switched to perimeter mode). Node10 switches it back to greedy mode, and it can get to the destination from here in greedy mode.

- It might happen that backward reply packets dont take the same route as forward packets.
It might also happen that a node hasn't sent a beacon yet, so its neighbors have no knowledge of it...thus they wont route the packet to it.

- There are no routes in Ipv4's routing table...actually, why does it use ipv4 at all?
- q: how is a beacon routed/processed? how is a ping routed/processed?

- what about the communication ranges? its set up so that they only reach the adjacent.
- except that node9 can reach node11, node5, and node8, but thats it. node11 and node5 are out of range -->

The nodes start sending out GPSR beacons (and learning about the positions of their neighbors.)
Then `source` sends a ping request packet. It gets forwarded along the chain to `node9`, which sends it to `node5`, as it is the closest to destination among `node9`'s neighbors. However, `node5` doesn't have any neighbors closer to the destination (and it is out of range of `destination`), thus it switches the packet to perimeter mode. It forwards the ping packet according to the right hand rule. The packet gets to `node1` and then back up along the chain through `node9` again. Then `node10` switches it back to greedy routing mode, because `node10` is closer to the destination than `node5`, where it was switched to perimeter mode. Then the packet arrives at `destination`.

The reply packet starts off in perimeter mode, as the destination is closer to `source` than `destination`'s only neighbor, `node4`. The packet is switched back to greedy mode at `node10`, because it's closer to `source` than `destination`. From there, it gets to source through `node9` and `node11`.

Note that the reply packet didn't get back on the same route as the request packet.
Also, it might happen that a packet is not routed to a closer neighbor, because the sender doesn't yet know about it (and its position.) <!--TODO: not happening in this scenario -> maybe another scenario where they are not in a chain ? maybe add some intermediate nodes that wont be routing anything...-->

Also note that there are no IP routes (the `ipv4` module routing tables are empty.) Instead, `Gpsr` maintains the positions of the nodes in communication range (those that a beacon was received from), and uses that for routing decisions. Here is `node12`'s neightbor position table:

<img class="screen" src="positions.png" style="max-width: 80%;">

The nodes still use IP addresses for routing packets though. The table links node positions with IP addresses (it also contains the beacon arrival time.)

<!-- TODO: maybe there should be another gpsr config, where it is apparent that nodes forward packets
to the node which is the farthest away from them in the direction of the destination -->

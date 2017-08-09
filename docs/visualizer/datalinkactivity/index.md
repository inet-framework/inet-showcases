---
layout: page
title: Visualizing Data Link Activity
hidden: true
---

<script type="text/javascript" src="../../javascripts/imgToFullSize.js" charset="UTF-8"></script>

## Goals

In INET simulations, it is often useful to be able to visualize traffic between
network nodes. INET offers several visualizers for this task, operating at various
levels of the network stack. In this showcase, we examine
<var>DataLinkVisualizer</var> that can provide graphical feedback about data link
level traffic.

The showcase consists of four simulation models, each demonstrating different
features of data link activity visualization.

INET version: <var>3.6</var><br>
Source files location: <a href="https://github.com/inet-framework/inet-showcases/tree/master/visualizer/datalinkactivity" target="_blank"><var>inet/showcases/visualizer/datalinkactivity</var></a>

## About the Visualizer

In INET, data link activity can be visualized by including a
<var>DataLinkVisualizer</var> module in the simulation. Adding an
<var>IntegratedVisualizer</var> module is also an option, because it also contains a
<var>DataLinkVisualizer</var> module. Data link visualization is disabled by
default, it can be enabled by setting the visualizer's <var>displayLinks</var>
parameter to true.

<var>DataLinkVisualizer</var> currently observes packets that pass through the
data link layer (i.e. carry data from/to higher layers), but not those that are
internal to the operation of the data link layer protocol. That is, frames such as
ACK, RTS/CTS, Beacon or Authentication/Association frames of IEEE 802.11,
although potentially useful, will not trigger the visualization. Visualizing such
frames may be implemented in future INET revisions.

The activity between two nodes is represented visually by an arrow that points
from the sender node to the receiver node. The arrow appears after the first
packet has been received, then gradually fades out unless it is refreshed by
further packets. The style, color, fading time and other graphical properties can
be changed with parameters of the visualizer.

By default, all packets, interfaces and nodes are considered for the visualization.
This selection can be narrowed to certain packets and/or nodes with the
visualizer's <var>packetFilter</var>, <var>interfaceFilter</var>, and
<var>nodeFilter</var> parameters.

## Enabling Visualization of Data Link Activity

The following example shows how to enable the visualization of data link activity,
and how the visualization looks like. In the first example we configure a simulation
for a wired network. This simulation can be run by choosing the
<var>EnablingVisualizationWired</var> configuration from the ini file.

The wired network contains two <var>StandardHosts</var> (
<var>wiredSource</var> and <var>wiredDestination</var>). The
<var>linkVisualizer</var> module's type is <var>DataLinkVisualizer</var>.

<img src="DataLinkVisualizerSimpleWired.png" class="screen" />

In this configuration, <var>wiredSource</var> pings
<var>wiredDestination</var>. Data link activity visualization is enabled by setting the
<var>displayLinks</var> parameter to true.

``` {.snippet}
*.linkVisualizer.*.displayLinks = true
```

When we start the simulation, here is what happens.

<video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" width="722" height="352" src="EnablingVisualizationWired_v0613.m4v"></video>

At the beginning of the video, a red strip appears and moves from
<var>wiredSource</var> to <var>wiredDestination</var>. This strip is the standard
OMNeT++ animation for packet transmissions, and has nothing to do with
<var>DataLinkVisualizer</var>. When the packet is received in whole by
<var>wiredDestination</var> (the red strip disappears), a dark cyan arrow is added by
<var>DataLinkVisualizer</var> between the two hosts, indicating data link
activity. The packet's name is also displayed on the arrow. The arrow fades out
quickly, because the <var>fadeOutTime</var> parameter of the visualizer is set
to a small value.

Visualization in a wireless network is very similar. Our next example is the
wireless variant of the above simulation. In this network we use
<var>AdhocHosts</var> (<var>wirelessSource</var> and
<var>wirelessDestination</var>). The traffic and the visualization settings are the same
as the configuration of the wired example. The simulation can be run by choosing
the <var>EnablingVisualizationWireless</var> configuration from the ini file.

<img src="DataLinkVisualizerSimpleWireless.png" class="screen" />

The following animation depicts what happens when the simulation is run.

<video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" width="722" height="352" src="EnablingVisualizationWireless_v0613.m4v"></video>

This animation is similar to the video of the wired example (apart from an extra
blue dotted line which can be ignored, as it is also part of the standard OMNeT++
packet animation.) Note, however, that the ACK frame does not activate the
visualization, because ACK frames do not pass through data link layer.

## Filtering Data Link Activity

In complex networks with many nodes and several protocols in use, it is often
useful to be able to filter network traffic, and visualize only the part of the traffic
we are interested in.

The following example shows how to set packet filtering in
<var>DataLinkVisualizer</var>. This simulation can be run by choosing the
<var>Filtering</var> configuration from the ini file.

We use the following network for this showcase.

<img src="DataLinkVisualizerFiltering.png" class="screen" width="900" onclick="imageFullSizeZoom(this);" style="cursor:zoom-in" />

This network consists of four switches (<var>etherSwitch1..etherSwitch4</var>)
and six endpoints: two source hosts (<var>source1</var>,
<var>source2</var>), two destination hosts (<var>destination1</var>,
<var>destination2</var>) and two other hosts (<var>host1</var>,
<var>host2</var>) which are inactive in this simulation. <var>Source1</var> pings
<var>destination1</var>, and <var>source2</var> pings
<var>destination2</var>.

For this network, the visualizer's type is <var>IntegratedVisualizer</var>. Data
link activity visualization is filtered to display only ping messages. The other
packets, e.g. ARP packets, are not visualized by <var>DataLinkVisualizer</var>.
We adjust the <var>fadeOutMode</var> and the <var>fadeOutTime</var>
parameters so that the activity arrows do not fade out completely before the next
ping messages are sent.

We use the following configuration for the visualization.

``` {.snippet}
*.visualizer.*.dataLinkVisualizer.displayLinks = true
*.visualizer.*.dataLinkVisualizer.fadeOutMode = "simulationTime"
*.visualizer.*.dataLinkVisualizer.fadeOutTime = 1.4s
*.visualizer.*.dataLinkVisualizer.packetFilter = "ping*"
```

The following animation shows what happens when we start the simulation. You
can see that although there is both ARP and ping traffic in the network,
<var>DataLinkVisualizer</var> only takes the latter into account, due to the presence
of the <var>packetFilter</var> parameter.

<video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" width="900" height="651" src="Filtering_v0613.m4v"></video>

It also is possible to filter for network nodes. For the following example, let's
assume we want to display traffic between the hosts <var>source1</var> and
<var>destination1</var> only, along the path <var>etherSwitch1</var>,
<var>etherSwitch4</var> and <var>etherSwitch2</var>. To this end, we set the
visualizer's <var>nodeFilter</var> parameter by using the following line (note
the curly brace syntax used for specifying numeric substrings).

``` {.snippet}
*.visualizer.*.dataLinkVisualizer.nodeFilter = "source1 or etherSwitch{1,4,2} or destination1"
```

This what it looks like when we run the simulation:

<video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" width="900" height="651" src="Filtering2_v0613.m4v"></video>

As you can see, visualization allows us to follow the ping packets between
<var>source1</var> and <var>destination1</var>. Note, however, that ping traffic
between the two other hosts, <var>source2</var> and
<var>destination2</var>, also activates the visualization on the link between
<var>etherSwitch1</var> and <var>etherSwitch4</var>.

## Visualizing Data Link Activity in a Mobile Ad-Hoc Network

The following simulation shows how visualization can help you to follow
dynamically changing data link activity in a wireless environment. The simulation
can be run by choosing the <var>Dynamic</var> configuration from the ini file.

We use the following network for this simulation:

<img src="DataLinkVisualizerDynamic.png" class="screen" />

Nodes are of the type <var>AODVRouter</var>, and are placed randomly on the
playground. The communication range of the nodes is chosen so that the network
is connected, but nodes can typically only communicate by using multi-hop paths.
The nodes will also randomly roam within predefined borders. The routing
protocol is AODV. During the simulation, the <var>source</var> node will be
pinging the <var>destination</var> node.

In our first experiment, the goal is to visualize the operation of the AODV protocol
as it sets up a route from <var>source</var> to <var>destination</var>. We
expect to see the following. As long as <var>source</var> has a valid route
towards <var>destination</var>, AODV is inactive. When a new route is needed
towards <var>destination</var>, <var>source</var> starts to flood the network
with AODV route request (RREQ) messages. RREQ messages propagate through
the intermediate nodes until one of them reaches the <var>destination</var>
node. The route is made available by unicasting AODV route reply (RREP)
messages back to the originator of the RREQ messages. Reception of the RREP
message in each host results in the node updating its routing table with the next
hop address towards the destination node.

As AODV operates with two message types, we'll use two
<var>DataLinkVisualizer</var> modules configured to use two different colors.

``` {.snippet}
*.RREQVisualizer.*.displayLinks = true
*.RREQVisualizer.*.packetFilter = "AODV-RREQ"
*.RREQVisualizer.*.fadeOutMode = "simulationTime"
*.RREQVisualizer.*.fadeOutTime = 0.002s
*.RREPVisualizer.*.displayLinks = true
*.RREPVisualizer.*.packetFilter = "AODV-RREP"
*.RREPVisualizer.*.fadeOutMode = "simulationTime"
*.RREPVisualizer.*.fadeOutTime = 5s
*.RREPVisualizer.*.lineColor = "blue"
*.RREPVisualizer.*.labelColor = "blue"
```

The following video has been captured from the simulation, and allows us to
observe the AODV protocol in action. The dark cyan arrows indicate RREQ packets
which flood the network. When an RREQ message reaches
<var>destination</var>, <var>destination</var> sends an RREP message (blue arrow)
back towards <var>source</var>. Note that nodes appear stationary because the
whole process takes place in a very short time period.

<video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" width="642" height="602" src="AODV_v0614.m4v"></video>

In the second experiment, we configure the visualizer to display only the ping
traffic between <var>source</var> and <var>destination</var>. (The AODV
visualizers will be disabled.) We'll simulate a longer time period so that nodes
move around in the playground, forcing AODV to find new routes from time to
time.

We use the following configuration for the visualization.

``` {.snippet}
*.visualizer.*.dataLinkVisualizer.displayLinks = true
*.visualizer.*.dataLinkVisualizer.packetFilter = "ping*"
*.visualizer.*.dataLinkVisualizer.fadeOutMode = "simulationTime"
*.visualizer.*.dataLinkVisualizer.fadeOutTime = 5s
```

The following animation illustrates what happens when the simulation is run.

<video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" width="642" height="602" src="Dynamic_v0613.m4v"></video>

The communication ranges of <var>source</var> and <var>destination</var>
are visualized as blue circles.

The video clearly shows the route ping packets are taking between
<var>source</var> and <var>destination</var>. Visualization is triggered by the ping
packets being sent up from the data link layer (wireless interface) of the receiver
node to the network layer (IPv4), where they are routed towards the next hop.

When the existing route breaks due to two nodes drifting away (out of the
communication range of each other), this manifests as link-level failure (ACK
frames do not arrive). This condition is detected by AODV and it starts searching
for a new route. When the new route is found, the ping traffic resumes.

We can observe in the video that the route the ping packets take is not always
optimal (in terms of hop count). The reason is that nodes use an existing route as
long as possible, even when a shorter route becomes available as a result of node
movement. AODV is only activated when the existing route breaks.

## More Information

This example only demonstrated the key features of data link activity
visualization. For more information, refer to the <var>DatalinkVisualizer</var>
NED documentation.

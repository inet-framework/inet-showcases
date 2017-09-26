---
layout: page
title: Visualizing Data Link Activity
---

<script type="text/javascript" src="../../javascripts/imgToFullSize.js" charset="UTF-8"></script>

## Goals

With INET simulations, it is often useful to be able to visualize network traffic.
INET offers several visualizers for this task, operating at various
levels of the network stack. In this showcase, we examine
`DataLinkVisualizer` that can provide graphical feedback about data link
level traffic.

The showcase consists of five simulation models, each demonstrating different
features of the data link activity visualizer.

INET version: `3.6`<br>
Source files location: <a href="https://github.com/inet-framework/inet-showcases/tree/master/visualizer/datalinkactivity" target="_blank">`inet/showcases/visualizer/datalinkactivity`</a>

## About the Visualizer

In INET, data link activity can be visualized by including a
`DataLinkVisualizer` module in the simulation. Adding an
`IntegratedVisualizer` module is also an option, because it also contains a
`DataLinkVisualizer` module. Data link visualization is disabled by
default, it can be enabled by setting the visualizer's `displayLinks`
parameter to true.

`DataLinkVisualizer` is able to observe packets at *service*, *peer* and *protocol* level.
The level where packets are observed can be set by the `activityLevel` parameter.

- At *service* level, those packets are displayed which pass through the data link layer 
(i.e. carry data from/to higher layers).
- At *peer* level, the visualization is triggered by those packets
which are processed inside the link layer in the source node and 
processed inside the link layer in the destination node.
- At *protocol* level, `DataLinkVisualizer` displays those packets 
which are going out at the bottom of link layer in the source node and 
going in at the bottom of the link layer in the destination node.

The activity between two nodes is represented visually by an arrow that points
from the sender node to the receiver node. The arrow appears after the first
packet has been received, then gradually fades out unless it is refreshed by
further packets. The style, color, fading time and other graphical properties can
be changed with parameters of the visualizer.

By default, all packets, interfaces and nodes are considered for the visualization.
This selection can be narrowed to certain packets and/or nodes with the
visualizer's `packetFilter`, `interfaceFilter`, and `nodeFilter` parameters.

## Enabling Visualization of Data Link Activity

The following example shows how to enable the visualization of data link activity,
and what the visualization looks like. In the first example, we configure a simulation
for a wired network. The simulation can be run by choosing the
`EnablingVisualizationWired` configuration from the ini file.

The wired network contains two `StandardHosts`, `wiredSource` and 
`wiredDestination`. The `linkVisualizer` module's type is `DataLinkVisualizer`.

<img src="DataLinkVisualizerSimpleWired.png" class="screen" />

In this configuration, `wiredSource` pings `wiredDestination`. 
Data link activity visualization is enabled by setting the
`displayLinks` parameter to true.

``` {.snippet}
*.linkVisualizer.*.displayLinks = true
```

The following video shows what happens when the simulation is started.

<p><video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" width="722" height="352" src="EnablingVisualizationWired_v0613.m4v"></video></p>

At the beginning of the video, a red strip appears and moves from
`wiredSource` to `wiredDestination`. This strip is the standard
OMNeT++ animation for packet transmissions, and has nothing to do with
`DataLinkVisualizer`. When the packet is received in whole by
`wiredDestination` (the red strip disappears), a dark cyan arrow is added by
`DataLinkVisualizer` between the two hosts, indicating data link
activity. The packet's name is also displayed on the arrow. The arrow fades out
quickly, because the `fadeOutTime` parameter of the visualizer is set
to a small value.

Visualization in a wireless network is very similar. Our next example is the
wireless variant of the above simulation. In this network we use two
`AdhocHosts`, `wirelessSource` and `wirelessDestination`.
The traffic and the visualization settings are the same
as the configuration of the wired example. The simulation can be run by choosing
the `EnablingVisualizationWireless` configuration from the ini file.

<img src="DataLinkVisualizerSimpleWireless.png" class="screen" />

The following animation depicts what happens when the simulation is run.

<p><video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" width="722" height="352" src="EnablingVisualizationWireless_v0613.m4v"></video></p>

This animation is similar to the video of the wired example (apart from an extra
blue dotted line which can be ignored, as it is also part of the standard OMNeT++
packet animation.) Note, however, that the ACK frame does not activate the
visualization, because ACK frames do not pass through data link layer.

## Filtering Data Link Activity

In complex networks with many nodes and several protocols in use, it is often
useful to be able to filter network traffic, and visualize only the part of the
traffic we are interested in.
The following example shows how to set packet filtering in
`DataLinkVisualizer`. This simulation can be run by choosing the
`Filtering` configuration from the ini file.

We use the following network for this showcase.

<img src="DataLinkVisualizerFiltering.png" class="screen" width="900" onclick="imageFullSizeZoom(this);" style="cursor:zoom-in" />

This network consists of four switches (`etherSwitch1..etherSwitch4`)
and six endpoints: two source hosts (`source1`, `source2`), two destination 
hosts (`destination1`, `destination2`) and two other hosts (`host1`, `host2`) 
which are inactive in this simulation. `Source1` pings `destination1`, and 
`source2` pings `destination2`.

For this network, the visualizer's type is `IntegratedVisualizer`. Data
link activity visualization is filtered to display only ping messages. The other
packets, e.g. ARP packets, are not visualized by `DataLinkVisualizer`.
We adjust the `fadeOutMode` and the `fadeOutTime` parameters so that 
the activity arrows do not fade out completely before the next
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
`DataLinkVisualizer` only takes the latter into account, due to the presence
of the `packetFilter` parameter.

<p><video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" width="900" height="651" src="Filtering_v0613.m4v"></video></p>

It also is possible to filter for network nodes. For the following example, let's
assume we want to display traffic between the hosts `source1` and `destination1`
only, along the path `etherSwitch1`, `etherSwitch4` and `etherSwitch2`. 
To this end, we set the visualizer's `nodeFilter` parameter by using the 
following line (note the curly brace syntax used for specifying numeric substrings).

``` {.snippet}
*.visualizer.*.dataLinkVisualizer.nodeFilter = "source1 or etherSwitch{1,4,2} or destination1"
```

This is what it looks like when we run the simulation:

<p><video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" width="900" height="651" src="Filtering2_v0613.m4v"></video></p>

As you can see, visualization allows us to follow the ping packets between
`source1` and `destination1`. Note, however, that ping traffic
between the two other hosts, `source2` and `destination2`, also activates 
the visualization on the link between `etherSwitch1` and `etherSwitch4`.

## Displaying Data Link Activity at Different Levels

The following example demonstrates, how to visualize data link activity at *protocol*,
*peer* and *service* level.
This simulation can be run by selecting the `ActivityLevel` configuration from the ini file.

We use the following wireless network for this example.

<img src="ActivityLevel_v1206.png" class="screen" />

The network consists three `AdhocHost` nodes, `person1`, `person2` and `videoServer`.
`VideoServer` will be streaming a video to `person1`.
`Person2` will be inactive in this example.

The type of the visualizer module is `IntegratedMultiVisualizer`.
Multi-visualizers are compound visualizer modules containing submodule vectors 
of visualizer simple modules. By default, the multi-visualizers contain 
one submodule of each visualizer simple module.
The number of submodules can be specified with parameters for each visualizer submodule.

In this example, data link activity will be displayed at three different levels.
To achieve this, three `DataLinkVisualizer` will be configured, observing packets at *service*, 
*peer* and *protocol* level. They are marked with different colors.
The `visualizer` module is configured as follows.

``` {.snippet}
*.visualizer.*.numDataLinkVisualizers = 3
*.visualizer.*.dataLinkVisualizer[*].displayLinks = true
*.visualizer.*.dataLinkVisualizer[*].packetFilter = "*Video*"
*.visualizer.*.dataLinkVisualizer[*].fadeOutMode = "animationTime"
*.visualizer.*.dataLinkVisualizer[*].holdAnimationTime = 1s
*.visualizer.*.dataLinkVisualizer[0].activityLevel = "protocol"
*.visualizer.*.dataLinkVisualizer[0].lineColor = "purple"
*.visualizer.*.dataLinkVisualizer[0].labelColor = "purple"
*.visualizer.*.dataLinkVisualizer[1].activityLevel = "peer"
*.visualizer.*.dataLinkVisualizer[1].lineColor = "blue"
*.visualizer.*.dataLinkVisualizer[1].labelColor = "blue"
*.visualizer.*.dataLinkVisualizer[2].activityLevel = "service"
*.visualizer.*.dataLinkVisualizer[2].lineColor = "green"
*.visualizer.*.dataLinkVisualizer[2].labelColor = "green"
```

By using the `numDataLinkVisualizers` parameter, we set three `DataLinkVisualizer` modules.
In this example, we are interested in *video* packets. To highlight them, 
we use the `packetFilter` parameter.
The `fadeOutMode` parameter specifies that inactive links fade out in animation time.
The `holdAnimationTime` parameter stops the animation for a while,
delaying the fading of the data link activity arrows.
The `activityLevel`, `lineColor` and `labelColor` parameters are different
at each `DataLinkVisualizer` to make data link activity levels easy to distinguish:

- `dataLinkVisualizer[0]` is configured to display 
<span style="color:purple">*protocol* level activity</span> with purple arrows.
- `dataLinkVisualizer[1]` is configured to display 
<span style="color:blue">*peer* level activity</span> with blue arrows,
- `dataLinkVisualizer[2]` is configured to display 
<span style="color:green">*service* level activity</span> with green arrows,

The following video shows what happens when the simulation is running.

<p><video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" width="900" height="651" src="ActivityLevel_v0104.mp4"></video></p>

At the beginning of the video, `person1` sends a `VideoStrmReq` packet, 
requesting the video stream.
In response to this, `videoServer` starts to send video stream packet fragments to `person1`.
The packets are fragmented because their size is greater than the Maximum Transmission Unit. 
The first packet fragment, `VideoStrmPk-frag0` causes data link activity only 
at *protocol* level and at *peer* level, because other packet fragments are required
to allow the packet to be forwarded to higher layers.
When `VideoStrmPk-frag1` is received by `person1`, the packet is reassembled in 
and is sent to the upper layers. As a result of this, a green arrow is displayed 
between `videoServer` and `person1`, representing data link activity at *service* level.

An other phenomenon can also be observed in the video.
There is *protocol* level data link activity between `person2` and the other nodes.
This is, because frames are also received in the physical layer of `person2`, 
but they are dropped at data link layer level because they are not addressed to `person2`.

## Visualizing Data Link Activity in a Mobile Ad-Hoc Network

The following simulation shows how visualization can help you to follow
dynamically changing data link activity in a wireless environment. The simulation
can be run by choosing the `Dynamic` configuration from the ini file.

We use the following network for this simulation:

<img src="DataLinkVisualizerDynamic.png" class="screen" />

Nodes are of the type `AodvRouter`, and are placed randomly on the
playground. The communication range of the nodes is chosen so that the network
is connected, but nodes can typically only communicate by using multi-hop paths.
The nodes will also randomly roam within predefined borders. The routing
protocol is AODV. During the simulation, the `source` node will be
pinging the `destination` node.

In our first experiment, the goal is to visualize the operation of the AODV protocol
as it sets up a route from `source` to `destination`. We
expect to see the following. As long as `source` has a valid route
towards `destination`, AODV is inactive. When a new route is needed
towards `destination`, `source` starts to flood the network
with AODV route request (RREQ) messages. RREQ messages propagate through
the intermediate nodes until one of them reaches the `destination`
node. The route is made available by unicasting AODV route reply (RREP)
messages back to the originator of the RREQ messages. Reception of the RREP
message in each host results in the node updating its routing table with the next
hop address towards the destination node.

As AODV operates with two message types, we'll use two
`DataLinkVisualizer` modules configured to use two different colors.

``` {.snippet}
*.rreqVisualizer.*.displayLinks = true
*.rreqVisualizer.*.packetFilter = "AodvRreq"
*.rreqVisualizer.*.fadeOutMode = "simulationTime"
*.rreqVisualizer.*.fadeOutTime = 0.002s
*.rrepVisualizer.*.displayLinks = true
*.rrepVisualizer.*.packetFilter = "AodvRrep"
*.rrepVisualizer.*.fadeOutMode = "simulationTime"
*.rrepVisualizer.*.fadeOutTime = 5s
*.rrepVisualizer.*.lineColor = "blue"
*.rrepVisualizer.*.labelColor = "blue"
```

The following video has been captured from the simulation, and allows us to
observe the AODV protocol in action. The dark cyan arrows indicate RREQ packets
which flood the network. When an RREQ message reaches
`destination`, `destination` sends an RREP message (blue arrow)
back towards `source`. Note that nodes appear stationary because the
whole process takes place in a very short time period.

<p><video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" width="642" height="602" src="AODV_v0614.m4v"></video></p>

In the second experiment, we configure the visualizer to display only the ping
traffic between `source` and `destination`. (The AODV
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

<p><video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" width="642" height="602" src="Dynamic_v0613.m4v"></video></p>

The communication ranges of `source` and `destination`
are visualized as blue circles.

The video clearly shows the route ping packets are taking between
`source` and `destination`. Visualization is triggered by the ping
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

This example only demonstrates the key features of data link activity
visualization. For more information, refer to the `DatalinkVisualizer`
NED documentation.

## Discussion

Use <a href="https://github.com/inet-framework/inet-showcases/issues/12"
target="_blank">this page</a> in the GitHub issue tracker for commenting on
this showcase.


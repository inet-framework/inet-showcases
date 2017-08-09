---
layout: page
title: Visualizing Network Path Activity
hidden: true
---

## Goals

In INET simulations, it is often useful to be able to visualize traffic between
network nodes. INET offers several visualizers for this task, operating at various
levels of the network stack. In this showcase, we examine
`NetworkRouteVisualizer` that can provide graphical feedback about
network layer level traffic.

The showcase consists of four simulation models, each demonstrating different
features of network path activity visualization.

INET version: `3.6`<br>
Source files location: <a href="https://github.com/inet-framework/inet-showcases/tree/master/visualizer/networkpathactivity" target="_blank">`inet/showcases/visualizer/networkpathactivity`</a>

## About the Visualizer

In INET, network path activity can be visualized by including a
`NetworkRouteVisualizer` module in the simulation. Adding an
`IntegratedVisualizer` module is also an option, because it also contains a
`NetworkRouteVisualizer` module. Network path activity visualization
is disabled by default, it can be enabled by setting the visualizer's
`displayRoutes` parameter to true.

`NetworkRouteVisualizer` currently observes packets that pass
through the network layer (i.e. carry data from/to higher layers), but not those
that are internal to the operation of the network layer protocol. That is, packets
such as ARP, although potentially useful, will not trigger the visualization.
Visualizing such packets may be implemented in future INET revisions.

The activity between two nodes is represented visually by a polyline arrow which
points from the source node to the destination node.
`NetworkRouteVisualizer` follows packet throughout its path so the polyline
goes through all nodes that are part of the packet's path. The arrow appears after
the first packet has been received, then gradually fades out unless it is reinforced
by further packets. Color, fading time and other graphical properties can be
changed with parameters of the visualizer.

By default, all packets and nodes are considered for the visualization. This
selection can be narrowed with the visualizer's `packetFilter` and
`nodeFilter` parameters.

## Enabling Visualization of Network Path Activity

The following example shows how to enable the network path activity visualization
with its default settings. For the first example, we configured a wired network. The
simulation can be run by choosing the `EnablingVisualization`
configuration from the ini file.

The network contains two `StandardHosts`, a `source`
host and a `destination` host. In this configuration, the
`source` host will be pinging the `destination` host.

<img src="NetworkPathSimple.png" class="screen" />

The `pathVisualizer's` type is `NetworkRouteVisualizer`.
We enable network path activity visualization by setting the
`displayRoutes` parameter to true.

``` {.snippet}
*.pathVisualizer.*.displayRoutes = true
```

The following video shows what happens when we start the simulation.

<video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" width="622" height="352" src="EnablingVisualization_v0614.m4v"></video>

At the beginning of the video, a red strip appears and moves from
`source` to `destination`. This strip is the standard OMNeT++
animation for packet transmissions, and has nothing to do with
`NetworkRouteVisualizer`. When the packet is received in whole by
`destination` (the red strip disappears), an arrow is added by
`NetworkRouteVisualizer` between the two hosts, indicating network path
activity. The packet's name is also displayed on the arrow. The arrow fades out
quickly, because the `fadeOutTime` parameter of the visualizer is set
to a small value.

Note, however, that ARP traffic does not activate the visualization, because ARP
packets do not pass through the network layer.

## Filtering Network Path Activity

In complex networks where many nodes are placed and several protocols are
used, it is often useful to be able to filter network traffic to visualize only the part
of the network traffic we are interested in.

The following example shows how to set packet filtering. This simulation can be
run by choosing the `StaticNetworkPaths` configuration from the ini
file.

We use the following network for this showcase:

<img src="NetworkPathComplex_v0703.png" class="screen" width="900" onclick="imageFullSizeZoom(this);" style="cursor:zoom-in" />

The network consists of five `routers` (`router0..router4`),
four `etherSwitches` (`etherSwitch0..etherSwitch3`) and
eight `StandardHosts`. There are two source hosts,
`source1` and `source2`, which will be pinging the two
destination hosts, `destination1` and `destination2`. The
`videoServer` node streams a video to the `videoClient`
node. The remaining two endpoints (`host1` and `host2`)
are inactive in this simulation.

For this network, the visualizer's type is `IntegratedVisualizer`.
Network path visualization is filtered to display only ping traffic. The video stream
packets are not visualized by network path activity visualizer. We adjust the
`fadeOutMode` and the `fadeOutTime` parameters, so
network path activity arrow does not fade out completely before the next ping
packet arrives.

``` {.snippet}
*.visualizer.*.networkRouteVisualizer.displayRoutes = true
*.visualizer.*.networkRouteVisualizer.packetFilter = "ping*"
*.visualizer.*.networkRouteVisualizer.fadeOutMode = "simulationTime"
*.visualizer.*.networkRouteVisualizer.fadeOutTime = 1.4s
```

The following video shows what happens, when the simulation is run.

<video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" width="900" height="664" src="StaticNetworkPaths_v0703.m4v"></video>

Each arrow has a different color indicating different paths. You can see that
although there is both video stream and ping traffic in the network,
`NetworkRouteVisualizer` displays only the latter, due to the presence of the
`packetFilter` parameter.

## Visualizing Network Path Activity in a Mobile Ad-Hoc Network

The following example shows how visualization can help you to follow dynamically
changing network path activity in a wireless environment. A simulation is created
for this example, that can be run by choosing the `Mobile`
configuration from the ini file.

Nodes are of the type `AODVRouter`, and are placed randomly on the
playground. One of the nodes is the `source` node which will be
pinging the `destination` node. The communication range of the
nodes is chosen so that the network is connected, but nodes can typically only
communicate by using multi-hop paths. The nodes will also randomly roam within
predefined borders.

<img src="NetworkPathMobileShowcase_v0606.png" class="screen" />

The routing protocol is AODV. It works as follows: As long as `source`
has a valid route towards `destination`, AODV is inactive. When a new
route is needed towards `destination`, for example
`source` wants to send a packet to `destination`,
`source` starts to flood the network with AODV route request (RREQ)
messages. RREQ messages propagate through the intermediate nodes until one of
them reaches the `destination` node. The route is made available by
unicasting AODV route reply (RREP) messages back to the originator of the RREQ
messages. (You can watch a video about AODV route searching process in the
`Data Link Activity` showcase, in the `Visualizing Data Link
Activity in a Mobile Ad-Hoc Network` configuration.)

We use the following configuration for the visualization.

``` {.snippet}
*.visualizer.*.networkRouteVisualizer.displayRoutes = true
*.visualizer.*.networkRouteVisualizer.packetFilter = "ping*"
*.visualizer.*.networkRouteVisualizer.fadeOutMode = "simulationTime"
*.visualizer.*.networkRouteVisualizer.fadeOutTime = 5s
```

The following video shows what happens when the simulation is run.

<video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" width="682" height="732" src="Mobile_v0614.m4v"></video>

Blue circles are displays the communication range of `source` and
`destination`.

The video shows the network path ping packets are taking between
`source` and `destination`. Ping packets are forwarded to the
next hop until they reach `destination`. The network path activity is
visualized after the ping packet has arrived to `destination` so we get
information about the path changes immediately.

When the existing route breaks due to two nodes drifting away (going out of the
communication range of each other), this manifests as link-level failure. This
condition is detected by AODV and it starts searching for a new route. When the
new route is found, the ping traffic resumes.

You can observe in the video that the route the ping packets take is not always
optimal (in terms of hop count). The reason is that nodes use an existing route as
long as possible, even when a shorter route becomes available as a result of node
movement. AODV is only activated when the existing route breaks.

## Displaying Network Path Activity in a Complex Network

This configuration demonstrates how the visualizer reacts to the routing changes
in a complex network. A simulation is created for this example. The simulation can
be run by choosing the `ChangingPaths` configuration from the ini
file.

The network contains four routers (`router0..router3`) which are
connected so as to create redundant network paths. The network also contains six
hosts. There are a wired and a wireless source-destination pair. The remaining two
hosts are inactive in this simulation. The wired hosts are connected to the routers
via switches (`etherSwitch0` and `etherSwitch1`), the
wireless hosts are connected to the routers via access points (
`accessPoint0` and `accessPoint1`).

The following image displays the network for this example.

<img src="NetworkPathChanging.png" class="screen" width="900" onclick="imageFullSizeZoom(this);" style="cursor:zoom-in" />

We assign IP addresses manually by creating a configuration file (
`configuration.xml`). A lifecycle is also created (
`changeRoute.xml`) for this configuration to turn off and on the routers at a
certain time. Network routes will change dynamically, because RIP routing
protocol is used in this example. During the simulation, `wiredSource`
will be pinging `wiredDestination` and `wirelessSource`
will be pinging `wirelessDestination`.

In this showcase, we set the `packetFilter` parameter to display only
ICMP echo traffic. We use the following configuration for the visualization.

``` {.snippet}
*.visualizer.*.networkRouteVisualizer.displayRoutes = true
*.visualizer.*.networkRouteVisualizer.packetFilter = "ping* and not *reply"
*.visualizer.*.networkRouteVisualizer.fadeOutMode = "simulationTime"
*.visualizer.*.networkRouteVisualizer.fadeOutTime = 1.4s
```

In the following video we can examine that how network path activity visualization follows the routing changes in a complex network.

<video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" width="900" height="610" src="ChangingPaths_v0614.m4v"></video>

In the beginning of the video, ping traffic goes towards `router1`.
After five seconds small cogwheels appear above `router1`
then cogwheels change to a red cross, indicating `router1`
went offline.

Routers update their routing tables in no time by using RIP routing protocol.
In the next few seconds, the traffic goes towards `router3`
between the sources and the destinations. While ping traffic goes towards
`router3`, `router1` turns on again (the red cross
disappears). In the 15th second, you can see that `router3` goes offline. 
Routing tables are updated by using RIP and as a result of this, ping traffic 
goes through `router1` again. At the end of the video, `router3`
turns on, but it does not have an effect on the network traffic.


## More Information

This example only demonstrated the key features of network path visualization.
For more information, refer to the `NetworkRouteVisualizer` NED
documentation.

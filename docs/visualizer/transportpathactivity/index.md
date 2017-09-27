---
layout: page
title: Visualizing Transport Path Activity
---

## Goals

With INET simulations, it is often useful to be able to visualize network traffic.
INET provides several visualizers for this task, operating at various levels of the
network stack. In this showcase, we examine `TransportRouteVisualizer` 
that can provide graphical feedback about transport traffic, i.e. traffic that
passes through the transport layers of two endpoints.  

<!-- TODO it would be more natural to be able to say "traffic between the transport 
layers of two endpoints", but *unfortunately* that would not be true -->

The showcase consists of two simulation models, both demonstrating different
features of the transport path activity visualizer.

INET version: `3.6`<br>
Source files location: <a href="https://github.com/inet-framework/inet-showcases/tree/master/visualizer/transportpathactivity" target="_blank">`inet/showcases/visualizer/transportpathactivity`</a>

## About the Visualizer

In INET, transport path activity can be visualized by including a
`TransportRouteVisualizer` module in the simulation. Adding an
`IntegratedVisualizer` is also an option, because it also contains a
`TransportRouteVisualizer`. Transport path activity visualization is disabled
by default, it can be enabled by setting the visualizer's
`displayRoutes` parameter to true.

`TransportRouteVisualizer` observes packets that pass through the
transport layer, i.e. carry data from/to higher layers.

The activity between two nodes is represented visually by a polyline arrow which
points from the source node to the destination node.
`TransportRouteVisualizer` follows packets throughout their path so that the
polyline goes through all nodes which are the part of the path of packets. The
arrow appears after the first packet has been received, then gradually fades out
unless it is reinforced by further packets. Color, fading time and other graphical
properties can be changed with parameters of the visualizer.

By default, all packets and nodes are considered for the visualization. This
selection can be narrowed with the visualizer's `packetFilter` and
`nodeFilter` parameters.

## Enabling Visualization of Transport Path Activity

The following example shows how to enable transport path activity visualization
with its default settings. In the first example, we configure a simulation for a wired
network. This simulation can be run by choosing the
`EnablingPathVisualizationWired` configuration from the ini file.

The wired network contains two connected `StandardHost` type
nodes: `source` and `destination`.

<img src="TransportPathVisualizerSimpleWired_v0615.png" class="screen" />

The `source` node will be continuously sending UDP packets to the
`destination` node by using a `UDPBasicApp` application.

In this simulation, `pathVisualizer's` type is
`TransportRouteVisualizer`. It is enabled by setting the
`displayRoutes` parameter to true.

``` {.snippet}
*.pathVisualizer.*.displayRoutes = true
```

The following video shows what happens when the simulation is run.

<p><video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" width="522" height="352" src="EnablingPathVisualizationWired_v0615.m4v"></video></p>

At the beginning of the video, a red strip appears and moves from
`source` to `destination`. This strip is the standard OMNeT++
animation for packet transmissions, and has nothing to do with
`TransportRouteVisualizer`. When the packet is received in whole by
`destination` (the red strip disappears), an arrow is added by
`TransportRouteVisualizer` between the two hosts, indicating transport path
activity. The packet's name is also displayed above the arrow.

Note, however, that the ARP packets do not activate the visualization, because ARP
packets do not pass through the transport layer. The transport path activity arrow
fades out quickly, because the `fadeOutTime` parameter of the
visualizer is set to a small value.

Our next simulation model is the wireless variant of the above example. In this
network, we use two `AdhocHosts`. The traffic and the visualization
settings are the same as the configuration of the wired example. The simulation
can be run by choosing the `EnablingPathVisualizationWireless`
configuration from the ini file.

Here is the network for the wireless configuration.

<img src="TransportPathVisualizerSimpleWireless_v0615.png" class="screen" />

The following video shows what happens when the simulation is run.

<p><video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" width="522" height="352" src="EnablingPathVisualizationWireless_v0615.m4v"></video></p>

This animation is similar to the video of the wired example (apart from an extra
blue dotted line which is also part of the standard OMNeT++ packet animation).
Note, however, that the ACK and ARP frames do not activate the visualization,
because these frames do not pass through transport layer.

## Filtering Transport Path Activity

In complex networks where many nodes and several protocols are used, it is often
useful to be able to filter network traffic, and visualize only the part of the network
traffic we are interested in.

In this simulation, we show how to use `packetFilter` and
`nodeFilter`. The simulation can be run by choosing the
`Filtering` configuration from the ini file.

We set up a complex network with five `routers` (`router0..router4`), 
four `etherSwitches` (`switch0..switch4`) and eight endpoints. 
The source nodes (`source1` and `source2`) are continuously 
generating traffic by a `UDPBasicApp` application, which is handled by a
`UDPSink` application in the destination nodes (`destination1`
and `destination2`). `VideoStreamServer` streams video
(sends `VideoStrmPK-frag` packets) to
`videoStreamClient`. The remaining two endpoints (`host1` and
`host2`) are inactive in this simulation.

<img src="TransportPathVisualizerFiltering_v0615.png" class="screen" width="900" onclick="imageFullSizeZoom(this);" style="cursor:zoom-in" />

In our first experiment, we want observe the traffic generated by
`UDPBasicApp`. For this reason, we configure the visualizer's
`packetFilter` parameter to display only the `UDPBasicAppData`
packets. Video stream traffic will not be visualized by transport path activity
visualizer. We adjust the visualizer's `fadeOutMode` and the
`fadeOutTime` parameters so that the transport path activity arrow does not
fade out completely before the next `UDPBasicAppData` packet is
arrived.

``` .{snippet}
*.visualizer.*.transportRouteVisualizer.displayRoutes = true
*.visualizer.*.transportRouteVisualizer.fadeOutMode = "simulationTime"
*.visualizer.*.transportRouteVisualizer.fadeOutTime = 1.2s
*.visualizer.*.transportRouteVisualizer.packetFilter = "*UDPBasicAppData*"
```

The following video has been captured from the simulation, and shows what
happens if `packetFilter` is set.

<p><video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" width="900" height="664" src="Filtering_PacketFilter_v0615.m4v"></video></p>

You can see that although there are both video stream and
`UDPBasicAppData` traffic in the network,
`TransportPathVisualizer` displays only the latter, due to the presence of the
`packetFilter` parameter.

In the first experiment, we filtered network traffic based on packets. In INET, it is
also possible to filter traffic based on network nodes. In our second experiment,
we want to display traffic only between `source1` and
`destination1`. For this reason, we set the visualizer's
`nodeFilter` parameter to display only the part of the traffic between
`source1` and `destination1`. `PacketFilter` is still
enabled in this simulation so that video stream will not be visualized.

We add the following line to the configuration:

``` {.snippet}
*.visualizer.*.transportRouteVisualizer.nodeFilter = "source1 or switch* or router* or destination1"
```

The following video has been captured from the simulation, and shows what
happens if `nodeFilter` is set.

<p><video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" width="900" height="664" src="Filtering_NodeFilter_v0615.m4v"></video></p>

If you observe the default OMNeT++ packet transmission animation (red stripes),
you can see that although there is UDP data traffic between both source-
destination pair, but the traffic is visualized only between `source1`
and `destination1` because of the `nodeFilter` parameter
setting.

## More Information

This example only demonstrates the key features of transport path visualization.
For more information, refer to the `TransportRouteVisualizer` NED
documentation.

## Discussion

Use <a href="https://github.com/inet-framework/inet-showcases/issues/10"
target="_blank">this page</a> in the GitHub issue tracker for commenting on
this showcase.

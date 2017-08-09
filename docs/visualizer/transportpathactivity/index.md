---
layout: page
title: Visualizing Transport Path Activity
---

## Goals

In INET simulations, it is often useful to show network traffic between nodes. INET
provides several visualizers for this task, operating at various levels of the
network stack. In this showcase, we examine <var>TransportRouteVisualizer</var> 
that can provide graphical feedback about transport layer level traffic.

The showcase consists of simulation models, demonstrating important features of
transport path activity visualization.

INET version: <var>3.6</var><br>
Source files location: <a href="https://github.com/inet-framework/inet-showcases/tree/master/visualizer/transportpathactivity" target="_blank"><var>inet/showcases/visualizer/transportpathactivity</var></a>

## About the Visualizer

In INET, transport path activity can be visualized by including a
<var>TransportRouteVisualizer</var> module in the simulation. Adding an
<var>IntegratedVisualizer</var> is also an option, because it also contains a
<var>TransportRouteVisualizer</var>. Transport path activity visualization is disabled
by default, it can be enabled by setting the visualizer's
<var>displayRoutes</var> parameter to true.

<var>TransportRouteVisualizer</var> observes packets that pass through the
transport layer i.e. carry data from/to higher layers.

The activity between two nodes is represented visually by a polyline arrow which
points from the source node to the destination node.
<var>TransportRouteVisualizer</var> follows packets throughout their path so that the
polyline goes through all nodes which are the part of the path of packets. The
arrow appears after the first packet has been received, then gradually fades out
unless it is reinforced by further packets. Color, fading time and other graphical
properties can be changed with parameters of the visualizer.

By default, all packets and nodes are considered for the visualization. This
selection can be narrowed with the visualizer's <var>packetFilter</var> and
<var>nodeFilter</var> parameters.

## Enabling Visualization of Transport Path Activity

The following example shows how to enable transport path activity visualization
with its default settings. In the first example, we configure a simulation for a wired
network. This simulation can be run by choosing the
<var>EnablingPathVisualizationWired</var> configuration from the ini file.

The wired network contains two connected <var>StandardHost</var> type
nodes: <var>source</var> and <var>destination</var>.

<img src="TransportPathVisualizerSimpleWired_v0615.png" class="screen" />

The <var>source</var> node will be continuously sending UDP packets to the
<var>destination</var> node by using a <var>UDPBasicApp</var> application.

In this simulation, <var>pathVisualizer's</var> type is
<var>TransportRouteVisualizer</var>. It is enabled by setting the
<var>displayRoutes</var> parameter to true.

``` {.snippet}
*.pathVisualizer.*.displayRoutes = true
```

Here is what happens when the simulation is run.

<video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" width="522" height="352" src="EnablingPathVisualizationWired_v0615.m4v"></video>

At the beginning of the video, a red strip appears and moves from
<var>source</var> to <var>destination</var>. This strip is the standard OMNeT++
animation for packet transmissions, and has nothing to do with
<var>TransportRouteVisualizer</var>. When the packet is received in whole by
<var>destination</var> (the red strip disappears), an arrow is added by
<var>TransportRouteVisualizer</var> between the two hosts, indicating transport path
activity. The packet's name is also displayed above the arrow.

Note, however, that the ARP packets do not activate the visualization, because ARP
packets do not pass through transport layer. The transport path activity arrow
fades out quickly, because the <var>fadeOutTime</var> parameter of the
visualizer is set to a small value.

Our next simulation model is the wireless variant of the above example. In this
network, we use two <var>AdhocHosts</var>. The traffic and the visualization
settings are the same as the configuration of the wired example. The simulation
can be run by choosing the <var>EnablingPathVisualizationWireless</var>
configuration from the ini file.

Here is the network for the wireless configuration.

<img src="TransportPathVisualizerSimpleWireless_v0615.png" class="screen" />

The following video shows what happens when the simulation is run.

<video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" width="522" height="352" src="EnablingPathVisualizationWireless_v0615.m4v"></video>

This animation is similar to the video of the wired example (apart from an extra
blue dotted line which is also part of the standard OMNeT++ packet animation).
Note, however, that the ACK and ARP frames do not activate the visualization,
because these frames do not pass through transport layer.

## Filtering Transport Path Activity

In complex networks where many nodes and several protocols are used, it is often
useful to be able to filter network traffic, and visualize only the part of the network
traffic we are interested in.

In this simulation, we show how to use <var>packetFilter</var> and
<var>nodeFilter</var>. The simulation can be run by choosing the
<var>Filtering</var> configuration from the ini file.

We set up a complex network with five <var>routers</var> (<var>router0..router4</var>), 
four <var>etherSwitches</var> (<var>switch0..switch4</var>) and eight endpoints. 
The source nodes (<var>source1</var> and <var>source2</var>) are continuously 
generating traffic by a <var>UDPBasicApp</var> application, which is handled by a
<var>UDPSink</var> application in the destination nodes (<var>destination1</var>
and <var>destination2</var>). <var>VideoStreamServer</var> streams video
(sends <var>VideoStrmPK-frag</var> packets) to
<var>videoStreamClient</var>. The remaining two endpoints (<var>host1</var> and
<var>host2</var>) are inactive in this simulation.

<img src="TransportPathVisualizerFiltering_v0615.png" class="screen" width="900" onclick="imageFullSizeZoom(this);" style="cursor:zoom-in" />

In our first experiment, we want observe the traffic generated by
<var>UDPBasicApp</var>. For this reason, we configure the visualizer's
<var>packetFilter</var> parameter to display only the <var>UDPBasicAppData</var>
packets. Video stream traffic will not be visualized by transport path activity
visualizer. We adjust the visualizer's <var>fadeOutMode</var> and the
<var>fadeOutTime</var> parameters so that the transport path activity arrow does not
fade out completely before the next <var>UDPBasicAppData</var> packet is
arrived.

``` .{snippet}
*.visualizer.*.transportRouteVisualizer.displayRoutes = true
*.visualizer.*.transportRouteVisualizer.fadeOutMode = "simulationTime"
*.visualizer.*.transportRouteVisualizer.fadeOutTime = 1.2s
*.visualizer.*.transportRouteVisualizer.packetFilter = "*UDPBasicAppData*"
```

The following video has been captured from the simulation, and shows what
happens if <var>packetFilter</var> is set.

<video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" width="900" height="664" src="Filtering_PacketFilter_v0615.m4v"></video>

You can see that although there are both video stream and
<var>UDPBasicAppData</var> traffic in the network,
<var>TransportPathVisualizer</var> displays only the latter, due to the presence of the
<var>packetFilter</var> parameter.

In the first experiment, we filtered network traffic based on packets. In INET, it is
also possible to filter traffic based on network nodes. In our second experiment,
we want to display traffic only between <var>source1</var> and
<var>destination1</var>. For this reason, we set the visualizer's
<var>nodeFilter</var> parameter to display only the part of the traffic between
<var>source1</var> and <var>destination1</var>. <var>PacketFilter</var> is still
enabled in this simulation so that video stream will not be visualized.

We add the following line to the configuration:

``` {.snippet}
*.visualizer.*.transportRouteVisualizer.nodeFilter = "source1 or switch* or router* or destination1"
```

The following video has been captured from the simulation, and shows what
happens if <var>nodeFilter</var> is set.

<video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" width="900" height="664" src="Filtering_NodeFilter_v0615.m4v"></video>

If you observe the default OMNeT++ packet transmission animation (red stripes),
you can see that although there is UDP data traffic between both source-
destination pair, but the traffic is visualized only between <var>source1</var>
and <var>destination1</var> because of the <var>nodeFilter</var> parameter
setting.

## More Information

This example only demonstrated the key features of transport path visualization.
For more information, refer to the <var>TransportRouteVisualizer</var> NED
documentation.

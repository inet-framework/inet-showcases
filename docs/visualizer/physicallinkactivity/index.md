---
layout: page
title: Visualizing Physical Link Activity
hidden: true
---

## Goals

In INET simulations, it is often advantageous to be able to show traffic between
network nodes. For this task, there are several visualizers in INET, operating at
various levels of the network stack. In this showcase, we demonstrate working of
<var>PhysicalLinkVisualizer</var> that can provide graphical feedback about
physical layer level traffic.

The showcase consists of three simulation models each demonstrating different
features of physical link visualization.

INET version: <var>3.6</var><br>
Source files location: <a href="https://github.com/inet-framework/inet-showcases/tree/master/visualizer/physicallinkactivity" target="_blank"><var>inet/showcases/visualizer/physicallinkactivity</var></a>

## About the Visualizer

In INET, physical link activity can be visualized by including a
<var>PhysicalLinkVisualizer</var> module in the simulation. Adding an
<var>IntegratedVisualizer</var> module is also an option, because it also contains a
<var>PhysicalLinkVisualizer</var> module. Physical link activity visualization is
disabled by default, it can be enabled by setting the visualizer's
<var>displayLinks</var> parameter to true.

<var>PhysicalLinkVisualizer</var> observes frames that pass through the
physical layer, i.e. are received correctly.

The activity between two nodes is represented visually by a dotted arrow which
points from the sender node to the receiver node. The arrow appears after the
first frame has been received, then gradually fades out unless it is refreshed by
further frames. Color, fading time and other graphical properties can be changed
with parameters of the visualizer.

By default, all packets, interfaces and nodes are considered for the visualization.
This selection can be narrowed with the visualizer's <var>packetFilter</var>,
<var>interfaceFilter</var>, and <var>nodeFilter</var> parameters.

## Enabling Visualization of Physical Link Activity

The following example shows how to enable the visualization of physical link
activity with its default settings. In this example, we configure a simulation for an
ad-hoc wireless network. The simulation can be run by choosing the
<var>EnablingVisualization</var> configuration from the ini file.

The network contains two <var>AdhocHosts</var>, <var>source</var> and
<var>destination</var>. The <var>linkVisualizer's</var> type is
<var>PhysicalLinkVisualizer</var>. In this simulation, <var>source</var> will be
pinging <var>destination</var>.

<img src="PhysicalLinkVisualizerSimple.png" class="screen" />

Physical link activity visualization is enabled by setting the
<var>displayLinks</var> parameter to true.

``` {.snippet}
*.linkVisualizer.*.displayLinks = true
```

The following animation shows what happens when we start the simulation.

<video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" width="622" height="402" src="EnablingVisualization_v0614.m4v"></video>

At the beginning of the animation, a red strip appears and moves from
<var>source</var> to <var>destination</var>. This strip is the standard OMNeT++
animation for packet transmissions, and has nothing to do with
<var>PhysicalLinkVisualizer</var>. A blue dotted line also appears at the same time. It
can be ignored, as it is also part of the standard OMNeT++ animation for packet
transmission. When the frame is received in whole by <var>destination</var>
(the red strip disappears), a dotted arrow is added by
<var>PhysicalLinkVisualizer</var> between the two hosts, indicating physical link
activity. The frame's name is also displayed on the arrow. In this simulation, the
arrow fades out quickly, because the <var>fadeOutTime</var> parameter of the
visualizer is set to a small value.

## Filtering Physical Link Activity

In complex networks with many nodes and several protocols in use, it is often
useful to be able to filter network traffic, and visualize only the part of the traffic
we are interested in.

The following example shows how to set packet filtering. A simulation is created
for this example. It can be run by choosing the <var>Filtering</var>
configuration from the ini file.

We configure a wifi infrastructure mode network for this showcase. The network
consists of one <var>accessPoint</var> and three <var>wirelessHosts</var>
(<var>source</var>, <var>destination</var> and <var>host1</var>). In this
configuration, the <var>source</var> host will be pinging the
<var>destination</var> host. The <var>host1</var> node does not generate any
traffic except for connect to <var>accessPoint</var>.

The communication ranges of the nodes (blue circles in the picture) are reduced
so that <var>source</var> and <var>destination</var> can not receive frames
correctly from each other.

<img src="Filtering_sh_all_comm_ranges.png" class="screen" width="900" onclick="imageFullSizeZoom(this);" style="cursor:zoom-in" />

For this network, the type of <var>visualizer</var> module is
<var>IntegratedVisualizer</var>. Physical link activity visualization is filtered to display
only ping traffic. Other frames, e.g. Beacon frames and ACK frames, are not
displayed by <var>PhysicalLinkVisualizer</var>.

We use the following configuration for the visualization.

``` {.snippet}
*.visualizer.*.physicalLinkVisualizer.displayLinks = true
*.visualizer.*.physicalLinkVisualizer.packetFilter = "ping*"
*.visualizer.*.physicalLinkVisualizer.fadeOutTime = 5s
```

The following video shows what happens when the simulation is run. The video is
captured from the simulation after endpoints have associated with
<var>accessPoint</var>.

<video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" width="802" height="432" src="Filtering_v0614.m4v"></video>

You can see that although there are also ACK frames, Beacon frames and ping
traffic in the network, <var>PhysicalLinkVisualizer</var> displays only the latter,
due to the presence of <var>packetFilter</var>. The ping frames travel between
<var>source</var> and <var>destination</var> through
<var>accessPoint</var>, but <var>host1</var> also receives ping frames from
<var>accessPoint</var> and <var>source</var>. This is, because <var>host1</var>
is within the communication range of <var>source</var> and
<var>accessPoint</var>.

## Physical Link Activity in a Mobile Ad-Hoc Network

The goal of this simulation is visualizing dynamically changing physical link
activity in a mobile wireless environment. This simulation can be run by choosing
the <var>Mobile</var> configuration from the ini file.

The network consists of seven nodes (<var>host1..host7</var>) are type of
<var>AdhocHost</var>. The nodes are placed randomly on the playground and
will also randomly roam within predefined borders. The communication range of
nodes is reduced so that nodes can typically communicate only with some closer
nodes.

<img src="PhysicalLinkVisualizerDynamic.png" class="screen" />

The nodes send UDP packets in every second by an <var>UDPBasicApp</var>
application. The packets' name are set to <var>Broadcast</var>. The nodes
manage the received <var>Broadcast</var> packets by an <var>UDPSink</var>
application.

The visualizer's <var>packetFilter</var> parameter is set to display only
<var>Broadcast</var> traffic.

Here is the configuration of the visualization.

``` {.snippet}
*.visualizer.*.physicalLinkVisualizer.displayLinks = true
*.visualizer.*.physicalLinkVisualizer.packetFilter = "*Broadcast*"
*.visualizer.*.physicalLinkVisualizer.fadeOutMode = "simulationTime"
*.visualizer.*.physicalLinkVisualizer.fadeOutTime = 5s
```

Here is what happens, when we run the simulation.

<video autoplay loop controls onclick="this.paused ? this.play() : this.pause();" width="682" height="732" src="Mobile_v0614.m4v"></video>

Here, physical link activity looks like connection graphs in which the vertices are
hosts, and each edge is physical link activity between two hosts. It is changing
between which nodes there is physical link activity, as a result of the nodes'
movement. When two nodes drifting away (out of the communication range of
each other), the physical link is broken between them. If two nodes go within each
other's communication range, there will be physical link activity between them.

## More Information

This example only demonstrated the key features of physical link visualization.
For more information, refer to the <var>PhysicalLinkVisualizer</var> NED
documentation.

---
layout: page
title: Visualizing IEEE 802.11 Network Membership
---

Goals
-----

When simulating wifi networks that overlap in space, it is difficult to
see which node is a member of which network. The membership may even
change over time. It would be useful to be able to display e.g. the SSID
above node icons. INET provides such a visualizer that we demonstrate in
this showcase.

INET version: <var>3.6</var><br>
Source files location: <a href="https://github.com/inet-framework/inet-showcases/tree/master/visualizer/ieee80211" target="_blank"><var>inet/showcases/visualizer/ieee80211</var></a>

About the visualizer
--------------------

In INET, IEEE 802.11 network membership can be visualized by including a
<var>Ieee80211Visualizer</var> module in the simulation. Adding an
<var>IntegratedVisualizer</var> is also an option, because it also
contains a <var>Ieee80211Visualizer</var>. Displaying network membership
is disabled by default, it can be enabled by setting the visualizer's
<var>displayAssociations</var> parameter to `true`.

The <var>Ieee80211Visualizer</var> displays an icon and the SSID above
network nodes which are part of a wifi network. The icons are
color-coded according to the SSID. The icon, colors, and other visual
properties can be configured via parameters of the visualizer.
<!--The icon is also displayed above nodes that create the networks, e.g. access points.-->
<!--Additionally, the icon indicates the signal strength present at the
location of a given node. TODO: how is it indicated? and how does it work?-->

The visualizer's <var>nodeFilter</var> parameter selects which nodes'
memberships are visualized. The <var>interfaceFilter</var> parameter
selects which interfaces are considered in the visualization. By
default, all interfaces of all nodes are considered.

Basic use
---------

The first example simulation demonstrates the visualization with the
default visualizer settings. It can be run by choosing the
<var>OneNetwork</var> configuration from the ini file. The simulation
uses the following network:

<img class="screen" src="simplenetwork.png">

The network contains a <var>WirelessHost</var> and an
<var>AccessPoint</var>. The access point SSID is left at the default
setting, <var>"SSID"</var>. At the beginning of the simulation, the host
will initate association with the access point. When the association
process goes through, the node becomes part of the wireless network, and
this should be indicated by the icon.

The visualization is activated with the visualizer's
<var>displayAssociations</var> parameter:

<p><div class="snippet">
*.visualizer.*.ieee80211Visualizer.displayAssociations = true
</div></p>

When the simulation is run for a while, the network will look like the
following. Note the icons above the host and the access point.

<img class="screen" src="displayassoc.png">

Multiple networks
-----------------

The following example simulation demonstrates the visualization when
multiple networks are present. The simulation can be run by choosing the
<var>MultipleNetworks</var> configuration from the ini file.

The network contains two <var>AccessPoints</var> with different SSIDs,
and three <var>WirelessHosts</var> configured to associate with each. We
will see the icons being color-coded. When the association processes
take place, the network will look like the following. Note the different
SSIDs (`alpha`, `bravo`) and the colors.

<img class="screen" src="advanced.png"> <!--
TODO
There are 2 wireless networks, with different colors.
The icon indicates signal strength. The node close to access point alpha has the strongest signal,
the node farther away from access point alpha has the second strongest.
The wall reduces the strength of the signal from access point bravo. It depends on distance as well.
So, A1 has 4 bars, A2 3 bars, B1 2 bars, B2 one bar. Or something like that.
-->

Visualizing handover
--------------------

The following example simulation shows how visualization can help you
follow handovers in the network. The simulation can be run by choosing
the <var>VisualizingHandover</var> configuration from the ini file. The
network contains two <var>AccessPoints</var> with different SSIDs,
<var>alpha</var> and <var>bravo</var>. There is also a
<var>WirelessHost</var> which is configured to move horizontally back
and forth between the two access points. Transmission powers are
configured so that when a host gets near one access point, it will go
out of the range of the other access point. This will trigger a
handover.

The communication ranges of the access points are visualized as blue
circles. The following animation shows what happens when the simulation
is run. Note how the indicator above the host changes after each
handover.

<video controls loop autoplay src="handover9.mp4" width="580" height="500" onclick="this.paused ? this.play() : this.pause();">
</video>

Further information
-------------------

For more information on IEEE 802.11 visualization, see the
<var>Ieee80211visualizer</var> NED documentation.

Discussion
----------

Use <a href="https://github.com/inet-framework/inet-showcases/issues/4" target="_blank">this page</a> 
in the GitHub issue tracker for commenting on this showcase.


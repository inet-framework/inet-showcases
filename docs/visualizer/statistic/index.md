---
layout: page
title: Visualizing Statistics
---

Goals
-----

Usually statistics collected while the simulation is running are
analyzed only after the simulation has concluded. In contrast, while the
simulation is running it is difficult to follow what's happening in the
model in terms of statistics. For example, in a video streaming network,
seeing the throughput for each client gives a quick overview whether the
model is working as expected.

Statistics collected by submodules can be visualized at network nodes,
on the top level canvas. This could help in troubleshooting and in the
early detection of problems in simulation models. This showcase contains
two example simulations, showing the basics and the more advanced
features of the visualization.

TODO: what advanced features?

INET version: <var>3.6</var><br>
Source files location: <a href="https://github.com/inet-framework/inet-showcases/tree/master/visualizer/statistic" target="_blank"><var>inet/showcases/visualizer/statistic</var></a>

About the visualizer
--------------------

The <var>StatisticVisualizer</var> (included in the network as part of
<var>IntegratedVisualizer</var>) is capable of displaying multiple
statistics for multiple network nodes. The visualizer keeps track of the
last values of statistics, and displays them next to the icon of the
network node.

It subscribes for the signal selected with the <var>signalName</var>
parameter, and displays the statistic selected with the
<var>statisticName</var> parameter. It displays the stastitic of modules
that match the expression of the <var>sourceFilter</var> parameter, at
the network node that contains the modules. By default, the
<var>stastisticName</var> is the same as the <var>signalName</var>.

TODO: elaborate on the multiple statistics

The <var>format</var> parameter is a string that specifies how the
visualizer displays the statistic value. The format string can contain
the following directives:

-   %s: signal name
-   %n: statistic name
-   %v: statistic value
-   %u: statistic unit

The default setting for the format string is <var>"%n %v %u"</var>, i.e.
it displays the statistic name, followed by the value and the unit. The
<var>unit</var> parameter selects what unit to display the value in. By
default, it is the unit of the statistic.

Displaying round trip time of ping packets
------------------------------------------

In the first example simulation, a wireless node will ping another
wireless node. We will display the round trip time of ping packets above
source node. The simulation can be run by choosing the
<var>PingRtt</var> configuration from the ini file. The simulation uses
the following simple network:

<img class="screen" src="rttnetwork.png">

The network contains two <var>AdhocHosts</var>. The hosts are
stationary, and <var>source</var> is configured to ping
<var>destination</var>.

The configuration of the visualization in omnetpp.ini is the following:

<p><pre class="snippet" style="border-radius: 0;">
*.visualizer.*.statisticVisualizer.signalName = "rtt"
*.visualizer.*.statisticVisualizer.unit = "ms"
*.visualizer.*.statisticVisualizer.sourceFilter = "**.pingApp[*]"
</pre></p>

The signal name is set to <var>rtt</var>, and since there is no
statistic name specified, it is also the statistic name. The unit of the
statistic is seconds, but the visualizer is set to display the value in
milliseconds. The <var>sourceFilter</var> is not strictly required for
this configuration to work, because the <var>signalName</var> parameter
is fully specific. The <var>rtt</var> signal is only emitted by
<var>pingApp</var> modules, so the default value of
<var>sourceFilter</var>, which matches all modules, would suffice. The
statistic is only displayed above <var>source</var>, because
<var>destination's</var> ping application doesn't send any ping packets,
thus there is no round trip time statistic to display.

Displaying packet error rate
----------------------------

In the second example simulation, a wireless node will send UDP packets
to another wireless node as the distance between them incrases. We will
display the packet error rate statistic of the received packet at the
receiving node. The simulation can be run by choosing
<var>PacketErrorRate</var> from the ini file. The simulation uses the
following network:

<img class="screen" src="pernetwork.png">

The network contains two <var>AdhocHosts</var>. One of them, the
<var>source</var>, is stationary, while the <var>destination</var> is
configured to move horizontally back and forth between its stating
position and the right border of the playground. The <var>source</var>
is configured to send UDP packets to <var>destination</var>.

The visualizer is configured to display the packet error rate statistic
of destination host's <var>radio</var> module:

<p><div class="snippet">
*.visualizer.*.statisticVisualizer.signalName = "packetErrorRate"
*.visualizer.*.statisticVisualizer.sourceFilter = "*.destination.wlan[*].radio"
</div></p>

This animation illustrates what happens when the simulation is run:

<p><video controls autoplay loop onclick="this.paused ? this.play() : this.pause();" src="statisticvisualizer5.mp4" width="823px" height="420px"></video></p>

After the first packet exchange, the packet error rate statistic is
displayed above <var>destination</var>. As the simulation progresses,
<var>destination</var> starts moving away from <var>source</var>, while
<var>source</var> is sending UDP packets to <var>destination</var>.
Initially, <var>destination's</var> packet error rate statistic is zero,
because the hosts are close to each other, and the transmissions are
received correctly. As their distance increases, the packet error rate
begins to grow. It becomes one near the edge of <var>source's</var>
communication range (displayed as a blue circle). A packet error rate of
one means that no packets are received correctly. The packet error rate
doesn't become one at exactly the communication range circle, because
the circle is an estimation of <var>source's</var> communication range.
When <var>destination</var> turns back and gets into the range again,
the packet error rate starts to decrease, reaching zero when it gets
close to <var>source</var>.

Further information
-------------------

For further information, refer to the <var>InfoVisualizer</var> NED
documentation.

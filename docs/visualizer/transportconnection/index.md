---
layout: page
title: Visualizing Transport Connections
---

## Goals

In a large network with a complex topology, there might be many
transport layer applications, and many nodes communicating. In such a
case, it might be difficult to see which nodes communicate with which,
or if there is any communication at all. Transport connection
visualization makes it easy to get information about the active
transport connections in the network at a glance. Visualization makes it
easy to identify connections by their two endpoints, and to tell
different connections apart. It also gives a quick overview about the
number of connections in individual nodes and the whole network.

This showcase demonstrates the visualization of TCP connections via two
example simulations.

INET version: <var>3.6</var><br>
Source files location: <a href="https://github.com/inet-framework/inet-showcases/tree/master/visualizer/transportconnection" target="_blank"><var>inet/showcases/visualizer/transportconnection</var></a>

## About the visualizer

The <var>TransportConnectionVisualizer</var> (also part of
<var>IntegratedVisualizer</var>) displays color-coded icons above the
two endpoints of an active, established transport layer level
connection. The icons will appear when the connection is established,
and disappear when it is closed. Naturally, there can be multiple
connections open at a node, thus there can be multiple icons. Icons have
the same color at both ends of the connection. In addition to colors,
letter codes (A, B, AA, ...) may also be displayed to help in
identifying connections. Note that this visualizer does not display the
paths the packets take. If you are interested in that, take a look at
<var>TransportRouteVisualizer</var>, covered in the <a href="../transportpathactivity" target="_blank">Visualizing Transport Path Activity</a> showcase.

The visualization is turned off by default, it can be turned on by
setting the <var>displayTransportConnections</var> parameter of the
visualizer to <var>true</var>.

It is possible to filter the connections being visualized. By default,
all connections are included. Filtering by hosts and port numbers can be
achieved by setting the <var>sourcePortFilter</var>,
<var>destinationPortFilter</var>, <var>sourceNodeFilter</var> and
<var>destinationNodeFilter</var> parameters.

The icon, colors and other visual properties can be configured by
setting the visualizer's parameters.

## Enabling the visualization of transport connections

The first example simulation, configured in the
<var>EnablingVisualization</var> section of the ini file, demonstrates
the visualization with default settings. This example simulation uses
the following network: 

<img class="screen" src="simplenetwork.png">

The network contains two <var>StandardHosts</var> connected to each
other, each containing a TCP application. IP addresses and routing
tables are configured by a <var>IPv4NetworkConfigurator</var> module.
The visualizer module is a <var>TransportConnectionVisualizer</var>. The
application in <var>host1</var> is configured to open a TCP connection
to <var>host2</var>, and send data to it. The visualization of transport
connections is enabled with the visualizer's
<var>displayTransportConnections</var> parameter:

<p><div class="snippet">
*.visualizer.*.displayTransportConnections = true
</div></p>

After the simulation is run for a while and the TCP connection is
established, the icons representing the endpoints of the TCP connection
will appear above the hosts. The network will look like the following:

<img class="screen" src="simpleconnection.png">

## Multiple transport connections

This example simulation demonstrates the visualization of multiple
connections, and the filtering of nodes and ports. It can be run by
choosing the <var>MultipleConnections</var> configuration from the ini
file. It uses the following network:

<img class="screen" src="complexnetwork.png">

There are two <var>StandardHosts</var> connected to a switch, which is
connected via a router to the server, another <var>StandardHost</var>.
IP addresses and routing tables are configured by a
<var>IPv4NetworkConfigurator</var> module. The visualizer module is an
<var>IntegratedVisualizer</var>.

The hosts are configured to open TCP connections to the server:

-   <var>host1</var>: two connections on port 80 (http), one connection
    on port 22 (ssh)
-   <var>host2</var>: one connection on port 80, another one connection
    on port 22

The visualizer is instructed to only visualize connections with
destination port 80:

<p><div class="snippet">
*.visualizer.*.transportConnectionVisualizer.destinationPortFilter = "80"
</div></p>

When the simulation is run and the connections are established, the
network will look like the following. Note that there are several icons
above <var>host1</var> and the server, indicating multiple connections.
Endpoints can be matched by color.

<img class="screen" src="port80.png">

To visualize the connections that use port 22 at the server, the
<var>destinationPortFilter</var> should be set to 22. The network will
look like this:

<img class="screen" src="port22.png">

Additionally, to visualize port 22 connections at <var>host2</var> only,
the <var>sourceNodeFilter</var> parameter should be set to
<var>host2</var>. It looks like this:

<img class="screen" src="port22host2.png"> <!--
To differentiate connections with the same icon color, capital letters are displayed on the icon.
-->

## Further information

For more information, refer to the
<var>TransportConnectionVisualizer</var> NED documentation.
